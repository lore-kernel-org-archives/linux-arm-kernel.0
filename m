Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F967C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:18:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D098820863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MN0JogQ1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="qxwqO3QC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D098820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=FS+Ds2PNL2WIk0luBJwDeWcDxOAn8LI5x7omZgqBsic=; b=MN0JogQ1cX8fZXyjcCh5Dq5/Sl
	KwYuTzXZnBdkz/CpUutYa9Ena4IUy8gLYb7AGhhleNjT0ZqdVLcLt/LeRxDI8e3t1WRLVcD0OwJK3
	RoFx869h9aAQ9ejatF8rgAO8AZq2iw1Ekj5V7nDtLTsoAY8PlH94dpsGb/8ijaHFa1vCM+e8qdPYM
	KK8nySxIJgGzWcRIj9czgCecip7aBCx+do+0piDIvRRlvJhCs/s57FRLtIP2vIOj0MNwHSBYoNuKB
	Y+LpuGhCnw6lWvu1Gg90pNcW03qOFSVjIEHwXcvVuvBPPouHKfo5waaI6PSU1DUgN7/Sx0xEULq/T
	4zYUxGfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gs4BJ-0005IZ-Fa; Fri, 08 Feb 2019 11:18:53 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gs4Au-00084G-Oo
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 11:18:49 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id E79A525BF01;
 Fri,  8 Feb 2019 22:13:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1549624430; bh=ftdiyIFmsH9rL18fTj55GmMBsd3dKTOHp1CQ93j4dzY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qxwqO3QCgQncehCOLxyKnbeVVwok8hwCp3Zs2j6kRoOmQcmnSA3fYbuGh0MFG007y
 whuGh/ASeO9tTngtoTGEP7kj2bzWYvwQuA6uKw/KuBLblnNf/3AxdcMEczoNym8yHj
 1RJwtPHLyAqWbzJ4AgQrI1rkTrMtLHH3PpTYSjBU=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 414A89402EE; Fri,  8 Feb 2019 12:13:48 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/5] ARM: shmobile: Enable NXP pcf85363 rtc in
 shmobile_defconfig
Date: Fri,  8 Feb 2019 12:13:43 +0100
Message-Id: <71e3039dd7c377118608321d6c1f2ecb35da4c17.1549621233.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1549621233.git.horms+renesas@verge.net.au>
References: <cover.1549621233.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_031829_170855_3EBD3403 
X-CRM114-Status: GOOD (  10.19  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org,
 Biju Das <biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

The iWave RZ/G1C SBC supports RTC (NXP pcf85263). To increase hardware
support enable the driver in the shmobile_defconfig multiplatform
configuration.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 9e5a5ade6cab..fdac4e4ca04d 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -177,6 +177,7 @@ CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RS5C372=y
+CONFIG_RTC_DRV_PCF85363=y
 CONFIG_RTC_DRV_BQ32K=y
 CONFIG_RTC_DRV_S35390A=y
 CONFIG_RTC_DRV_RX8581=y
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
