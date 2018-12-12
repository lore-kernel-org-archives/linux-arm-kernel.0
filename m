Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929EBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:10:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C7AF20851
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="puUd23IB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oYRwsyEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7AF20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bnRFKM+7TS2k5Ime0hjid8Y2eZG9cY4WLRREpjXMA4c=; b=puUd23IBbQIlNg
	NkW4r/8oBbNlJ2UxHtwh57xGD9dQfZh4Qn0qAeqTOHt86l8vJGattrr7fXstO2xXb2505j7x6zqmg
	ig2ONwl7XKl8tLzC/3bCHgeJzLCF5OWyxDzNtdJuoU7wd6TXRb4ogdPKPgLDRzVhaITHkohfREAKP
	UCr/FAwE6gsR/p06rybdwRzzUtpxG4ksITRUB7j4LbzDtbStNBK//pn7+76/XeHa8q+FXpUumm3ou
	RDxxygaa16q64KA/jxZsNAIriZd8lYQ5fL66oe4ICh7N9DusZz2aSkW0rVugMrv5bP3xK+x0lI+77
	oTtPc99HUkTa8FCKX3Nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWyfC-0003bZ-3F; Wed, 12 Dec 2018 07:10:34 +0000
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWyeo-0001tG-Q8
 for linux-arm-kernel@lists.infradead.org; Wed, 12 Dec 2018 07:10:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTc5JhhS0p0QLhigt++9rfhYlvJhXAeGWXN6ARyE/hM=;
 b=oYRwsyEliVBdWICY3K0VaveZegQ3b1QfqEcXHxn9NrNRE89+wIyYrx4hZdoeFd1l9trbJzbiaHSpeOF5h04Q0T6PDrSETT2vpyWUHTL9978n1hodjey6Q7hAkqcc4OtVfIdX+3enI+ivQbjzNtBLcMDX9PR6R/CqPX2yHcdnUmE=
