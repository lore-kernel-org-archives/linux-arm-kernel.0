Return-Path: <SRS0=7SeU=QL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED24C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:30:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807122082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VXr4GS0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807122082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bmWlLfJ5pcQf2uPgoo9YQR96wIpKrxiiDStBUN/G0EI=; b=VXr4GS0TevJphl
	PEnI05MOQHPZebLMgBmJfkR9j7ovJbYuAld50qpb/B4Fzkl3VzOvjLKy4hsgl2R0hgvf0TdHA5C2H
	on7zj6qGsAti6unFTHTLu/Dj0DSL35IIP7VTZkm8dytUxcImN0c7z9lbR0tFHJGUD4XW7+9rx7X7t
	X+BYoczBqRZIP2sAThqsJn08Ho+ecDrFtOdM+NUFhEg+fFYkIWG+MIhmLd0LPl2M8dZKpBlNCw3NU
	0Dj7HauHeAcyGJKqGa7Mke+zeqGk7RzKI6OrLC5zfBMyjGufShcaR5lzBxXPIiOJ4wKwHjbHhR9Po
	CFry2m4ULrpx0gwpBgMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqgCQ-0001Gw-I4; Mon, 04 Feb 2019 15:30:18 +0000
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqgCM-0001GC-Nt
 for linux-arm-kernel@lists.infradead.org; Mon, 04 Feb 2019 15:30:16 +0000
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28]
 helo=dude02.lab.pengutronix.de)
 by metis.ext.pengutronix.de with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <mfe@pengutronix.de>)
 id 1gqgCG-0005g2-Mc; Mon, 04 Feb 2019 16:30:08 +0100
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.89)
 (envelope-from <mfe@pengutronix.de>)
 id 1gqgCF-00089R-Rj; Mon, 04 Feb 2019 16:30:07 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
 linux-imx@nxp.com, robh+dt@kernel.org, c.hemp@phytec.de
Subject: [PATCH 1/2] ARM: dts: pfla02: prepare storage devices to add paritions
Date: Mon,  4 Feb 2019 16:29:55 +0100
Message-Id: <20190204152956.13471-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-arm-kernel@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_073014_932940_D2122FA7 
X-CRM114-Status: GOOD (  10.99  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Partitions in the NOR and EEPROM are application specific. Prepare the
SoM device tree so platform device tree's can add partitions.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 1bfa41e01a0c..35d56e25c4a0 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -79,7 +79,7 @@
 	status = "okay";
 	cs-gpios = <&gpio4 24 0>;
 
-	flash@0 {
+	som_flash: flash@0 {
 		compatible = "m25p80", "jedec,spi-nor";
 		spi-max-frequency = <20000000>;
 		reg = <0>;
@@ -107,7 +107,7 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
-	eeprom@50 {
+	som_eeprom: eeprom@50 {
 		compatible = "atmel,24c32";
 		reg = <0x50>;
 	};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
