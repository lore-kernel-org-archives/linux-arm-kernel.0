Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45B5C4151A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:24:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C192148E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L0o9n1rY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NMSowhbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C192148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=10g1G5hJzJeLJ853IzANGhATHYIP9UbjCGwnPVP1eQ0=; b=L0o9n1rYKYgJTF
	BD6/P3zLSJarlYwAkyOmEllCNqSOJmAFB9+oLj53fOrwKK9xWzjuGySflafdxK9pXgGydCVmE6fTH
	8S1vd3YtGrEsYxGrFlHSOfFv0IgE8V8jEpkXgjVqJnFiIUgJ6LFHRM8oNozevoVSCQ0ntn5GxIbd4
	R8pi5Fgmig6+CWCo0LmhRs4wKR1zqB/M3CT71mLe9GEbmIWn2rMB0fvOYYf4RbVxtFoKnPwfNMRLH
	W+RMZwW+1+J7ff0FjQnVzSAwN8pKD8b35dz3uEGxNhzGlxKyAa8qs5wCues9Fzf1pLx0tFEdMRr0b
	wq+p+grQNtPJhw0nByVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goQZ7-0000NM-Mg; Tue, 29 Jan 2019 10:24:25 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goQZ3-0000MH-N0
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 10:24:23 +0000
Received: by mail-wr1-x443.google.com with SMTP id q18so21375366wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 02:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=XIWwWKt6+oCOO6cq2DZHb0F9eETVOES12psz3Sr+1T8=;
 b=NMSowhbEAadq0sol8vCSD6RPOw6gzLfVzMboboIzUBYoBTZEkL0uv73xb2H7pHY+9i
 FmXZ9lTnYyTw4DNIdyJ0TRNqGTVteuB2uxG++EfKMEPhTHJZnkUpkVDa7xUOV8KURJ3s
 Y+Kzp9mRZHkB+C3hXPhpWCPjXGQlAr/nta2QcIT5gCb7CAE7xOHmsJsKDTH+j4ZzX4ep
 //p1w8nerEUkGGfkni2Cqz/AZgac+EKRulTvQih8iL2LrR7qX3Ul4cuTOAqsU99JPrHy
 g8okrIHedoFg8w4ztgiVVWOps9Qa4XiJgTYKbY8Hk+GLTk220ADZDKoV8pRLmncyQbwR
 9Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=XIWwWKt6+oCOO6cq2DZHb0F9eETVOES12psz3Sr+1T8=;
 b=QklR+69xlpI825h4YQG0H63d5+l1/aGG0agtObH/aR1KPXkudz/n1eEIA2emeZPfWA
 /FOHuBli2tg+gk6ReQWZIuOjBk/c37s+4nM0Ou1Y3IDBMym9dhV3+UOtFEO6dSD+Awez
 sl6qAiDImZzZz8MetceFur4plEP5sTzvGAYSo5Iz6ydRPcWFv6V9dgXsezmSRCppGDpo
 Yyxko+sIIdd2ywTM0MRhndsalVLKkSJ1pHu5rbhHiLfEN9or4WGC00AHFWp9ypoGZWGu
 i2Ur0+9n56+oM6mwPDeLh20T+tG3Nh+AojhuyVHJlIFkN6L7l0RUziYIIhWm4N1Nb4lY
 IaJA==
X-Gm-Message-State: AJcUukejywac5l8EKkmNZqAE6t7+I5pkoUcbVhgbemh+CeFX0Obyvd//
 xNDMmdm6CKNBPKLslGbyovGfOg==
X-Google-Smtp-Source: ALg8bN6YajtzxgYWfRDSV2s0O4N8XF9CMQ3zgRKk1+I8NpKTZ+iAvmK5GNgDrfA9guKccz3fDOGXfg==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr26692099wrn.27.1548757459920; 
 Tue, 29 Jan 2019 02:24:19 -0800 (PST)
Received: from localhost (aputeaux-684-1-12-29.w90-86.abo.wanadoo.fr.
 [90.86.215.29])
 by smtp.googlemail.com with ESMTPSA id 129sm3442270wmd.18.2019.01.29.02.24.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 02:24:19 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [GIT PULL] Amlogic fixes for v5.0-rc, round 2
In-Reply-To: <CANAwSgQzXg0MW4bH=NpbxmZ6a0bf7rr0F4_gP+bDUMurJsA9bQ@mail.gmail.com>
References: <7hh8dsqyv8.fsf@baylibre.com>
 <CANAwSgQzXg0MW4bH=NpbxmZ6a0bf7rr0F4_gP+bDUMurJsA9bQ@mail.gmail.com>
Date: Tue, 29 Jan 2019 11:24:18 +0100
Message-ID: <7hk1inpxrh.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_022421_751019_56B8A298 
X-CRM114-Status: GOOD (  12.06  )
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

> Hi Kevin,
>
> On Tue, 29 Jan 2019 at 02:33, Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Olof, Arnd,
>>
>> Below is round 2 of Amlogic fixes for v5.0-rc, based on top of the first
>> round.
>>
>> Kevin
>>
>>
>> The following changes since commit 19a220dd1e8a1b1d8e5e2f8f4a25313c4b02d527:
>>
>>   arm64: defconfig: enable modules for amlogic s400 sound card (2019-01-08 15:27:50 -0800)
>>
>> are available in the Git repository at:
>>
>>   https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes-2
>>
>> for you to fetch changes up to c90c44d8aaf5895320da1621b0a502ed5528e437:
>>
>>   ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning (2019-01-17 14:40:45 -0800)
>>
>> ----------------------------------------------------------------
>> Amlogic fixes for v5.0-rc, round 2
>> - several fixups for the GPIO cd-inverted change
>> - IRQ trigger fixes for MAC IRQ
>> - USB PHY reset/power fixes
>>
>> ----------------------------------------------------------------
>> Anand Moon (2):
>>       ARM64: dts: meson-gxbb-odroidc2: Fix usb phy regulator power failed warning
>>       ARM64: dts: meson-gxbb-odroidc2: Fix usb phy reset warning
>>
>
> Sorry I would like to resend my patch again, just waiting for feedback
> on below patch.
>
> [0] https://www.spinics.net/lists/arm-kernel/msg701859.html
>
> I will resend send these patches.,
> so please drop above patches for now.
> Sorry for the trouble.

I already dropped your odroid-c1 (32-bit) patches as you requested, but
these are for odroid-c2 (64-bit). You want me to drop those also?

Kevin

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
