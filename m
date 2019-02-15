Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F9EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:49:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6819A2192D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kwRXdFLk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6819A2192D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KmeDq6Pkzf940HlXRhGZshAVYxig0h7ECZWe+ijDLv0=; b=kwRXdFLkNE8y+i
	NGj4KGlRiZaLLbU9QHeIgfThd4h+r6moTl+3rqF8pAdWc8nMJf7cIXaRQXxfoKUdRxW/HXc8JrRSi
	fB4YxVnhr/616/hHno2L77s92r0KjE9+nIL8evtfzodzZW/o6+AVyrtf6/h+BByKVlMxWwXkmX7bc
	fA+3FVvs6bMU3v8WSEFxDn2nc5yJ1Pv8tmmIp8mgTWVzZs5QDe9bipXslTWwQTwvAFA3PD/sJ/W+u
	mbTvDIJniCBo8Bj0OgQnXaSpMSmWGaGvia+zmFwn+Yr0IQppCM1PMpWC0fYiqIpbJ72+9TRPMLAET
	YvlMRx82Tinn0AjLR/sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guds2-0002ha-32; Fri, 15 Feb 2019 13:49:38 +0000
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gudry-0002hF-HW
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 13:49:35 +0000
Received: by mail-qt1-f194.google.com with SMTP id w4so10940269qtc.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 05:49:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MBw/Pod8wkX1IQvxEqgRS7Wflvc/zg8OZbViWAWKiwc=;
 b=iYwBQIJgjMwX8mYecsaSDodmBmNb55TscCm5JeKnMFcMBkTKARL4cpjEpWIwx1TLxs
 w5Pp9RoZucc+jUL/N4CVTul9psEd1WIk+NVEi/kTQ4O0XFNApt8hWh4+Idr7w3wp/cQ8
 MNCK9UyEUAqyh8NTDh0MNIjQX9qAqlN/hvALm9R0B8VW8Ya9nVD7ad2VMGF8uuQ9fug7
 2LImb4v0yu6oYxxa2c0bGnXshGzkSDj7weCrbbf7kIrMECyOAzYt4JX+poRa89lIGQiE
 g5nbPCSbH1KU15li6RXI4UMNjpXw4tZcQ98tyamN/Fzqxkii4VIDAFwrKMt4119rwn12
 ZNIw==
X-Gm-Message-State: AHQUAuYNnPwM0UggngSyKmPfsRTE4W70IwHy14jezyA/5ClG5+i/S3Io
 IrXA5c9lkXv7VftMky6PucSDHTlqyct1YVciTUI=
X-Google-Smtp-Source: AHgI3IbeFe+r4HyFHx44vkZKdIRTU7h6NrfDjfOxxvffjZcye+3b9jRoeeWomm1r+k95UghXCijssgqk3Gu4PfclTvw=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr7462381qtb.319.1550238573419; 
 Fri, 15 Feb 2019 05:49:33 -0800 (PST)
MIME-Version: 1.0
References: <20190201191720.20464-1-krzk@kernel.org>
 <20190201191720.20464-2-krzk@kernel.org>
In-Reply-To: <20190201191720.20464-2-krzk@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Feb 2019 14:49:16 +0100
Message-ID: <CAK8P3a0CXTc0tAPXcA31EtdFWEANj5c1RbzfkQJMp3RmKg0nWQ@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] ARM: dts: samsung: exynos and s5pv210 for v5.1
To: Krzysztof Kozlowski <krzk@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_054934_577029_9B2BC12E 
X-CRM114-Status: UNSURE (   8.87  )
X-CRM114-Notice: Please train this message.
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
Cc: "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
 <linux-samsung-soc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 arm-soc <arm@kernel.org>, Kukjin Kim <kgene@kernel.org>,
 Olof Johansson <olof@lixom.net>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 1, 2019 at 8:17 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Samsung DTS ARM changes for v5.1
>
> 1. Extend support for Aries family of mobile devices (e.g. Samsung
>    Galaxy S) based on S5Pv210 SoC: DRM Rotator, FIMD, PWM vibrator,
>    power off, touchscreen, Broadcom BCM4329 Bluetooth and cpufreq.
> 2. Remove hardcoded bootargs on Galaxy S family (proper support in
>    U-Boot).
> 3. Fix minor DTC warnings.
> 4. Fix Exynos4412 Odroid X2/U3 conflicting eMMC GPIO settings and regulator
>    properties.
> 5. Fix the eMMC RTSN pin breaking proper reboot on X2.


Pulled into arm/dt, thanks!

     Arnd

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
