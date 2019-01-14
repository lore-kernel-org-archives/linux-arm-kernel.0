Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C33C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:03:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB97720659
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FaHyYIdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB97720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yQBXt4KBcsoZ5D+nUlDMN7Urj0zkF++MA6A81idGHLc=; b=FaHyYIdwNvN45l
	WTU8mjUr37ExVnPGLpUm54ZEbTM9VkevjNHAhKogOuPGeO3A3GSIBlZ3i2hPAFI0x8oqk5zWmDq+T
	0nf3RRSiM3oeCpl6qxQrFeBQNQhKfGj2+03SZpzJ/n6EMBx+ZpnWlAm4EzJzMSJKXtlSmWrw/YC6I
	Tix4DYXcaFczmdhNS9+UO+3MIgUqD1a2ky2HNvtBHd6uKWIcNaszRBrWx67gLFnWesIjimSu1VdkO
	dBdI3UQOoXCNxSCCQTU48UCaR37ztZmEvRsBf1K756P5+eNtQ7c5AkfqT696wxkXtCvvayBNOMdfH
	PNmHk9mwHFGrJEU4j7pQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj5e0-0007xs-Tj; Mon, 14 Jan 2019 17:03:24 +0000
Received: from honk.sigxcpu.org ([24.134.29.49])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj5dv-0007xT-Km
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 17:03:22 +0000
Received: from localhost (localhost [127.0.0.1])
 by honk.sigxcpu.org (Postfix) with ESMTP id 4E666FB03;
 Mon, 14 Jan 2019 18:03:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
 by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l1Pbwoce3S_O; Mon, 14 Jan 2019 18:03:16 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
 id BBAB047303; Mon, 14 Jan 2019 18:03:16 +0100 (CET)
Date: Mon, 14 Jan 2019 18:03:16 +0100
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2] arm64: dts: imx8mq: Add pwm
Message-ID: <20190114170316.GB4168@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_090320_560642_D33D013E 
X-CRM114-Status: UNSURE (   8.46  )
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

We can reuse the pwm from fsl,imx27-pwm as with other imx SOCs.

Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
---
Changes from v1 (thanks Lucas Stach for the review):
  - fix indentation of multine entries
  - move to AIPS2 bus

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 8e9d6d5ed7b2..0b42fcb1ecaa 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -259,6 +259,50 @@
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			ranges =3D <0x30400000 0x30400000 0x400000>;
+
+			pwm1: pwm@30660000 {
+				compatible =3D "fsl,imx8mq-pwm", "fsl,imx27-pwm";
+				reg =3D <0x30660000 0x10000>;
+				interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_PWM1_ROOT>,
+				         <&clk IMX8MQ_CLK_PWM1_ROOT>;
+				clock-names =3D "ipg", "per";
+				#pwm-cells =3D <2>;
+				status =3D "disabled";
+			};
+
+			pwm2: pwm@30670000 {
+				compatible =3D "fsl,imx8mq-pwm", "fsl,imx27-pwm";
+				reg =3D <0x30670000 0x10000>;
+				interrupts =3D <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_PWM2_ROOT>,
+				         <&clk IMX8MQ_CLK_PWM2_ROOT>;
+				clock-names =3D "ipg", "per";
+				#pwm-cells =3D <2>;
+				status =3D "disabled";
+			};
+
+			pwm3: pwm@30680000 {
+				compatible =3D "fsl,imx8mq-pwm", "fsl,imx27-pwm";
+				reg =3D <0x30680000 0x10000>;
+				interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_PWM3_ROOT>,
+				         <&clk IMX8MQ_CLK_PWM3_ROOT>;
+				clock-names =3D "ipg", "per";
+				#pwm-cells =3D <2>;
+				status =3D "disabled";
+			};
+
+			pwm4: pwm@30690000 {
+				compatible =3D "fsl,imx8mq-pwm", "fsl,imx27-pwm";
+				reg =3D <0x30690000 0x10000>;
+				interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_PWM4_ROOT>,
+				         <&clk IMX8MQ_CLK_PWM4_ROOT>;
+				clock-names =3D "ipg", "per";
+				#pwm-cells =3D <2>;
+				status =3D "disabled";
+			};
 		};
 =

 		bus@30800000 { /* AIPS3 */
-- =

2.20.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
