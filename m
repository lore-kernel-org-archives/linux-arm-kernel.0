Return-Path: <SRS0=5OaU=PA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF194C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:04:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B693B21849
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e0P3vKWs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EmadQGJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B693B21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=U/FKlOvLnq4omrOjZl+2ITov9sbrzFz+rt77mbnEnio=; b=e0P3vKWsN9cs7d
	yW3eSBvbtDrkyAlKheFLr/RSJTktKppfb1Mhwx9hClG6evV0BxKJAbttoLVducVAiznrtYK/UY+QB
	aY8Xpg8PiaLfwGawnPMklKQcbLuW+/Mo29lEO2IUcoRjJvf/L2MVGD+kQ0Gdm5fH9mzXUuJCfrZoj
	OooGvcWOLYQONiQrLcjXaPs6O+qDDLpAXe0ds1i6d48Ff0aXlK4tW/GUKnumThgjM+sLw2l9P6mwT
	hGdPrm/MMirTLBaE0UxS8oeApQAs0lIyOwznuMhHm92eVwXlTnRoWILVEjJTszPy9/P+678AdSKaC
	Zd/yKB1xYxEA//Nh7/Yw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gb3Qt-0001O4-KI; Sun, 23 Dec 2018 13:04:39 +0000
Received: from mail-he1eur01on0609.outbound.protection.outlook.com
 ([2a01:111:f400:fe1e::609]
 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gb3Qq-0001Mc-0W
 for linux-arm-kernel@lists.infradead.org; Sun, 23 Dec 2018 13:04:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t73Cry3KzjUU9HB/DXByUvRMplIL6yFONsdx/w5MDgg=;
 b=EmadQGJ0j0pHDqQwW6sbnwHEzVB8OpcnOcbFHNmfjDu6/eBKmR0Y9GFH1kIeEHRv+IEExi1XmQnSydFBaoeTTFxKZ71akt3TmfZVgkyo6GE2wNUulTAhIhbPHznRE/dqw6FNbOhwpxo1rM2jq+03QKkdB58QU4UNDHzuyneGJQo=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3928.eurprd04.prod.outlook.com (52.133.30.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.26; Sun, 23 Dec 2018 13:04:20 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::f19b:c79a:43b4:b88d%2]) with mapi id 15.20.1446.026; Sun, 23 Dec 2018
 13:04:20 +0000
From: Abel Vesa <abel.vesa@nxp.com>
To: "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Topic: [PATCH] arm64: defconfig: Add i.MX8MQ boot necessary configs
Thread-Index: AQHUmsAEqdAV2wbwZkqbAE28W1vqLg==
Date: Sun, 23 Dec 2018 13:04:20 +0000
Message-ID: <1545570245-2993-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:209:15::14) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3928;
 6:EDPyDVLhPPCu/zYdz6QILG1d1cCsD8Esl1gAppUdPBjPjREkVmhw5VoNWE0GO3TSBKLGTmMseZORHuNYjGaYlbKyV84zWmcNPK3NuR6vB60acXrk6kWktQ5WQjw4hF8/M7kp44mEVNCeB0f47zP+kdeolI+yquzhMpW4XtMA6veNaSloR7vFwB4XbtDLMrEZFvNID9ZfPKWEsNUR6h9A7cMHp0RBAGToBry576nWq3TR8YozFdLEKfi9/lgYlx/Q6NNy16tWv84+uaMaAff1Nk6aDCvOpjiU+DyWk8652MK6jR7+LdnfCaNcrVG01bPZlYiAvsJk+MQiv0a5qf5r91P0y38LY6uJQd9D+Rp+0h5HBhv7NieUhsb1S4HXdfU9aqAVF8ApQ2ERulMrnDtGc43ffY4N32wGG82o5PDJtWw41nGIl/f8HLh/HeZK0/JdujUZoA6RhJIY+DqAUibK4g==;
 5:XFtKhnklOJ0UYp2qKiHYcxtqd6p4vazACgbelKVylLjkWKUZe6vm/nrTZZFBRt8PiMgV7WvNIuANlmV34ht9bc+7h54I6EeeIqS7PvXNP6jJ3yRdFZhOz7BFxZWsnucny76uI0XnE0gMKo1UuWloGYWrYXltrCYNMx/w2G03pP4=;
 7:xgpKesAeRIGyfKTCZWxL0LJKMqKPu4L+x5VGuev2IRnNTtU3qYDvbEqPA3c2pekTuJpqZJ8O43XX0YdO4Z/iGCk+6S+KTuPVfGxRWrEnntPQiGHner3lPlJ90C1rC5ekxI+Vj3m/x720HAaatdm1Kg==
