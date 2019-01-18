Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F93DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:31:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106322087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iif6TMQ3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="pGMniGur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106322087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=sM7uSNmslyVyaBhe2MULY0zNJoxNkGCNa8s2lU4ev7c=; b=iif6TMQ3VXt/nS
	+o0rIW8omW4y34W9N9M5gO5sgwkIBjb4gXqON6urcJqbfTWmW6HBXKK5p+1+E0QPhc2B9usjVa/Gi
	6JtOfIf1/U/iH5iv7yfQgo9uzh87UDFT8XnUKR1UdW5KuU4QF2L0XgG0lKEdFdx4sk2sp/fRjEU6A
	moRh51bozjDtR6G/7+1kp52b0VvgKdWuWlpD86G8CC0bcijRzRCcBj7Tm1iUNz0o0k9c4Sxu/Nd9t
	adWBQvh6qlB5rwGKM3XDleBXrr83F8525Li6hm4MJ5eT8iwxE+5nzoejjDcVImCO6q1pMZdV1OC0Y
	qhBs4cCl66uAUb1VF2hw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkUF5-0000x7-UN; Fri, 18 Jan 2019 13:31:27 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkUF1-0000wQ-Q2
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 13:31:25 +0000
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 9C3975C115F;
 Fri, 18 Jan 2019 14:31:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1547818278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:in-reply-to:
 references; bh=Aik6KQzBZfujviPqUffSwTRj+LLZFOQ4Ed9Tw4Zsw6o=;
 b=pGMniGur4JfF1kfAktUVW5jwykUZyQwFl/V2j2lrpu69j13CkT77glb8j5hVXhEHZsUeRQ
 YZsplIh7clwwxx8FffR92D3hdqKFTQshSbJQaq7F9AQR6WyfwiRzPhfiqSWeOq4Tm71n/K
 OsMdVFcfrNXxvus7cSjujLQGXodM2LY=
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de
Subject: [PATCH] ARM: dts: imx6*-apalis/-colibri: mark I2C recovery GPIOs as
 open drain
Date: Fri, 18 Jan 2019 14:31:13 +0100
Message-Id: <20190118133113.19484-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_053124_135883_E032967F 
X-CRM114-Status: GOOD (  12.74  )
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

Since commit d2d0ad2aec4a ("i2c: imx: use open drain for recovery
GPIO") GPIO lib expects this GPIO to be configured as open drain.
Make sure we define this GPIO as open drain in the device tree.
This gets rid of the following warning:
  gpio-81 (scl): enforced open drain please flag it properly in DT/ACPI DSDT/board file

Note that currently the i.MX pinctrl driver does not support
enabling open drain directly, so this patch has no effect in
practice. Open drain is enabled by the fixed pinmux entry.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi  | 4 ++--
 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 4 ++--
 arch/arm/boot/dts/imx6ull-colibri.dtsi | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index cf66f9ececbd..2d0ed199ed20 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -429,8 +429,8 @@
 	pinctrl-names = "default", "recovery";
 	pinctrl-0 = <&pinctrl_i2c3>;
 	pinctrl-1 = <&pinctrl_i2c3_recovery>;
-	scl-gpios = <&gpio3 17 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio3 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio3 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "disabled";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 87e15e7cb32b..8a27c2a05678 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -298,8 +298,8 @@
 	pinctrl-names = "default", "recovery";
 	pinctrl-0 = <&pinctrl_i2c3>;
 	pinctrl-1 = <&pinctrl_i2c3_recovery>;
-	scl-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
-	sda-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "disabled";
 };
 
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx6ull-colibri.dtsi
index 6c63a7384611..9ad1da159768 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -94,16 +94,16 @@
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
 	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	sda-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
-	scl-gpios = <&gpio1 28 GPIO_ACTIVE_LOW>;
+	sda-gpios = <&gpio1 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	scl-gpios = <&gpio1 28 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 };
 
 &i2c2 {
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	pinctrl-1 = <&pinctrl_i2c2_gpio>;
-	sda-gpios = <&gpio1 31 GPIO_ACTIVE_LOW>;
-	scl-gpios = <&gpio1 30 GPIO_ACTIVE_LOW>;
+	sda-gpios = <&gpio1 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	scl-gpios = <&gpio1 30 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	ad7879@2c {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
