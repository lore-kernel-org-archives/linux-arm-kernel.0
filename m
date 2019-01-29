Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC85C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:14:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0D0214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 15:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LQEFzUYZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="bOAusRFS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0D0214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=607iCS0nBwWIWj2y4kxSuj+txnjykgndHRYUylqHa84=; b=LQEFzUYZmuRw4E
	XPLaYnOUXPh4yPe7uSSk+0ow7StRahUTUgwer1gFAD9sXX07i+3WO8dhOimoQnoMr23dMAu5vBqGV
	uILTfDnEODvdgAWpD+Fnbv08AOujbWbok+mtxjNU+o6EXMajEUMn1XyB+xi1TqRqMrO+q+9h1x7QH
	A8vaFOOkOjgNChwt2zS3vvcsbfO9jaCk0kURM7oay8wzHPJiGAF/0yFG2pecfABXQuNJlcANiXZcl
	T/h+ODZj19moLXTbKcFsvWZfcgdOrUC97Nt/sbC8gwS8vgTphnxpusRaycBVSpOKdYwhlbeszG4Xh
	5+lTFrLNin2LhrssaNww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goV5M-0000xf-8l; Tue, 29 Jan 2019 15:14:00 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goV5G-0000wJ-RK
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 15:13:56 +0000
Received: by mail-wr1-x443.google.com with SMTP id s12so22467637wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 07:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=27crw1VW5sqn8gRQ6TWrOWNRWUldhuowUTumXA1nqng=;
 b=bOAusRFSOPtEKq4C8UeENp2l/pPZj8gJ/TYRPuoOwYr1LoRqgyEI6IH1vIBEu8Cl0U
 WWkp4GNnaAh4Hd1iUtv3xJLHTCpGbPfMh/cB/n/aaCgM1RBIVzEQrO65eq7I064FcCWm
 8uW4aHhU7eVxp+h54tdN13R090KJSCeBiyjKYUiFqGkpK8ynpzOhmZCyMq8tgF9+saPk
 MERDTQiWAisPGseeq2hpTspASF3qVW6i37tq5M+v+vID3Wu4R4SspBIPaJHbDB3cyq/T
 zvH7yPn0vcDsabzRv5Y4bFbr1GQ3P1Sie0o0mdUsYiq/XANsIn8Dm61WSQm54fRvDwva
 +KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=27crw1VW5sqn8gRQ6TWrOWNRWUldhuowUTumXA1nqng=;
 b=RBb7vugp2N/59hhEUIoH7e2e+OIodA0EI1MfjFjl4I4NI5mx4XJ6Orcm0j7MmlbuBW
 dqeKzlbiMhCv8a043BXwqgnwdOSVM/IVhHCwdh5oCIRnyIA98z2t5m6cZ8DbTh0ThlTS
 ZHWwwbYMvxrFh7xMVwJh2zPsSvjWa8QkD6Lxp8ZrAPbDIk+ay4eOgQ4fgdYd7Rqz6DXu
 3AJZzE17Dgds0mSNwAw0vDSgP0jahrgg+rm17Bsc8h2pVrHDMw8DRqnBV4fNZ0TggzHp
 ddBLx1UOkgHY9Elx/YW1u/weQcUVW5DCWxJe0mYZ2s0Lb0++UsxOXnm6wj5lOb/JE2DM
 a/hA==
X-Gm-Message-State: AJcUukcqM6Efdusidc6nprsDoRRPdktXQyUEfb8Ev7zsUxGbnQ+3k8CR
 hvmCDb5AbaI1k1/s+wc3Z8i1OA==
X-Google-Smtp-Source: ALg8bN4JoDbGF5m3o8wSNKcglTTPjDs67NF019Xv9tBJBkyZ1Q0u+igBmp7STQr0l8cn/zNYqhqSCw==
X-Received: by 2002:a5d:418b:: with SMTP id m11mr24467282wrp.8.1548774833067; 
 Tue, 29 Jan 2019 07:13:53 -0800 (PST)
Received: from localhost (aputeaux-684-1-12-29.w90-86.abo.wanadoo.fr.
 [90.86.215.29])
 by smtp.googlemail.com with ESMTPSA id k128sm4715177wmd.37.2019.01.29.07.13.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 07:13:52 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [GIT PULL] Amlogic fixes for v5.0-rc, round 2
In-Reply-To: <CANAwSgQkkoj4U9ivptW=NJw0XH4UTqHE7m0-oGZMztou=6MWig@mail.gmail.com>
References: <7hh8dsqyv8.fsf@baylibre.com>
 <CANAwSgQzXg0MW4bH=NpbxmZ6a0bf7rr0F4_gP+bDUMurJsA9bQ@mail.gmail.com>
 <7hk1inpxrh.fsf@baylibre.com>
 <CANAwSgQkkoj4U9ivptW=NJw0XH4UTqHE7m0-oGZMztou=6MWig@mail.gmail.com>
Date: Tue, 29 Jan 2019 16:13:51 +0100
Message-ID: <7hmunjo5sg.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_071354_882944_60B458A0 
X-CRM114-Status: GOOD (  10.68  )
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
Cc: linux-amlogic@lists.infradead.org, arm@kernel.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Anand Moon <linux.amoon@gmail.com> writes:

[...]

>> >> ----------------------------------------------------------------
>> >> Amlogic fixes for v5.0-rc, round 2
>> >> - several fixups for the GPIO cd-inverted change
>> >> - IRQ trigger fixes for MAC IRQ
>> >> - USB PHY reset/power fixes
>> >>
>> >> ----------------------------------------------------------------
>> >> Anand Moon (2):
>> >>       ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator power failed warning
>> >>       ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning
>> >>
>> >
>> > Sorry I would like to resend my patch again, just waiting for feedback
>> > on below patch.
>> >
>> > [0] https://www.spinics.net/lists/arm-kernel/msg701859.html
>> >
>> > I will resend send these patches.,
>> > so please drop above patches for now.
>> > Sorry for the trouble.
>>
>> I already dropped your odroid-c1 (32-bit) patches as you requested, but
>> these are for odroid-c2 (64-bit). You want me to drop those also?

> Yes please, thanks!.
> I have resend with correct changes for review.
> Hope those will fix the issue for now.

OK, I've dropped them and sent a redo of this round 2 pull request.

Arnd, Olof, please ignore this one.  "round 2 (redo)" just sent.

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
