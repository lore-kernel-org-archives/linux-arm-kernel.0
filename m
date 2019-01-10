Return-Path: <SRS0=vaNk=PS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C3CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:58:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C78B20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d4b/gu40";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uZkhceZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C78B20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:In-reply-to:Subject:To:
	From:References:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ImFZq1xgC2JLdXDgdBt5PJM88SIXwqmsRQ4gm/AM2sk=; b=d4b/gu406/1R2xb3pC7mtvR/+
	AfFeiGHhBay4bZJ9gu41eTgUGjWkesmBJR48Q53Iv+G3sQTgcQ/jbbyUEIwACAJj4s3ezzL1hOgHu
	6LXhzVwG9K9iRzGWPoOagXEAJpiBLTBJQNa9iOf64GEWLOLUzx7+c4KzwQ7v7C8iV0uviMqOzcf3i
	9eSkmcgAKLhdh9l+UuSS/Yc91NJOLDfLNtoNCqAy40YqzqhA3zJsk9kuR6sVGfyGpooysxMDTy3pT
	J/yltMAp6sILKHzFLHXXPYe/S/g+0Eq2q0IgS1TVg+OIHFj2ivoOMyzkxMG8C3ejnaEbRlCujlnSb
	vved5/Ftg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghZv3-0000Ce-MX; Thu, 10 Jan 2019 12:58:45 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghZuy-0000AS-0H
 for linux-arm-kernel@lists.infradead.org; Thu, 10 Jan 2019 12:58:42 +0000
Received: by mail-wr1-x444.google.com with SMTP id t27so11255503wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 04:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version;
 bh=Ghyg2fTNZ6AJK2z+KTbcv4WJQiMtAvnC4S83tmSQRP4=;
 b=uZkhceZfR2py7d6JlA3P0T64RdjXetk+fy7ZlrB/rXbQM1ZqBQslgfCLQDudjuyZIQ
 NzgwTpP32zvzf0WLV4rOKvjxVBOtNL/r90R2A8QMQq92fZCAMeRijpyu+xUh5Qfo4D0m
 SHtucDgiaiGLhMnmexlAvsHqfmORbsxOMsBu215v575BibZeuIIq8QDzZmZPjQ2XWfbn
 tvggYsbWc+98qiQ9alJ/h8qhSqxA2+ygUNcqFKYg24mb9BfoVPkkuNKO+KMjvGy5RK4F
 GK/LDtZozttRlbdiWmhw0swd1IngtGQdbKx/FJw2V9iEBsCwpvxiU9VR86Qc0NcEfDmY
 ViTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=Ghyg2fTNZ6AJK2z+KTbcv4WJQiMtAvnC4S83tmSQRP4=;
 b=Due6uxL6BDvqfAXU2nPyCk/ZrmRUN8Qpig2Tdr0AS1EmbswQjYEEFCc/MasKWt2ifX
 1x/VhNTbTs3LoNeptffhRQxDAZXQhvEZNgCZosfwuOEh3oeccf1Rk/d4nkikFhuYsAGx
 Jh1QNZsY1o71yn6k2XmTWI0zwRSuRFyYSjpzAsGXVEBle4IhwPZdo6TtROOCzbBrZFSM
 318g2K7BZOv5pZZcFp6tJ8B0C735zqS/f4MOreGFESMSjCDui3YPEoFCOGbWsm0N5yMZ
 JXK3vOjr9832m9COElLCTqMwgCJeT1/cJGYEEwvu8X8l48j6nakTqkNknA84PltKrSVG
 FX/g==
X-Gm-Message-State: AJcUukfp4+9mI51qnT2UySOhfr/yBRRiUdHNtFoxpfs7YoNNin/Mw5Mn
 HbjZyfo1EuTDYZBy0GpHgwIqsQ==
X-Google-Smtp-Source: ALg8bN7ZvUqgP30iZI3R3hJE7O5uNU4561ChgR0QgZwSUBjUeUDw23zKFoy1+ebR3rzZufclLCwtsA==
X-Received: by 2002:adf:a58a:: with SMTP id g10mr9030831wrc.3.1547125118267;
 Thu, 10 Jan 2019 04:58:38 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:f5ef])
 by smtp.gmail.com with ESMTPSA id v16sm49800567wrs.75.2019.01.10.04.58.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 04:58:37 -0800 (PST)
References: <1547042198-17601-1-git-send-email-lollivier@baylibre.com>
 <CACRpkdbhVB7-Y9EBhBC6GAxqFt8zujS2QJ4CzGDJnDMDjj2Ptg@mail.gmail.com>
 <CAFBinCBf+yJu4z1JYNdH7B4h07-U_0ckysV_=nC65nd5ByOCvA@mail.gmail.com>
User-agent: mu4e 1.0; emacs 25.3.2
From: Loys Ollivier <lollivier@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2] arm64: dts: meson: Fix mmc cd-gpio polarity
In-reply-to: <CAFBinCBf+yJu4z1JYNdH7B4h07-U_0ckysV_=nC65nd5ByOCvA@mail.gmail.com>
Date: Thu, 10 Jan 2019 13:58:35 +0100
Message-ID: <861s5ku0sk.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_045840_136830_A56FB641 
X-CRM114-Status: GOOD (  16.98  )
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Loys Ollivier <lollivier@baylibre.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Jerome Brunet <jbrunet@baylibre.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed 09 Jan 2019 at 22:14, Martin Blumenstingl wrote:

> Hi,
>
> On Wed, Jan 9, 2019 at 7:31 PM Linus Walleij <linus.walleij@linaro.org> 
> wrote:
>>
>> Hi Ollivier!
>>
>> On Wed, Jan 9, 2019 at 2:56 PM Loys Ollivier <lollivier@baylibre.com> 
>> wrote:
>>
>> > Commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
>> > changed the behavior of "cd-inverted" to follow the device tree bindings
>> > specification.
>> > Lines specifying "cd-inverted" are now "acitve high".
> there's a typo in the description - it should be "active"
>
Thanks I'll fix it.
>> >
>> > Fix the SD card for meson by setting the cd-gpio as "active low" 
>> > according
>> > to the boards specifications.
>> >
>> > Fixes: 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
>> > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>> >
>> > v2: fix more occurences, also in other meson boards.
>>
>> This is a good change in itself since it gets rid of some occasions
>> of the dreaded "cd-inverted" property. I think Martin Blumenstingl
>> already sent patches like these though (I might be confused).
> I sent patches for the 32-bit Amlogic SoCs
> my TODO-list is now a bit longer, I'll test this series on my Khadas
> VIM, VIM2 and Libretech CC during the weekend
>
I have seen Martin's patch for the arm boards.
This adresses arm64 boards.
Tested on libretech-cc.

>> But we should keep the old device trees working as well.
>> Can you test if Martins patch:
>> https://marc.info/?l=linux-mmc&m=154637189021211&w=2
>>
>> Also makes your boards work?
> feedback on that patch is appreciated
>
Answered to the patch mail directly. Tested on libretech-cc, it works.
Fixing the meson boards DT for future release would still be valid imho.

>
> Regards
> Martin

Best,
Loys
-- 
-L

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
