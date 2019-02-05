Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0208C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:21:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD5420821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 00:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g6ABwZu/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="InggFshw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD5420821
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=impinj.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CbEiNpncQfTA2YMGLVGV7R/oXNba7xHjlFyMK+1FtLA=; b=g6ABwZu/8IJ4mB
	W2pA92mbRu5hgCEebMpepMcHJjKP2KBpB5JoRssPvmk9zaANsukFg2OYQb70G2fE94w5leXtX1VFT
	N10PvvOHZaAWb5r7PW8iuD7xvmc6R2zx7Sud6p+03P8MJLh1idTk1CajxmkoyS44y/uvV0gfWxvWn
	e+akYQIhJ00O2bN4gPhhsUxnI9KYa4yiyT0UP/MERESWSPbGSx8ZXufYSalgmf2P4K/4qZcki4hkC
	hYQ+cTUkmGKeedrr5MgLp1du4cL+Qvh1ct3FZiA9BNalEjKEShBajMYkhD4/WqAxGehUqbgLhi3q+
	QhCHJ+Wd1GQDRvGAYAjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqoUp-0007Pr-Ps; Tue, 05 Feb 2019 00:21:51 +0000
Received: from mail-eopbgr730113.outbound.protection.outlook.com
 ([40.107.73.113] helo=NAM05-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqoQr-0004Ee-Pa
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 00:17:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3K4R0r3cU2FVwqz31zGlRLSj0//v98jaTV9vZKA+Lo=;
 b=InggFshwc55rcJ6N9QvHrHkYI2OS0DAo7RFbqUJuQnyZ+pKOTIxKfFFyjHwnPi8ul77qte/v24WD7TWcPYxcVyFemzL8HFtlXI06SQRi0MQ3+2xXyutSSEOhiqAxyiyw+oz96ttjQtv7ng7dTqn95lvMKNCB5JxmdYOfbE5gIjs=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3722.namprd06.prod.outlook.com (10.167.236.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Tue, 5 Feb 2019 00:17:40 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1580.019; Tue, 5 Feb 2019
 00:17:40 +0000
From: Trent Piepho <tpiepho@impinj.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH v2 2/3] ARM: dts: imx7d: Add node for PCIe PHY
Thread-Topic: [PATCH v2 2/3] ARM: dts: imx7d: Add node for PCIe PHY
Thread-Index: AQHUvOg03kf45m4W4U2GQOHN/EPVEg==
Date: Tue, 5 Feb 2019 00:17:40 +0000
Message-ID: <20190205001721.18639-3-tpiepho@impinj.com>
References: <20190205001721.18639-1-tpiepho@impinj.com>
In-Reply-To: <20190205001721.18639-1-tpiepho@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0078.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::19) To MWHPR0601MB3708.namprd06.prod.outlook.com
 (2603:10b6:301:7c::38)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.14.4
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; MWHPR0601MB3722;
 6:QNaE1YBXNNqbDXK13oQdpV/6FiuDRa+e48Cif0Yca/YAYzbOp6BrHZtXMkFR3h6otQpvdBCk7kImYfbfE1/ZOgr7aOnwIFilIW46aeM+haIwbg7jYHAjxRvegGXJmcBLoCJXNtUV+geSqDdGprbMqUk4/R4ALto8HmDDVYiDzR1b46ZMrgtVzbrh1/wqBVbgYxwkoD5Szq6PTiFPe2rOPtkpwyMO4DEvWi2YoVmwWbdo1KPRhoCuqiE0tt14LOLba7k92frw1xdD5yxJed8NQ8OHVeyUj/fLWhrsKvaDXrOtYmYsHNgc2vB7ICL8KAnbN60W3jyGEVqOiMU7pVNOoAfHTG2o9o5fY6UBvvmgmr2cnf00uwkhS+x7MU+8io0uZ8WAL6Iban28aYBt5aHHcUGSTmw976YwjIzzi6z7QOoxQ7Qfl5hqVVjfMkjXgKwS9H1vPGCmilT0XjFnalstlw==;
 5:8vDFamYsF3mZCRmURobnK8kgRyy/C6gwKN0VprBDHY0VQEKN4e89c7+Exd0XuSKw4vYuInu0AstkaF7YVXk/+Zj1AKqSff0MFa1hzFt5Fy7ilB2AdNVOyKZILj6N2emREYSy1SCo4tM+NEAo1fb2XHShEVbr6A0obKnhE3kpGWpRfVbIO4+O/NYEiDREyoIfPzCGBsYFX2ETZzOTvHMwmw==;
 7:GpUO3pLz4ti0q9mZG+JkWgeVqc9k3w/5LfiPBL3AqUI+JwT98jpLO0cb5NArFbDwnkgxI4OrwWJZD8Q1x6JJfudgClXslBuhy3bWQNMeSTwwTfP41AMosTeq9o5TgHe0u40awm3bfVjaP4isLTJnpQ==
