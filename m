Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD828C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:19:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A00F20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fPMEsuKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A00F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8eFhxurkK+tC9axecqlBDVmWWPgJS1U9ruOQ7o97CBY=; b=fPMEsuKtSOHuIZ
	yf2Nn2p4Ey9By/LnS1640oXPjspLfnuoFxvgSu2E4vTJaaZ+SHq78q56WN7I9i2PgwTnaSpaOYP9V
	YCPdgQdaRlCyxMnUMhifF2anZDiBCVqaK5lFFJsiGSLoQYpsS8MNNe02WP0p0WoVjqn47nm2hNCK7
	tiQqk/q7i1H3TbhWX+AZIyF7qANCJbqicBnmZHthOTN9zR/Wp3w49xXyUuW4evo81l+dt/bOxLls1
	F64VcjEsnPglq3XPjZQZ5oB5nzEL68XvV0LJW6fmCrskIBT9Otgk1zMHA/S4Z4UGREMlwe0V3qWor
	0ZV3HcZwPWo8SWA4H9nQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gosaM-0001qq-Nm; Wed, 30 Jan 2019 16:19:34 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gosZe-0001IE-F9
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 16:18:54 +0000
Received: from sapphire.lan (unknown [10.0.4.3])
 by mx.tkos.co.il (Postfix) with ESMTP id 17C0D4409CB;
 Wed, 30 Jan 2019 18:18:44 +0200 (IST)
From: Baruch Siach <baruch@tkos.co.il>
To: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 2/4] ARM: dts: hummingboard2: add uart3 pinmux for board rev
 1.4
Date: Wed, 30 Jan 2019 18:18:39 +0200
Message-Id: <0e2132b1acbb34449c1e823319be5d63ac71dffd.1548861664.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1548861664.git.baruch@tkos.co.il>
References: <cover.1548861664.git.baruch@tkos.co.il>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_081850_742230_9ED730D6 
X-CRM114-Status: UNSURE (   9.47  )
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
Cc: Baruch Siach <baruch@tkos.co.il>, Jon Nettleton <jon@solid-run.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hummingboard2 rev 1.4 fixed Rx/Tx swap in the mikroBUS header. Add the
correct pinmux configuration DT node for that board. Leave the current
configuration unchanged.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index 913f34ac00dc..fe95fe27e6ef 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -507,6 +507,14 @@
 				MX6QDL_PAD_EIM_D24__UART3_RX_DATA	0x1b0b1
 			>;
 		};
+
+		/* In Hummingboard2 rev 1.4 Rx/Tx are not swapped */
+		pinctrl_hummingboard2_rev14_uart3: hummingboard2-rev14-uart3 {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
+				MX6QDL_PAD_EIM_D25__UART3_RX_DATA	0x1b0b1
+			>;
+		};
 	};
 };
 
@@ -567,6 +575,7 @@
 
 &uart3 {
 	pinctrl-names = "default";
+	/* Use &pinctrl_hummingboard2_rev14_uart3 for HB2 rev 1.4 */
 	pinctrl-0 = <&pinctrl_hummingboard2_uart3>;
 	status = "okay";
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
