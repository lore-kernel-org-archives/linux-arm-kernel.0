Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A10C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:00:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC30820652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eOtvsVc8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="vwJVlTVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC30820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8wnbWL4nF1MUqmFNihd1PCLwHSUJ3qRQTs3y9C+JPa8=; b=eOtvsVc8R9EYe2
	E42/2VO14BzddLHPI3NRBrsvou+wRUJhCeGl1nRDZ3ZhuJkUMcrjPAKR8PnuFu0JjDgIi1/OXQ+fe
	AMwBGF/zfa1L9yMP2BPmQj0zgMJadm1FuMxjm9sT7Q+/POEMFtiQoM/B2PVnmzaz13DSWNCUjFbj2
	u0B3DXTvx7ZWEA3FutjEAUUt18oRJbf18QTJ7Xlc9U4D7Pm9rE+09kXPbMBOTkyVO7aLG5tJV8xYu
	wJmsLXPlK4wCM6/VuX+AnJtvA/EwHSMrlJrYk4YfJjsCx9KmpOrTzUqsmvtYFbYEtXNeFZmc+3XXb
	1Wq0eFeYaHQBLZw7Razg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkUgi-0002Rb-2X; Fri, 18 Jan 2019 14:00:00 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkUgV-0002J7-9C
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 13:59:49 +0000
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 631065C1762;
 Fri, 18 Jan 2019 14:59:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1547819984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NtrJNYPEiZir795tmif5LYJPP7L4fS6d11YP/Uv0kv0=;
 b=vwJVlTVWgn9lqJVrybY7+ud3mPUXE9yuB/mvQH9j/nrXZesgBCfYjEwkY6Rx4SAxf84/L/
 1nD0yAoTFsIe6CqYAwcVaCbwdy7aqOxAfFyXG5ABOPkGPYz5gSHIWQQXm1Yrj/WIZCPeKX
 ph+FzGCzBj8Z88yGEFAdvtrG+wnKHd8=
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de
Subject: [PATCH 2/2] ARM: dts: imx6dl: add pmu interrupt-affinity
Date: Fri, 18 Jan 2019 14:59:07 +0100
Message-Id: <20190118135907.2336-2-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118135907.2336-1-stefan@agner.ch>
References: <20190118135907.2336-1-stefan@agner.ch>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_055947_475460_785053A8 
X-CRM114-Status: GOOD (  11.70  )
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
Cc: kernel@pengutronix.de, marcel.ziswiler@toradex.com,
 linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
 linux-imx@nxp.com, max.krummenacher@toradex.com, fabio.estevam@nxp.com,
 dev@pschenker.ch, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Explicitly specify interrupt affinity to avoid HW perfevents
need to guess. This avoids the following error upon boot:
  hw perfevents: no interrupt-affinity property for /pmu, guessing.

Specifying all four CPUs shows no aversive effects on i.MX 6Solo
SoCs.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6dl-tx6s-8034.dts | 4 ++++
 arch/arm/boot/dts/imx6dl-tx6s-8035.dts | 4 ++++
 arch/arm/boot/dts/imx6dl.dtsi          | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8034.dts b/arch/arm/boot/dts/imx6dl-tx6s-8034.dts
index 9eb2ef17339c..f1606f63d687 100644
--- a/arch/arm/boot/dts/imx6dl-tx6s-8034.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6s-8034.dts
@@ -68,3 +68,7 @@
 		MX6QDL_PAD_SD3_CMD__GPIO7_IO02		0x170b0 /* SD1 CD */
 	>;
 };
+
+&pmu {
+	interrupt-affinity = <&{/cpus/cpu@0}>;
+};
diff --git a/arch/arm/boot/dts/imx6dl-tx6s-8035.dts b/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
index a5532ecc18c5..b3bf1f80aff0 100644
--- a/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6s-8035.dts
@@ -84,3 +84,7 @@
 		>;
 	};
 };
+
+&pmu {
+	interrupt-affinity = <&{/cpus/cpu@0}>;
+};
diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index f0607eb41df4..3c8b533b3039 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -386,6 +386,11 @@
 			<0x28 0x0000000c>; /* DCIC2_MUX_CTL */
 };
 
+&pmu {
+	interrupt-affinity = <&{/cpus/cpu@0}>,
+			     <&{/cpus/cpu@1}>;
+};
+
 &vpu {
 	compatible = "fsl,imx6dl-vpu", "cnm,coda960";
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