Received: from HE1PR0402MB3323.eurprd04.prod.outlook.com (10.167.125.20) by
 HE1PR0402MB2811.eurprd04.prod.outlook.com (10.175.29.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Wed, 12 Dec 2018 07:09:56 +0000
Received: from HE1PR0402MB3323.eurprd04.prod.outlook.com
 ([fe80::f95d:89f3:77e0:b668]) by HE1PR0402MB3323.eurprd04.prod.outlook.com
 ([fe80::f95d:89f3:77e0:b668%5]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 07:09:56 +0000
From: Pankaj Bansal <pankaj.bansal@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawnguo@kernel.org>, Leo
 Li <leoyang.li@nxp.com>
Subject: [PATCH 2/3] dts: arm64: fsl: lsch2: fix the rgmii phy type
Thread-Topic: [PATCH 2/3] dts: arm64: fsl: lsch2: fix the rgmii phy type
Thread-Index: AQHUkemvq1A8It3EvUC8xj44qsjxMA==
Date: Wed, 12 Dec 2018 07:09:56 +0000
Message-ID: <20181212123505.32415-3-pankaj.bansal@nxp.com>
References: <20181212123505.32415-1-pankaj.bansal@nxp.com>
In-Reply-To: <20181212123505.32415-1-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PN1PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::11) To HE1PR0402MB3323.eurprd04.prod.outlook.com
 (2603:10a6:7:81::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [14.143.30.134]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; HE1PR0402MB2811;
 6:W2DEtW3MIOZAliiuRWZWxpGBaAico04bMSgqHF6GOcabiCa80rYx59OovrtErjalUl26/ehHIrezp48RbKOTYQ6+Dh2SpDTWmiS3hVBd1VmO9n+uknHsjdH7pwd5xXXxPkZaFxs/xIOsq6EorslyXIUpk4z6BD8tjO9v90jty7YhNAFDrn4VqAS001L7xtRlj3lvaBYP66402jPa8x+IeonzyJUb6XZearHtPFwMqHICYFcaaO9AKlglBCpagOgtt/h9N3KAq3o4oR9a41anggoRXPKpHDrlgkLbWA3DVZP0jxN21qmOMnbAhLQJSSxrtav/JSQTHnbcC8K30N+G0YnidOLm2wXOu/N6KpmyCTGDyL8X848IzELvVQeULurH1B0sHywsfaEO6HwsQXJMEthfXeGT/9DeqzLcz7cVI9z3Y8flhWk80y8TCyij5Z1MeBaMPEngnlRCpQ2USgRLlA==;
 5:ILzYLJxGLhVWEdkcWFxr38OVXDWidEW33tbmc5rGLCKOG/qyrvXtr2WktZnEQ/1dcjbksAyo6q1FLIxuiDCr1HG1ocBugobLC79BsRTbcUA+uCLvzAFGXJjb+LPyVAKppzvt64cipPUUWgFXFFUf+PlaRY4I1iUYI4Mm8rAys+8=;
 7:zqTlyv43X98q1Kz/hiteLSQBcT+ajnd1MmulyDChqfJRmWdWykBfaPmHGR6MmIKsokk3z9HR9ffznPzJPM880GET304NiLq5cE6c/2Yt6Gpt8h6Q0WB8shYxnvlXspsJyMFGEiko/aI6UyXNxMYCyw==
x-ms-office365-filtering-correlation-id: cf0eb8a9-f78c-4bbc-b331-08d66000d22e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0402MB2811; 
x-ms-traffictypediagnostic: HE1PR0402MB2811:
x-microsoft-antispam-prvs: <HE1PR0402MB2811545A5392F679E500E67BF1A70@HE1PR0402MB2811.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231472)(944501520)(52105112)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);
 SRVR:HE1PR0402MB2811; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0402MB2811; 
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(55236004)(446003)(2501003)(81166006)(7736002)(11346002)(305945005)(76176011)(486006)(66066001)(8936002)(476003)(2616005)(5660300001)(44832011)(81156014)(8676002)(256004)(106356001)(25786009)(105586002)(97736004)(2906002)(52116002)(4326008)(6486002)(1076002)(6636002)(478600001)(6436002)(6116002)(3846002)(99286004)(110136005)(36756003)(316002)(14454004)(54906003)(386003)(6506007)(6512007)(186003)(102836004)(86362001)(26005)(71200400001)(71190400001)(53936002)(78486014)(68736007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0402MB2811;
 H:HE1PR0402MB3323.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: q8MVSrFs+njW7AwYOKKWOFMm/d2l5+rNqKIRv9ujeDpDQDnK8/Jq2bkaTulrKcl2kEk1cw1hVIrV0n1OqQ72nPzUlRDvYyMKj9Jhg01qgGs75xo4Hk2a+Bstw8RTLM6uCebHDcoxX2Xv9RxAsr+PTivh/RgvH4HhN3T/borHuMXdURG6mySxo6zo9eqLD9rGSuXcT49PszQEWKCKSKdn/DleOhAixhpHyShJHXfazz6PYlxrAv0I4QAW124ZcTB5xfCLkTA2BcsqCZIKjiKBZ7vBgI3s+LAYzqhBQGOXa/w4pbJNglsNT2fADlUEOz4Z
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0eb8a9-f78c-4bbc-b331-08d66000d22e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 07:09:56.6549 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2811
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181211_231011_146576_832B756E 
X-CRM114-Status: GOOD (  12.14  )
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Pankaj Bansal <pankaj.bansal@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

refer fsl-ls1043a-rdb.dts. The phy connection type for RGMII phy in
Layerscape boards is "rgmii-txid" and not "rgmii".

Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index 65ea27c8341a..540231b41997 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -143,13 +143,13 @@
 &fman0 {
 	ethernet@e4000 {
 		phy-handle = <&rgmii_phy1>;
-		phy-connection-type = "rgmii";
+		phy-connection-type = "rgmii-txid";
 		status = "okay";
 	};
 
 	ethernet@e6000 {
 		phy-handle = <&rgmii_phy2>;
-		phy-connection-type = "rgmii";
+		phy-connection-type = "rgmii-txid";
 		status = "okay";
 	};
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
