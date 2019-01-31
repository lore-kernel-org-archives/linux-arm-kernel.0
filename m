Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF2DC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:47:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB5B218AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z09W+8tU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB5B218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zSM3ECeQq2wRUmIWb527o/jWTbNo2eURxygz9X6kAgg=; b=Z09W+8tU7lYeVo
	JodIwoJqrGlAVwUdG7YYXAezGUX6UnJefnbBgGIaitoz5LevJtWy2rITNtN2goQ22zHPuoiaxEy15
	/6exeyO6sK4dE7Z+AP6I1W9IAFxbarlPTKaxn9M5EAGxXlim2x91wUm5Yz4owpOm/imIP0E23JAkA
	nn3znOWnvHtLYHTeDYtX5FmcJiKckK9eoL1IU7y/hApG1mRS37Pyl9njsaSbnRaVkwCxHUVklKt2p
	RlmONqFChJmVFgCIauc77AmW32ubga5DpbP9IRGoHEwGO2Q/0XbOP8jK/yM6v8TixUjJquaGY62Gs
	ByS/HiGUgWy1Y9E65aEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpBkb-0005Ei-CE; Thu, 31 Jan 2019 12:47:25 +0000
Received: from mail-qk1-f194.google.com ([209.85.222.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpBkY-0005EF-67; Thu, 31 Jan 2019 12:47:23 +0000
Received: by mail-qk1-f194.google.com with SMTP id z18so1736743qkj.10;
 Thu, 31 Jan 2019 04:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :organization:content-transfer-encoding;
 bh=HQswkCzqG31A9o+Cr/uokIq8kA6vxCiTIvuOp30FHCM=;
 b=WHwLTq/Q+r5zVO5oi3UlsHpT6zvExfWOXYsjB4SNjcbLoJyRHwM5jqKcCyylzK2Kj+
 fy/QNI4jNqwnJR8U+5kBLWRDfuZfWC4VFNrzT8pOQ3fRmi4QiXrN0LQMR8DAZVvKwKTR
 pyoMtSf3XRxdcSz1Sc7TKpuyeEdvW87h2JR2Afng5eDv6UfAa7EVmjV2jClAn+u899m0
 o2EPaNt8qSvAl9PBEWpL3jHGRrd2niAl3kczdceBW7X5JHUEeb1T4LnqGNq66IAFcpUA
 j4XIHYG13ZoyNpxU9attIDkgQPhGWexBgJuepe/+MZICaZjjYppnrozqt9th2XU4YFAB
 1taA==
X-Gm-Message-State: AJcUukc+/wusSozXIBtTM10Ltj4YWn3VBJHHa2iV7dNdIDS6cGuR1VQA
 a5Xn3F5EcTYUzbjCM43OSzdMlv7k
X-Google-Smtp-Source: ALg8bN5D4iYg9xlqNIE0ppsqyfPMKXpHpCs7SVzfT0yjmXvVJO0j2uhjcPZTSnci+TeXn4QOaJYFCw==
X-Received: by 2002:a37:62d3:: with SMTP id
 w202mr30651678qkb.357.1548938840744; 
 Thu, 31 Jan 2019 04:47:20 -0800 (PST)
Received: from localhost.localdomain ([181.220.86.121])
 by smtp.gmail.com with ESMTPSA id o21sm3706286qto.18.2019.01.31.04.47.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 31 Jan 2019 04:47:20 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 31 Jan 2019 10:47:11 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/3] ARM: dts: rockchip: rv1108-elgin: Fix vcc5/6-supply
 representation
Date: Thu, 31 Jan 2019 10:47:07 -0200
Message-Id: <20190131124710.30238-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_044722_225752_7C4A7F46 
X-CRM114-Status: GOOD (  12.71  )
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
Cc: Jason Zhu <jason.zhu@rock-chips.com>, devicetree@vger.kernel.org,
 Heiko Stuebner <heiko@sntech.de>, Otavio Salvador <otavio@ossystems.com.br>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 linux-rockchip@lists.infradead.org, Tony Xie <tony.xie@rock-chips.com>,
 Vicent Chi <vicent.chi@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Philipp Tomsic <philipp.tomsich@theobroma-systems.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On rv1108-elgin-r1 board the RK805 VCC5 and VCC6 supplies come from
the BUCK2 regulator at 2.2V, so fix the representation in the
device tree.

While at it, rename it from vdd_cam to vdd_buck2, which is a better
name for the regulator label.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2: None

 arch/arm/boot/dts/rv1108-elgin-r1.dts | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
index 658057d871af..66688fdf4fd8 100644
--- a/arch/arm/boot/dts/rv1108-elgin-r1.dts
+++ b/arch/arm/boot/dts/rv1108-elgin-r1.dts
@@ -74,8 +74,8 @@
 		vcc2-supply = <&vcc_sys>;
 		vcc3-supply = <&vcc_sys>;
 		vcc4-supply = <&vcc_sys>;
-		vcc5-supply = <&vcc_sys>;
-		vcc6-supply = <&vcc_sys>;
+		vcc5-supply = <&vdd_buck2>;
+		vcc6-supply = <&vdd_buck2>;
 
 		regulators {
 			vdd_core: DCDC_REG1 {
@@ -90,10 +90,12 @@
 				};
 			};
 
-			vdd_cam: DCDC_REG2 {
-				regulator-name= "vdd_cam";
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <2000000>;
+			vdd_buck2: DCDC_REG2 {
+				regulator-name= "vdd_buck2";
+				regulator-min-microvolt = <2200000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-always-on;
+				regulator-boot-on;
 				regulator-state-mem {
 					regulator-state-disabled;
 				};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
