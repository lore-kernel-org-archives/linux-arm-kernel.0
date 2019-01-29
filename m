Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B01C282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:55:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1822084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lq7GUC+z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1822084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hTCGnOtS06Ev2gC+vWB4W7J0TyCsCql5LSR3d+F9SUI=; b=lq7GUC+zPc3tDt
	y/nUc6C63N1RvVQEkbc/ElYQ7Oo0hSDj4Xw/PI18ivXUaea92+uywhYC1OCkooQeHsS6SZKxTRLyF
	NW1dIUl82Po7gaT7SqxjPDDMx20ZhBsVRwXy/iKfLYsVlcorKeqq+XvmrK56JJVphmUHUQBuuNK5J
	pTkXeH+l53bO0rePKUQmGcu1Jam5STGVTj4ILrFELxWPmHN8LcpeYzcSTVBrbiRI/mYAnv4Ehmnvv
	ruZFexJiOO5HtWaHFH5AxQX8Pz/1iNpyZRdEsaDQZZN9bhooMEyw6W0BMiO205OvlIaK3itEoCsYi
	sH8yWVpbltd8EBSC7rhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goZTJ-0008Ps-P9; Tue, 29 Jan 2019 19:55:01 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goZT1-00086c-Gg; Tue, 29 Jan 2019 19:54:47 +0000
Received: by mail-qt1-f195.google.com with SMTP id t33so23674478qtt.4;
 Tue, 29 Jan 2019 11:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=yU/l/jTl/eNiEQmSpnEZVJnKEnv8Qcm2lq32UeL1WGo=;
 b=iP5YSSIKBq9EaTeFUqs3xUA1PMGLsQlr5d3PdYPxeMvPDAqmHuqxvjv87Naj0qihce
 KU+j4vsMRZMyqt++UCM8OenST+khSDgPOXkKZePfhxIIUHOk38jsFe+Etilct816f7Dh
 +BfbaoiozVlbKmCBCmUhVVOu85+CNpOYIidKWJb0Kwg/femjd3gv+m1VpPBWUAQQOO+T
 x5GMoS2dXwwaBsM6bxiYGlAO9FLYYpxXCU76enu7CCSZbicIaMvDsgvmPyZeZtO13pNu
 GZJ+nnRVlAB3pZUMKWEe6ntrc9dLTZDzrwTOmwrbSF9pYMenRwp8nfcWrWYn7Sx/j7f4
 CiNA==
X-Gm-Message-State: AJcUukeQ6gGFKxvIgvfY9nGmKhSulu5k0tQV5vMoWQKJgTQSuRxnNjJQ
 0tRALGHNaR4pgDQWYEXnyu3kUVra
X-Google-Smtp-Source: ALg8bN4apAK6pUzvdKnKaeKeyigw/VkyI+ls3fsvsE6MEefwMPzgTee1a1AYpx4TDFLrstG9KDBPcw==
X-Received: by 2002:ac8:1414:: with SMTP id k20mr27311508qtj.298.1548791682323; 
 Tue, 29 Jan 2019 11:54:42 -0800 (PST)
Received: from localhost.localdomain ([181.220.86.121])
 by smtp.gmail.com with ESMTPSA id d85sm45389942qkb.89.2019.01.29.11.54.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Jan 2019 11:54:41 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Tue, 29 Jan 2019 17:54:34 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] ARM: dts: rockchip: rv1108-elgin: Fix vcc5/6-supply
 representation
Date: Tue, 29 Jan 2019 17:54:22 -0200
Message-Id: <20190129195424.10161-2-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129195424.10161-1-otavio@ossystems.com.br>
References: <20190129195424.10161-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_115444_104511_2119FF76 
X-CRM114-Status: GOOD (  13.04  )
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

 arch/arm/boot/dts/rv1108-elgin-r1.dts | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
index 7b24558f13e0..dc2ae1731ae2 100644
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
