Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D33C43444
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:37:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A1A2133F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="txd02B96";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hgrOev/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A1A2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RamfZi/77wi5ahQQYI7fUqdnkNJ/kIIbWB20TcjU7HE=; b=txd02B96ESltPU
	smQkK2r8a0X/sbOiJD78a/puMPur4uzerNRtPmkAMcRDDk/xxiqOIb8CI9J3I/hv4lE0xsK4BAqAy
	MMTcEvefLpTQeNy9cpoczS+wRNezVfxSi7eRHx9TY92Wi0QS6S/EWg1ggfe5cJ3+ckcquumNIFIxS
	bAsWQCuLgPZJ+HFKafFVoksaFGQ5c2fMJR9ccmAFBGq+BOhN2ErDMw8Me/NZ6FgGU3ihLkcSnCSWS
	SqC5eB8VfJl6d9xYyf2d2vYmju5gs9xHUWcZPhEsCXFImH6SsbVWSMK2OWRWw65N6Ouctu8M/tNfI
	unaf1EaEXJ+pIBeTXrmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghkpU-0007YN-2q; Fri, 11 Jan 2019 00:37:44 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghkpC-0007HB-KH
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 00:37:38 +0000
Received: by mail-pf1-x442.google.com with SMTP id z9so6101007pfi.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 10 Jan 2019 16:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=tArBfX2/yWTLPAN6WGgGaPqHLNX3JSZr3+h2fOti0lQ=;
 b=hgrOev/AEn0v0YbfqI/buSHdETAPA0YE2mVEthVtuL5d9OOlMaebfPCSRubZ46m9sz
 1k4Ygnp4f8xIWh8SMdjpp0AqPWb5bSEF40iXR1/V660S40VZjGnC7HQbEm596g9C2ozU
 pqTmRIrjkmPYqqHxZXHDCwyM4p3tJfIrr40Ov84pTrJQ2ZRP7CejJ2yKFxlO+2L2+6qE
 f6bfhAYPJJG7TM9zGNN7+lwXrVFXvOs3xwcbHZZ04mL/RAKizYD5l3aFbYMY/1Z4d1Qd
 VcKNjKznuPPTe4QRbVWMtvHhspv7oJ6HTiUA1ffGhplSGy1hQHiN3pUddr0Q9Z+4sisG
 uP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=tArBfX2/yWTLPAN6WGgGaPqHLNX3JSZr3+h2fOti0lQ=;
 b=S0xei4kfYagHVhBDaChcsqy/AXy2IBUni8kuFVMejhRtTp/1ZOFkYpvbVJtGcbWzbt
 H5pC3NDbH2X45kOVeGC+nlDpiSfZoWN7/lh5x84iOR9fVTEvOyqADhlhq0S10CTU297+
 s6GEU4MFnQ3O8PqjiSjzGAMHI0EopyCRxOKcaqXikvsQHd9yjq54N+Ov4pg5ZuPY0voF
 qR9Y5WR9i2oBRp3B+7fWEJynxbE3qm1EMOEaSegt/CvvmDmbWiR/0Ru9a4qyuJelYrdj
 uPm0Y+SGrUah5F4giqsOsz/H2fWL7kFKAD6vQr4OETZrtD2SwTlxd0cXD63+BHhPOreA
 EudQ==
X-Gm-Message-State: AJcUukfGBanI45w8w9/ifJxvly2NnUyR1fhpedSVBtQCjx+zX3bgpjc3
 BIg7wPnlBK/Qt8opCzR/j6GZMA==
X-Google-Smtp-Source: ALg8bN7qW+ukQwCDcs13BbWmyGw9xMYTBXwn/X0ez5v/Yn2fH/2jOfGSLy4PDp62AyCkvcUHSPZcvg==
X-Received: by 2002:a63:1b58:: with SMTP id b24mr11203008pgm.247.1547167045786; 
 Thu, 10 Jan 2019 16:37:25 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net.
 [71.197.186.152])
 by smtp.googlemail.com with ESMTPSA id f32sm93544454pgf.80.2019.01.10.16.37.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Jan 2019 16:37:24 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 jbrunet@baylibre.com, robh+dt@kernel.org
