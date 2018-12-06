Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B96C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:10:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1122082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eVBAn74f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="LhG70B8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1122082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=uY8IFwWr7XAFfEsr6mO85oshftNVS6vEFQM7ae/7MhI=; b=eVBAn74fngJ82fEU9v8MvnCzdu
	KTPhAz+49aRPUYpazyNnLX0qsRfNtgpQVCqoqJr73dErNUbI496WtWcxtmGqmiXVR9aSvnr3iWm+V
	Sh39Ew9QLR3sya86H/GDcaQMv9lxuQa7yfLUGB/q5ru+JMRRm+Ujo5+kbAGsAn/WUSwUWee5R1toB
	IMbMsHqBa0Xt6wCfnMyV9/UyR4LYiAtyWx8iyHk6ErvscLqFhq/utyqaQWO62WDAanmvt38h3VHzl
	JqehCOUPQW0qibiVeDsjA3+BITfXOm3YNpU5KyTQu3N2tT3wI6IyS5RpZsICBrCghuU/66bxSZPkL
	1ONV4M8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gV1qa-00053w-Hx; Thu, 06 Dec 2018 22:10:16 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gV1qB-00021y-BE
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 22:10:13 +0000
Received: from penelope.horms.nl (unknown [64.124.208.80])
 by kirsty.vergenet.net (Postfix) with ESMTPA id B7DAC25BF11;
 Fri,  7 Dec 2018 08:58:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544133518; bh=PFuDLU1oQ+ZklRyCftbK9rRKQohajYcpGZj51yD+OMA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LhG70B8QRs+bF05kyQxZYa7Akp3fH9X484MkZkDvq98D4jRZjnOpZTNtzZj1EfCLT
 F+V0vGbslQy69ejPezlbopCX9TqpopM0mxNHOXqoiLcE0gr/kL+TPowFfngB0zdtv9
 vifFLcB/RXByHS6GLJNyIZ6h7i/bI5N1t+ugs9Sk=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id A1CB0E232BB; Thu,  6 Dec 2018 13:58:31 -0800 (PST)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 33/34] ARM: dts: iwg20d-q7-common: Move cmt/rwdt node out of
 RZ/G1M SOM
Date: Thu,  6 Dec 2018 13:58:28 -0800
Message-Id: <b72ce26cb73afd042d65f737971f560a491e1275.1544125558.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1544125558.git.horms+renesas@verge.net.au>
References: <cover.1544125558.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_140951_705314_08178B07 
X-CRM114-Status: GOOD (  10.95  )
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

The iWave RZ/G1N board is almost identical to RZ/G1M. cmt and rwdt modules
are SoC specific and should be part of board dts rather than SoM dtsi. By
moving these nodes to the common dtsi it allows cmt and rwdt to be enabled
on both of these boards with less lines of code.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 9 +++++++++
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi   | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index ca9154dd8052..e2b1ab9b56e5 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -116,6 +116,10 @@
 	status = "okay";
 };
 
+&cmt0 {
+	status = "okay";
+};
+
 &hsusb {
 	status = "okay";
 	pinctrl-0 = <&usb0_pins>;
@@ -230,6 +234,11 @@
 	};
 };
 
+&rwdt {
+	timeout-sec = <60>;
+	status = "okay";
+};
+
 &scif0 {
 	pinctrl-0 = <&scif0_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
index 0e2e033cc849..b3fee1d61c87 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -31,10 +31,6 @@
 	};
 };
 
-&cmt0 {
-	status = "okay";
-};
-
 &extal_clk {
 	clock-frequency = <20000000>;
 };
@@ -88,11 +84,6 @@
 	};
 };
 
-&rwdt {
-	timeout-sec = <60>;
-	status = "okay";
-};
-
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
