Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA7AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:30:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A267620651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EdF7paP4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="L6aZMDkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A267620651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:In-reply-to:Subject:To:
	From:References:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=co9lpSzsIdBE5m0j9txcEN5O28Z6+4T3VthDZN+RhfE=; b=EdF7paP49sSI2A+iPntZCy3kY
	/QvDo13B05lVPJ4u0g/ivtJX1VuJo7kR/CXb5WHoRvVruMYyVrak0dRxrjNV1TLs5lACO8TAFtHQ0
	GjaorNWYccKhUQij2gx832mLhvRl1WtmBuw5oRS68JtlqVNQWHJ5zFYkS1rbtlsuVS0Med01nGbV7
	8o+wEwyO4U5eSfUyKjJGbLHRImhoMiw65r9/wukWeJAkKWbuHdWoRKbVfs4Sse3tMfzGRPFLV5akE
	e5AKeANwdi8OflzpObpP2ysnp2/gjyIItiatB6hjHa3EZymm/Wld6zDnFZh8P5k/huaEt7gRmtpti
	02sNqchrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2Jy-0000UG-RC; Mon, 14 Jan 2019 13:30:30 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2Ju-0000Sw-1S
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:30:28 +0000
Received: by mail-wm1-x342.google.com with SMTP id g67so8830125wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 14 Jan 2019 05:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=m+dqoUTZ553nDWQVkK+5miIXYXnjGts+7dZ1viX+uA0=;
 b=L6aZMDkn0eXQpSur/59udmyHKkaaqYwVzoCYf8j2+nP6g+CvW/03enBcLIM3yUGvP6
 azqss3Nh/1NvgSnfTRVq+l/zdWPpi4pimmTjWfZ26dVPWyHviJrLsma20gQoBhaF7eBl
 bs+yyQ5vTi8wGO89Rdpw4T7wNmAmCQez12XjPP0rgy6aAmqwpHMBAXYyj1GARHOHcIO/
 4+woaaNHLLMcGeB8rVn+QT59stAKLeqPPv2KVsUHelSKJPm8AeB6IDgBgd37D1LGKROf
 zjJBUBAcAurH6t4pccnNOYz0wnFBy8TsXDKFAx6SblfKjndg3cpqXpAd3pYvXBB3ndh/
 Tfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=m+dqoUTZ553nDWQVkK+5miIXYXnjGts+7dZ1viX+uA0=;
 b=c6TaUdTDab3ixxq+pv09EtvzcYvjjSW8QG6wKhP41EYpWRcfYGvHbNxTqzBmHfJSKM
 IbOT9GVEZg4CHuPpUeFTTV8/t5yIFQfQpH34TnW6qDsBFsBRfpS6L0vCDp9SvGLrrQmJ
 +LKg5Yr4iO07MmIcGOUi4si+qxjGWQWb+7AbfEJXt2+9OCStacYxy4u6MKgSIWmLsOoU
 ajt8zcjH/KitOaxKnIhZa8DoPRkrfp0YVM4xHg3aTQdhTK/v8uy070oQTDE9Yyy2PjzA
 uy6nx7CMhp9sA05iW+eMw+9v9tbwbEZfZtEjKKA/GZwy5A2EiCj5Rdd8uDheDLJG/Rfe
 JdUQ==
X-Gm-Message-State: AJcUukd5dXCLNJXGSyiLfDR7nl4Set9zvYqKPqTA6clEoIK4N7wY/nVk
 JV6sjUn9SHqBFo/D2nuCk93NhQ==
X-Google-Smtp-Source: ALg8bN4g7XhzTK3a7x2ZyBppxsQ2dbnyUnSPT2LvpdX3jVsV/BVKMSu4gDm2frVgSD2pvww/Boqx8g==
X-Received: by 2002:a1c:8b44:: with SMTP id n65mr12332007wmd.104.1547472623560; 
 Mon, 14 Jan 2019 05:30:23 -0800 (PST)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr.
 [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id a1sm64329218wrw.76.2019.01.14.05.30.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Jan 2019 05:30:22 -0800 (PST)
References: <1547134822-18498-1-git-send-email-lollivier@baylibre.com>
 <CAFBinCDM4BTx0Ude-M=O6B2bXPE9EdfD=VxZfFzR9Dc=yT+xWQ@mail.gmail.com>
 <7hy37rm0j6.fsf@baylibre.com>
User-agent: mu4e 1.0; emacs 25.3.2
From: Loys Ollivier <lollivier@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3] arm64: dts: meson: Fix mmc cd-gpios polarity
In-reply-to: <7hy37rm0j6.fsf@baylibre.com>
Date: Mon, 14 Jan 2019 14:30:20 +0100
Message-ID: <861s5fmknn.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_053026_080052_5756A693 
X-CRM114-Status: GOOD (  14.06  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Loys Ollivier <lollivier@baylibre.com>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org


Hello,

On Fri 11 Jan 2019 at 19:55, Kevin Hilman wrote:

> Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:
>
>> Hi,
>>
>> some nit-picks as well as my Tested-by (in case it's not too late) below.
>> thank you for taking care of this!
>>
You're welcome !
>> On Thu, Jan 10, 2019 at 4:40 PM Loys Ollivier <lollivier@baylibre.com> 
>> wrote:
>>>
>>> Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
>>> changed the behavior of "cd-inverted" to follow the device tree bindings
>>> specification.
>>> Lines specifying "cd-inverted" are now "active high".
>> this depends on the polarity from the cd-gpios property. above commit
>> caused cd-inverted to be applied twice (effectively making it a
>> no-op). thus "cd-inverted" only means "active high" if cd-gpios also
>> sets GPIO_ACTIVE_HIGH. if the polarity in cd-gpios is GPIO_ACTIVE_LOW
>> together with "cd-inverted" then the GPIO will be treated as active
>> low.
>>
Hum ok so there's more to it than the commit message. I'll come by with
something clearer for a v4. Thank you for the clarification.
>>> Fix the SD card for meson by setting the cd-gpios as "active low" 
>>> according
>>> to the boards specifications.
>> not only switching to GPIO_ACTIVE_LOW, also dropping "cd-inverted"
>>
Indeed.
>>> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
>> in my patches for the 32-bit boards I used the commit which added SD
>> card support to the board for the Fixes tag. however, I'm fine with
>> this as well (I just wanted to point out that there's a small
>> difference in our commits).
>>
OK, I treat fixes tags as:
from the introduction (or discovery) of a regression (or bug), the
"Fixes" commit will patch the commit that introduced the regression.
Hence why I tagged the commit from which the platform was not acting
correctly anymore. If that's fine for you it's fine for me as well :) 
>>> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>> on my Khadas VIM(1), using Kevin's v5.0/fixes branch:
>> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> I can add this tested-by tag in my v5.0/fixes branch for now, and can
> replace it with a follow up if Loys can update the changelog with your
> suggestions/clarifications.
>
Will do.
> Thanks,
>
> Kevin


-- 
-L

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
