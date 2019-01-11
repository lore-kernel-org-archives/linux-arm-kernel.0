Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913FDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:56:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9C520836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cc81t5Wi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lREnOr2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9C520836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cVLJ3XCPldgit3g2FQKk5W0kWQXN0EFvAgeFgN+rFVU=; b=cc81t5Wi6iWkUU
	6k1TaVz2uSOr/O6XF4xByLXmeKJUYgryvsAzZxOrimttBny8V+X0VOGQPY1/odrgO8yoF7Y3v3Ezo
	xrOcHxWUAwLmFZ451YjNGKKNMVR5J3HGEFfznYEt/jHhIeuyOQ8uyFW74eZDyp9PmHQyLSr8Bmljj
	tddRvftlKvPK88jciH1dyjV84cu1cj+D471ja5HiPHDt5qUDQaa4eEOzo/0nkfTR9YtE2BQ1HWskd
	D5fJK87GyAEiz4r8d8jbxMOzvF0Z9+G1mZXBfJqomDiVN37fULozlqk9QALhpXdPTN1B65mNDtfdA
	J6Q4qeagbOuP6ryyqKkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi2uR-0002nY-W8; Fri, 11 Jan 2019 19:56:04 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi2uN-0002mI-RX
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 19:56:01 +0000
Received: by mail-pl1-x641.google.com with SMTP id p8so7214739plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 11:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=OEko4Q1k2V9fZxblUwJN/ehB2KPRXcsUj+UxLIJ/99E=;
 b=lREnOr2Ab7Kk0yTYlqBE4YoNQuckrSl/N1T7ZYdoiFR8nIrOc5ApkvV3G4eTPNrOdw
 uSj15PfeBjfHhUSAtIAorUyKZuqAO+zw/2CYIE8C1vDGOhR+Q4qSl0RPqc3fm1eAyzN1
 6O/s6BKzHyPPuT0PDA1QAbLYOl2/eoY0qN5Fv9pXO0DaRRnd9Ucb5ThU7+M9/cH6ri0s
 omlTZ6o3vAw37lLxsBheXZbVEc6RTZ/Z2M86lVmk+pmDPYibEEBWvuuHPF8l4z7O48Y/
 mIvsE0TWTzuZz3UrqUZWJ6uZyeoklRaUswl90hxYN0UHG/Pq2xzXhjEdI0Ra20BzG5c0
 0kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=OEko4Q1k2V9fZxblUwJN/ehB2KPRXcsUj+UxLIJ/99E=;
 b=NXQ3L5hZ+QuFE+SJexWdBlAiPP73jNEHbimwTNmVI1dWw9LzwCKgDjObrz9KbK+sq5
 5U3maeuI/WNGf/qnz/bT9/Az3F5Kbo2HmCdiGPFcSEZTMohRlGL2AAKLLJU03wDJbDNc
 VUoO+84nBieBbIxJ+Z1R6uRzxFrbmubjP/bo7eLBCeGdlyA0/IwEXK3CWd2CUWdzzSTh
 Gvge4Fj+1sb2BDEUNHU0hhOtW0OwxJRz+nNg2GY/PY4B3owGDSJxVygRDSMlKlmb36gZ
 6rQ6biK+t/JNA8g9NhtsRBW0YSmUMWcX+cDEoL05iE11PAvk6DS6RgXNTeJ8QmyeZiku
 HUHg==
X-Gm-Message-State: AJcUukenGfRkcdAxmadievu2GF+1+7rN1oHHLndqNn4XI/01tEe2HTES
 i5ihA+JDwXkC0Wzsb/bg1/Nu5A==
X-Google-Smtp-Source: ALg8bN5L/trq5QYIz/32j0sWyti7NW7gpTBlSWdiqFsYW+rU55NoRqzkkchPuRExl5FjqljMxD/VJQ==
X-Received: by 2002:a17:902:9047:: with SMTP id
 w7mr16117360plz.270.1547236558983; 
 Fri, 11 Jan 2019 11:55:58 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id c7sm110659515pfa.24.2019.01.11.11.55.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 11 Jan 2019 11:55:58 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Loys Ollivier <lollivier@baylibre.com>
Subject: Re: [PATCH v3] arm64: dts: meson: Fix mmc cd-gpios polarity
In-Reply-To: <CAFBinCDM4BTx0Ude-M=O6B2bXPE9EdfD=VxZfFzR9Dc=yT+xWQ@mail.gmail.com>
References: <1547134822-18498-1-git-send-email-lollivier@baylibre.com>
 <CAFBinCDM4BTx0Ude-M=O6B2bXPE9EdfD=VxZfFzR9Dc=yT+xWQ@mail.gmail.com>
Date: Fri, 11 Jan 2019 11:55:57 -0800
Message-ID: <7hy37rm0j6.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_115559_893464_19A69B9A 
X-CRM114-Status: GOOD (  13.94  )
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
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi,
>
> some nit-picks as well as my Tested-by (in case it's not too late) below.
> thank you for taking care of this!
>
> On Thu, Jan 10, 2019 at 4:40 PM Loys Ollivier <lollivier@baylibre.com> wrote:
>>
>> Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
>> changed the behavior of "cd-inverted" to follow the device tree bindings
>> specification.
>> Lines specifying "cd-inverted" are now "active high".
> this depends on the polarity from the cd-gpios property. above commit
> caused cd-inverted to be applied twice (effectively making it a
> no-op). thus "cd-inverted" only means "active high" if cd-gpios also
> sets GPIO_ACTIVE_HIGH. if the polarity in cd-gpios is GPIO_ACTIVE_LOW
> together with "cd-inverted" then the GPIO will be treated as active
> low.
>
>> Fix the SD card for meson by setting the cd-gpios as "active low" according
>> to the boards specifications.
> not only switching to GPIO_ACTIVE_LOW, also dropping "cd-inverted"
>
>> Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> in my patches for the 32-bit boards I used the commit which added SD
> card support to the board for the Fixes tag. however, I'm fine with
> this as well (I just wanted to point out that there's a small
> difference in our commits).
>
>> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> on my Khadas VIM(1), using Kevin's v5.0/fixes branch:
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

I can add this tested-by tag in my v5.0/fixes branch for now, and can
replace it with a follow up if Loys can update the changelog with your
suggestions/clarifications.

Thanks,

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
