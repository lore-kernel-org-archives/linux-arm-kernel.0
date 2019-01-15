Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE09C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:46:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8CB20656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a2O+0HBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8CB20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bIw4zsfKO1LiChYt2XWjdOlZUJShOIFqGcjrOq8Z1IA=; b=a2O+0HBkIcA8b3
	ojEoX/y6/szcoxum+1e6OXbyj0UBPaO6ZOhlIzlDVNwzMoVUXCbmZgQqbfVEUv36kSoyBOadH161T
	nPWxrG8S9HaBuUJiHudqrCQqZ3MQCQAPOTu6yz3hQBEdwSBjy47o/bqW7Vr0oRXPT3UbNgmhoId8Y
	SLJF8Msml0sQfW7D7/OP/8miy/QQi4/1/P7YDn+ctHFMa3luRsX9DZo4BKZp0JxkIED1FppIBTjGN
	9Sm9VZDhhsC0rRK6WyNPP6ThwLYJtgLeNOJA/JCZy9AFcoVd+mfGYkAUFIlzTozx8X7l3OJu1gbGD
	7Y2PHAMfay47YC8jSkmg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjNBB-00038Z-Sr; Tue, 15 Jan 2019 11:46:49 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjNB8-00038C-CG
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 11:46:48 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id E017CFB03;
 Tue, 15 Jan 2019 12:46:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YMjWfw_nudl7; Tue, 15 Jan 2019 12:46:42 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id 05EF247345; Tue, 15 Jan 2019 12:46:41 +0100 (CET)
Date: Tue, 15 Jan 2019 12:46:41 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mq: Add system reset controller
Message-ID: <20190115114641.GA15870@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_034646_577063_39220F1F 
X-CRM114-Status: UNSURE (   9.41  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

We can reuse the src from fsl,imx51-src as with other imx SOCs.

Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
---
I'm mostly interested in the syscon part to be able to use regmap for
MIPI DSI here.

Patch is against next-20190114 plus Lucas "arm64: dts: imx8mq: move
watchdog nodes to correct location" but also applies to

    https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git/log/=
?h=3Dimx/dt64

It will conflict with "arm64: dts: imx8mq: add GPC power domains" which
is not yet in any tree I've seen.

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 0225eae2216e..7b1e0bdbd932 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -252,6 +252,13 @@
 				              "clk_ext1", "clk_ext2",
 				              "clk_ext3", "clk_ext4";
 			};
+
+			src: src@30390000 {
+				compatible =3D "fsl,imx8mq-src", "fsl,imx51-src", "syscon";
+				reg =3D <0x30390000 0x10000>;
+				interrupts =3D <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+				#reset-cells =3D <1>;
+			};
 		};
 =

 		bus@30400000 { /* AIPS2 */
-- =

2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