Subject: Re: [PATCH 0/5] Meson (32-bit): add support for the Mali GPU
In-Reply-To: <13bd9d3a-3cbe-3952-03bb-ef5da6eec401@baylibre.com>
References: <20181208171247.22238-1-martin.blumenstingl@googlemail.com>
 <13bd9d3a-3cbe-3952-03bb-ef5da6eec401@baylibre.com>
Date: Thu, 10 Jan 2019 16:37:24 -0800
Message-ID: <7hef9kqbaz.fsf@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190110_163727_100468_B6331F55 
X-CRM114-Status: GOOD (  18.83  )
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
Cc: devicetree@vger.kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 08/12/2018 18:12, Martin Blumenstingl wrote:
>> This series adds support for the Mali-450 GPU on Meson8 and Meson8b.
>> Meson6 uses a Mali-400 GPU but since we don't have a clock driver (and
>> I don't have a device for testing) Meson6 is left out in this series.
>> 
>> Meson8 uses a Mali-450 MP6 with six pixel processors. Meson8b (as
>> cost-reduced SoC) uses a Mali-450 MP2 with two pixel processors.
>> I tested both using the open source lima driver and a patched mesa
>> from the lima project as well. Since we don't have display support
>> on the 32-bit SoCs I used off-screen rendering as described in [0].
>> The result is (for example): [1]
>> 
>> The bootloader (at least on my boards) leaves the Mali clock disabled
>> by default. The board crashes when trying to access the Mali registers
>> with the "core" clock disabled.
>> Thus this series also implements the required clock driver changes. The
>> Mali clock tree on Meson8b and Meson8m2 is almost identical to the one
>> on GXBB (see the description of patch #3 for more details). Only Meson8
>> is slightly different as it doesn't have a glitch-free mux. Patch #2
>> prepares the meson8b clock driver so we can have different clocks per
>> SoC.
>> 
>> Dependencies:
>> - the .dts changes depend on my other series "ARM: dts: meson: add the
>>   APB/APB2 busses" from [2]
>> - the .dts changes from this series have no compile-time dependency on
>>   the clock driver changes because CLKID_MALI was defined in the
>>   dt-bindings since the first version of the clock driver (but it was
>>   not used until now).
>> - the .dts changes from this series have a runtime dependency on the
>>   clock driver changes (also from this series) if you have a kernel
>>   patched with the lima driver (without the lima driver there's no
>>   runtime dependency)
>> 
>> Other notes:
>> By default the GPU runs off the XTAL clock (24MHz). The lima driver
>> currently does not update the GPU clock rate. Different frequencies
>> have to be requested by adding the following properties to the Mali
>> GPU node (to run it at 510MHz for example):
>>   assigned-clocks = <&clkc CLKID_MALI>;
>>   assigned-clock-rates = <510000000>;
>> 
>> 
>> [0] https://gitlab.freedesktop.org/lima/web/wikis/home
>> [1] https://abload.de/img/dump0myic0.png
>> [2] https://patchwork.kernel.org/cover/10719445/
>> 
>> 
>> Martin Blumenstingl (5):
>>   dt-bindings: gpu: mali-utgard: add Amlogic Meson8 and Meson8b
>>     compatible
>>   clk: meson: meson8b: use a separate clock table for Meson8
>>   clk: meson: meson8b: add the GPU clock tree
>>   ARM: dts: meson8: add the Mali-450 MP6 GPU
>>   ARM: dts: meson8b: add the Mali-450 MP2 GPU
>> 
>>  .../bindings/gpu/arm,mali-utgard.txt          |   6 +
>>  arch/arm/boot/dts/meson8.dtsi                 |  58 +++
>>  arch/arm/boot/dts/meson8b.dtsi                |  46 +++
>>  drivers/clk/meson/meson8b.c                   | 349 +++++++++++++++++-
>>  drivers/clk/meson/meson8b.h                   |   9 +-
>>  5 files changed, 461 insertions(+), 7 deletions(-)
>> 
>
> Applied patches 2 & 3 to next/drivers for Linux 5.1
>
> Kevin, have fun with the other patches !

Fun was had.

Patches 1, 4, 5 queued for v5.1 (branch: v5.1/dt)

Kevin


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