x-ms-office365-filtering-correlation-id: 5d7a5459-87e0-4a8f-fd1d-08d668d726d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3928; 
x-ms-traffictypediagnostic: AM6PR0402MB3928:
x-microsoft-antispam-prvs: <AM6PR0402MB3928C2909947CC9AB7010247F6BA0@AM6PR0402MB3928.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR0402MB3928; BCL:0; PCL:0; RULEID:; SRVR:AM6PR0402MB3928; 
x-forefront-prvs: 0895DF8FFD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(346002)(39860400002)(136003)(366004)(396003)(189003)(199004)(186003)(386003)(6506007)(26005)(102836004)(316002)(6512007)(305945005)(36756003)(52116002)(6116002)(2501003)(3846002)(2906002)(478600001)(14454004)(54906003)(110136005)(71190400001)(97736004)(25786009)(44832011)(71200400001)(105586002)(106356001)(256004)(4326008)(486006)(81166006)(66066001)(6486002)(53936002)(6436002)(7736002)(5660300001)(2616005)(8676002)(8936002)(99286004)(86362001)(476003)(68736007)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3928;
 H:AM6PR0402MB3654.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RyfV3Y8pFnCrIDFCzdLlPepL7nW0kQKMjSgKC2nb0ycTqzRwXvxA/tF5/aLSTNPIXOSBTDias7j7/aqfH0bwvEeCjo548goi60Q8JWP3n1UHkShVRieKXcUm5tj/foYHvNLkTgjBb2Rs74mLWUtpzY+W0v2En2BmxwnSNg8lF5BA97Ig9qak2P2LjAg3SMdbZpVbOyNvqh0mSPKWBXhzz1s5VIYfYy3Xc4eSgMPc6+nugh8eCQnVyr8yNeHtbKu3qt/j/IrDXdsxBzfOlGJN6bDS5tu22biyFIsp8GwPBfeX7kr4VKLfEkCmyI0T1aPR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7a5459-87e0-4a8f-fd1d-08d668d726d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2018 13:04:20.2225 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3928
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181223_050436_186273_8FB35D34 
X-CRM114-Status: GOOD (  10.40  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Enable all the i.MX8MQ configs necessary to boot.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/configs/defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 989f51b..8534bce 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -43,6 +43,7 @@ CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_MESON=y
 CONFIG_ARCH_MVEBU=y
+CONFIG_ARCH_MXC=y
 CONFIG_ARCH_QCOM=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_ARCH_R8A774A1=y
@@ -246,6 +247,7 @@ CONFIG_NET_XGENE=y
 CONFIG_ATL1C=m
 CONFIG_MACB=y
 CONFIG_THUNDER_NIC_PF=y
+CONFIG_FEC=y
 CONFIG_HIX5HD2_GMAC=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
@@ -320,6 +322,8 @@ CONFIG_SERIAL_MESON_CONSOLE=y
 CONFIG_SERIAL_SAMSUNG=y
 CONFIG_SERIAL_SAMSUNG_CONSOLE=y
 CONFIG_SERIAL_TEGRA=y
+CONFIG_SERIAL_IMX=y
+CONFIG_SERIAL_IMX_CONSOLE=y
 CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
@@ -366,6 +370,7 @@ CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MAX77620=y
+CONFIG_PINCTRL_IMX8MQ=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_MSM8994=y
@@ -613,6 +618,7 @@ CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_PWM=y
+CONFIG_CLK_IMX8MQ=y
 CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_CLK_SMD_RPM=y
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