x-ms-office365-filtering-correlation-id: 5381809b-f1fa-4555-d7a1-08d68aff56f7
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR0601MB3722; 
x-ms-traffictypediagnostic: MWHPR0601MB3722:
x-microsoft-antispam-prvs: <MWHPR0601MB37222169765AB2C3D4479207D36E0@MWHPR0601MB3722.namprd06.prod.outlook.com>
x-forefront-prvs: 0939529DE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(136003)(396003)(39850400004)(366004)(199004)(189003)(2616005)(476003)(105586002)(25786009)(305945005)(7736002)(4744005)(2906002)(6116002)(107886003)(3846002)(11346002)(66066001)(486006)(86362001)(4326008)(97736004)(186003)(2351001)(446003)(1076003)(71190400001)(71200400001)(256004)(6486002)(102836004)(6436002)(26005)(50226002)(386003)(6506007)(53936002)(14454004)(6916009)(5640700003)(316002)(8936002)(478600001)(6512007)(76176011)(2501003)(99286004)(81166006)(81156014)(68736007)(14444005)(52116002)(54906003)(36756003)(106356001)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:MWHPR0601MB3722;
 H:MWHPR0601MB3708.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SodH62utwgCDpxaQrduy3Suu3e49AUGzkW9/p4vg1ki2b7yynrndTg0Vm6GR2uCrvsFRvbAwLZl8lV/x4LYrgiqUfQDUVlnFPFuVJj6DEgQ8cOjBrLVUszRT0RaaaCCff7KBV2f8VxrrIM5d0VvZyh8Nyk+2ZMuvZifjbtq4t+pwwEvSnDerlqBZdVnBfMFasylsmB5vniEziVRaGqjbiOiqbPCP+3pjrrR9N2QV7/XuP/w9M2h/G7gzATUQDVE/JAtiXgqWJRCJURRijcBl5kCuiLGVweCBIjPSPVmhyh0aQO3WTy4IA35haFmhlXQ3exNr1WulJiH6bMwauU9C2JTZItjvg4YoucwmwMrWuDa9fgsho7nhPswVe9FB1LJ7Ff+3fL0Hd7AVD0MSiH7zO0XqBtNgBrIi3UAWAKn103Q=
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5381809b-f1fa-4555-d7a1-08d68aff56f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2019 00:17:39.5857 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3722
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190204_161746_190931_41F14CF7 
X-CRM114-Status: GOOD (  10.38  )
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
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Trent Piepho <tpiepho@impinj.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds the PHY as a new node.  The PCI-e controller node gains a
phandle property that points to it.

There isn't yet any code in the kernel that uses this device's
registers, but it will be added for a PCIe PLL erratum workaround.

Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 6b298e388f4b..6eb98e7c568d 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -96,6 +96,14 @@
 	};
 };
 
+&aips2 {
+	pcie_phy: pcie-phy@306d0000 {
+		  compatible = "fsl,imx7d-pcie-phy";
+		  reg = <0x306d0000 0x10000>;
+		  status = "disabled";
+	};
+};
+
 &aips3 {
 	usbotg2: usb@30b20000 {
 		compatible = "fsl,imx7d-usb", "fsl,imx27-usb";
@@ -173,6 +181,7 @@
 			 <&src IMX7_RESET_PCIE_CTRL_APPS_EN>,
 			 <&src IMX7_RESET_PCIE_CTRL_APPS_TURNOFF>;
 		reset-names = "pciephy", "apps", "turnoff";
+		fsl,imx7d-pcie-phy = <&pcie_phy>;
 		status = "disabled";
 	};
 };
-- 
2.14.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
