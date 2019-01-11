Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C785C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:18:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5668520872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 01:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aRxAj7ID";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2FcMdIQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5668520872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E2X/PQBN5+VAg9jdF4eg48iXkBqZn7cQHkSt4x+yIhQ=; b=aRxAj7IDMk52hI
	kebUZ6XfK60ogrRzXO9Z1XGGhDrQz7c6We3pTR25HyhNtyy+Eu3AdsMIaf2h+7tdekfY5jsIbkawy
	18jS9P5N/bi7c5dlNH0k6Tc1g/WdDhqxgdVEC2G028Adkpqq+VWwVqjP8NnN4tAo3prGSScikcD6o
	YkpFnBWqiafWJgZ7nX09OO5Fr+Twh1bFRHZQGDzqFIzRIVqSjJEKuPsAb0WvkDeRaACBaGFnoF1PH
	SCApcRzoCsSoMecEPMKQvSuLXw9L0bRg/4GPBOLqGSJ2S+umsiAEc4RWNbIfXOUW6qusLLzIydv+8
	ePYeau//KfiGbR6SP8Hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghlTG-0005GZ-Fc; Fri, 11 Jan 2019 01:18:50 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghlT3-0004yO-Px
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 01:18:42 +0000
Received: by mail-pg1-x543.google.com with SMTP id z10so5582160pgp.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 17:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=PdFKV1KT3Neq0x9XFt7j7MB+9Y5E+sjJdGX4nWC217o=;
 b=2FcMdIQYFYVpyDlOJSYBN3FyLjLXakq71Ju5sgmV2QIYdj4c/vLIV903fwtaWKhlDN
 Uh0AxG6JFMfQPcO/seLY51abwBKz0p7B9xEjswovQJUc2ZvEElvOlcSoFVckvl+d12Cq
 mceH5Zn+BVxuSThy+HEp05U0SoQjBgaK7AXU47otd0cj3qxob1xqB5hou3BE/LQyheo0
 33sfESGp6A8sTrNOtSjH72itm7Z4twTDLIZVr8QopWFZJioEUxk0c25iVl3RXLW5MIJ1
 mVgRXAV0akzU1URYC86tKPCTh3MZSwLdChHLv22C7DitQWJ5lXWX+jQGiAwqrkGn4bnZ
 awXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=PdFKV1KT3Neq0x9XFt7j7MB+9Y5E+sjJdGX4nWC217o=;
 b=CYUxIUmZIjSQ3TjhRubFcNCCW2JN2Y9BpYNfH+J5d6M3b6E4WNDR0XnQriC4ehjyVQ
 PcuX3q1oziUzJQj38DAO8xg0rE81zGE1I7YLLh5PP5oUQm/BnAdO/j7tQAPg6Ww23+xX
 y+4SGAhIfXBNlAiIc6UYKUo0JHOdT5kmImuNRlG3O1aTtyKEw+4a+N4N0Xntnx1ezDY+
 jjxyIUS/B5VkRZw3MDCANwyZeCRxdg4lMZ9jxLVnnxw+VbtYl80lZuDy2iX4YkYNaCyu
 b94SzeBJwlkIw4yNE2XDTFKJEdwZOkfueed9qCP61CtwQX4m2ktX3OFeECPf/ohY8bZA
 Jhkw==
X-Gm-Message-State: AJcUukciXHhe1tkbwNH9igA/N8ma8C+hbh9fZ7uNh/3jcbKuFU48RVGq
 S+VYlhizJcsUjeQ2YW29XOLNMw==
X-Google-Smtp-Source: ALg8bN6axzqsgERZKU63LGGSZAcaAO0zyWxhNsChPHZgxqtArfSmr1l12BAtv928Jsy1NnkM46hvzg==
X-Received: by 2002:a63:77ce:: with SMTP id s197mr1396406pgc.89.1547169516617; 
 Thu, 10 Jan 2019 17:18:36 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152]) by smtp.googlemail.com with ESMTPSA id
 x26sm112702953pfn.50.2019.01.10.17.18.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 17:18:23 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linus.walleij@linaro.org
Subject: Re: [PATCH 0/3] ARM: dts: meson: fix SD card cd-gpio (pre v4.21-rc)
In-Reply-To: <CAFBinCCpsy40NuB124TqDUWy9zogeMrLsCGCanbbvpfd-yVDdQ@mail.gmail.com>
References: <20181229125711.5205-1-martin.blumenstingl@googlemail.com>
 <CAFBinCCpsy40NuB124TqDUWy9zogeMrLsCGCanbbvpfd-yVDdQ@mail.gmail.com>
Date: Thu, 10 Jan 2019 17:18:16 -0800
Message-ID: <7ho98oouuf.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_171838_474498_A2548DFE 
X-CRM114-Status: GOOD (  11.58  )
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
Cc: linus.luessing@c0d3.blue, bgolaszewski@baylibre.com, balbes-150@yandex.ru,
 linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux@roeck-us.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> On Sat, Dec 29, 2018 at 1:57 PM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
>>
>> Today I noticed that my Odroid-C1 doesn't see it's SD card anymore.
>> My board is not the only one, Odroid-C1 on KernelCI suffers from the
>> same problem:
>> v4.20-6428-g00c569b567c7 still sees the SD card (mmc0): [0]
>> v4.20-8955-g903b77c63167 doesn't see the SD card (mmc0) anymore: [1]
>>
>> My Endless Mini (EC-100) is also affected by this issue.
>>
>> a git bisect run points to this commit:
>> 89a5e15bcba87df5120d4656e0ff33d4f7cd6152 ("gpio/mmc/of: Respect polarity
>> in the device tree")
>>
>> and indeed, reverting it makes my Odroid-C1 and EC-100 see the SD card
>> again.
> I started a separate discussion for that topic on the linux-mmc and
> linux-gpio mailing list for this topic: [0]
>
> comments regarding this series are still welcome!

Like Linus mentioned, fixing the DTs is still important, so queuing as
fixes for v5.0-rc (branch v4.21/fixes)

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
