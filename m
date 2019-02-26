Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E77C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:14:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A5F2087C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PJVu/jK4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="w7xlvvSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A5F2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=80zSxrrp/39129ga25mS8ghU5u0hwylWeCXPJjtnWDQ=; b=PJVu/jK4/0pcJW
	YEAjbtFDe0v2/ASHYre7M4wVFDJ57mFhTTPINWYWgZ8WRHALz6HwxiVpl1ueaeFVHlJEBOkMhQyCf
	boBhKBS05PiY8XMTeZbrKIfs3pvW4We42BiMGIz1bMl0SnVq5tajQ+W+tokpXBpmd1dYZv9De5c8b
	IV5p/Qv9oNzSlKTKs4N6pzcUFuKBG2XfRYd5otFjqGkHOhq79zFeE3GGiT/O5NytzW/+0MyWDGlLC
	y/y7UwtLU5goSYvBkzwoijBRWVoNoYqNIQBGe452gd6hbz4jEIpcxaWe2ChingIFz72lxIUW15x2j
	8/QDJgGCIT14Xr56f5Yg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gybdK-0000OI-MN; Tue, 26 Feb 2019 12:14:50 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gybcZ-000802-NM
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 12:14:10 +0000
Received: by mail-wm1-x333.google.com with SMTP id g20so1329097wmh.5
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 04:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Nyp+XvU8Iwf2Gbpf50+YAlGUNo21rB3BtmQX93H+/8=;
 b=w7xlvvSHT+D9QXGWcVXmjqjo+lNl3F30O/fXb4+IWjIQUl4oleryc0fqngzfVrHqhK
 gNk5UEr3iEtxHd7qL9WYnb4PQ8zV2E0HvpRVpYNN+96mAKn7tdTP16GZyG7hrBeVCq/0
 CjftkpijTpqRuw8Xava+zVwuImh8zN7kESwNsiU5zTkg/E0LJuFNvfKu4CvyAY3pHEmO
 Qygv7crr8TWv/S1ZOoxgpRWCqIJfInWSVMgbJTRKQHjXtVHsDPRpG4QVsdYGx/pChmFB
 Gh9mivo+DCx8cXGm7feOUBd0z+9O4BOQqQQSFMMV4q+WnCIG0D1y02PVag38WSFXHBvb
 6z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/Nyp+XvU8Iwf2Gbpf50+YAlGUNo21rB3BtmQX93H+/8=;
 b=lV80VuBJZd2JKZ6Xsx1CjvOqJd9/IRmIenlKCxz5ZaG/av2LQ7K9UgGEJIh4BeR6zm
 fbTiUaDrgzdHuehv5qrnED2gYaiZVdXV1y3XWv4OFuT4cN2fofPJeC8uXjuXIygWjXFv
 Z2QDI1xUXCHN8hwngCWuobonOBNFIEmj2wghyU6VuBiB6n3M8XVNIlrMV/LhApV7uEL1
 SxIJY6stgjAE1qPcgLKZPEN/wzaZgKvfqwrcHITpXz3HVJrjSyubsxQwD2hgnvXF4ZX0
 yOqu2C7XJLgxqljOfwipjE7oh+qGhUX6OogaKnslfSNZGYbUn27/xbDCCgOtk445bOAX
 cVzg==
X-Gm-Message-State: AHQUAuYMMplkYqrGrf9u9oiITwvrd4Xb4RSyaJ2Df9jqYng03NpVAG2r
 VV35F7BX6pGDOtI29p+LLI9Row==
X-Google-Smtp-Source: AHgI3IZXdoAIAsseBMfkRAKIZI4SRXn8yZHH9eDUwV7R58aPu16CWGLwavGRfzK0LHMsvm+QRPae8w==
X-Received: by 2002:a7b:c752:: with SMTP id w18mr2534264wmk.97.1551183241738; 
 Tue, 26 Feb 2019 04:14:01 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p1sm11401877wrx.50.2019.02.26.04.14.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Feb 2019 04:14:01 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, David Lechner <david@lechnology.com>
Subject: [PATCH 0/2] ARM: make DaVinci part of the ARM v5 multiplatform build
Date: Tue, 26 Feb 2019 13:13:51 +0100
Message-Id: <20190226121353.19413-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_041403_871765_3C1E75BC 
X-CRM114-Status: GOOD (  11.46  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series depends on the interrupts support overhaul and the cpufreq
fix that are queued for v5.1 and on the clocksource rework that's been
posted to LKML[1].

The first one adds necessary bits and pieces for davinci to support
multiplatform build and the second one actually adds all davinci boards
to multi_v5_defconfig.

[1] https://lkml.org/lkml/2019/2/26/363

Bartosz Golaszewski (2):
  ARM: davinci: support multiplatform build for ARM v5
  ARM: multi_v5_defconfig: make DaVinci part of the ARM v5 multiplatform
    build

 arch/arm/Kconfig                       | 21 ---------------------
 arch/arm/configs/davinci_all_defconfig |  5 +++++
 arch/arm/configs/multi_v5_defconfig    | 12 ++++++++++++
 arch/arm/mach-davinci/Kconfig          | 16 ++++++++++++----
 arch/arm/mach-davinci/Makefile         |  2 ++
 5 files changed, 31 insertions(+), 25 deletions(-)

-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
