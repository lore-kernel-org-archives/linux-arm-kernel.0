Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB640C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:33:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDB020883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SGB5ePtK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="CBg7inCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDB020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WN8JmqMtW0NJM0ThS9OyZ8XaR1NOHZIGigcj2pNA0Nk=; b=SGB5ePtKaE8/eY
	8UwA58W7lEVspAzNMMnFhYq/1GbboDie/N1AcWP6MmYrU/t9JVc6wbfZJRlrn3hVD8O8kNpylOf5f
	IHXknUTbLBimScJAOT1MviVvY1gpTZuH+xxaQN4CpBe1/j09wdG1YQtaecFOo5X7OnJD3GaeRLBHo
	SzvrvsSMIR3ZMr74d30ADms8gnhSvNKaJ3nJ2PwKng+YTvAk0XfSmmIxhtI/s2dmae+MUJzX/jTLU
	lPV93d7a5LZXQBRhz45pbCiFZ4bzFyi7XcSK/n4QGtniiBmedt1rYBxnduOfOpRzv55hgmmtklnH3
	4UEpdA/2NhChpiosT7tw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkUGd-0001nh-1B; Fri, 18 Jan 2019 13:33:03 +0000
Received: from mail.kmu-office.ch ([2a02:418:6a02::a2])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkUFw-0001P0-Vr
 for linux-arm-kernel@lists.infradead.org; Fri, 18 Jan 2019 13:32:29 +0000
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
 by mail.kmu-office.ch (Postfix) with ESMTPSA id 84DDE5C1713;
 Fri, 18 Jan 2019 14:32:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
 t=1547818339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:
 content-transfer-encoding:content-transfer-encoding:in-reply-to:
 references; bh=erd4vDac163qgB9A/AU5uPwipvsYhblMeb+AlJzom/0=;
 b=CBg7inCaZMAXsHRqL68VkhQtml3rJ8Yf2tJh2YsHPNnnCFdBwxOA3GecruLppGtX6+ajno
 xLV8nlzWhQhmxt4hPW8nHMKhxwwdVoal9tI19Mcx6jT456Lh1PjVhi79iaKlAV7gKsaj/c
 hfk2CGQu1CI7uUYaggzyAcMalLkfvA4=
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de
Subject: [PATCH] ARM: dts: imx6qdl-apalis: add phy-supply
Date: Fri, 18 Jan 2019 14:32:18 +0100
Message-Id: <20190118133218.19917-1-stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_053222_495150_944DF808 
X-CRM114-Status: GOOD (  12.00  )
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

Use the VDD I/O rail as phy-supply regulator. Technically, the
regulator has multiple rails, but currently the driver only
supports a single phy-supply. The VDD I/O rail has the highest
power consumption when software power down is used and hence
the highest saving potential.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 0b47aecf336a..cf66f9ececbd 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -241,6 +241,7 @@
 	phy-handle = <&ethphy>;
 	phy-reset-duration = <10>;
 	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
+	phy-supply = <&vgen5_reg>;
 	status = "okay";
 
 	mdio {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
