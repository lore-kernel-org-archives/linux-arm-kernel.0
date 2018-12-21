Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24868C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:32:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FD521903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LkJCdWIG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lb1nuT+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FD521903
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tXHeGgqt/r5dn9tFek38vp27oYyr9qIGuxCf7lb4PV8=; b=LkJCdWIGULhH7N
	F2Dmf9eYkZBW+GHgQRMKSfBQIfBcMryS3qjsYymg8tfedy5JEQUqTfNFxdTMFeyG6hkKCpX0iZBqQ
	/1t/KBffpjjyHfw/XjHbaXJqOFwAwFDiWTUUWZ8V2SktUitsySOmzuMeszxasp1pXzWpRRTvcPTV4
	oA7ry/Vqc8RLEl7YeBKTRaDQtXKf7qBItOTkYk406X3FmdEcL9bmSTL28dccs02niQfCtHKTo0tkj
	4NDIia1bZeWBXrD2Amk2+KeF0aUoxBtrX3t21THyfblYuBrpO38qfW2+p8fg4NoRtsrLd9G22OprP
	Vq3cSRwmyhrPoBAYpxtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaMmJ-0006St-IO; Fri, 21 Dec 2018 15:31:55 +0000
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaMlp-0005da-TP
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 15:31:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81h2cMsCBY2h2iuWH1X4RfhsOnpIPlqnz+l+kE9IEYI=;
 b=lb1nuT+hqz4iQXp2lEPJMe9YhgLBcLCLvNx6RBRDdeEJXZwov7+2EEh5aSOG0i8iOsMC2d6Xj5zbrv4hWIW0MpkC0muQlnDpb5iZFIgjubKyjn0hT96s696kkhRmB3qpK+s2mujaa92xhqqmUEPZmfdxiQa+EyZWSdAv/Sksr+Q=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3488.eurprd04.prod.outlook.com (52.134.4.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Fri, 21 Dec 2018 15:31:11 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::95a2:5df5:8d7b:22e9%6]) with mapi id 15.20.1446.022; Fri, 21 Dec 2018
 15:31:11 +0000
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>
Subject: [PATCH 2/3] Documentation: DT: Add entry for DPAA2 console
Thread-Topic: [PATCH 2/3] Documentation: DT: Add entry for DPAA2 console
Thread-Index: AQHUmUIzLDDB55qxuECeWDzF4+LHLA==
Date: Fri, 21 Dec 2018 15:31:11 +0000
Message-ID: <1545406240-3061-3-git-send-email-ioana.ciornei@nxp.com>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0082.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::26) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0402MB3488;
 6:POxdqlUplTmz8766PFxntSlH3lzRV/7LaMg6agtR4UhZGpNGS3O1wRLzbMIy+nCcGh9QADdZV/QR9J7YRBFcO2bGfVodCnQgoCvC6PO3P2RmNau0iYVt5BXPEzPEnUD8SvQeHxbPMcAvQF5zCv2uR03Ati/WmlZdgDG1tiPtpsoA2H1eVMW8zGpsljMBL8E8FvgVI+q/1Et5lUaCZfJ+FdRJopAe5zgFwimXWzDp3RKwOy5rp9OCCXALUaOaMGblHaO0UJ0V7yjA5lKXJHvFXIkiKaalyyPwQP/nVaw+nzsCg6Z7jomDlIuerI0ZYTV5oixA031/PA4fUVN5ecxAO5729zG9tTYqRQ5ss+bAR1n/KgvC/l7UtXpPK8nWdXmWDJXV4Xl/LwI9Ie11f4/LKoPpzmBDtDy+IzHWkoCQRYppNppq8l/QLYSA/RJK/poS92O7jxOgkCqiQCRrelNDcA==;
 5:QevsTvBuhRTmjb6N8ki/2IpjtreMbCTtbkHGcy07mshV0FOJu6Ci6arNQF2Mrjp03LYtxmdto3G4nI6wXp1i9HJeChjAnYdFLlWA/RFOi1ILovOW38Iz4SpF+yN1Q/cOms65nsoawv7faqflKKLzKniw4caeEWydi+E9cv531Gs=;
 7:1UXyyQVacT4cVTbl31rVZQC1jPc/4GgZPk1sUpQt5ElAqJLAcGDIwminzikLUyv2CP4DOTBfgL018h5KAYkE31RRFiHMYyPfskpT1Z0ngpBZpH4nWg+1RDc2xXZXuomGZhy3SqwqwMAABlXT/ceWbg==
x-ms-office365-filtering-correlation-id: aa78f0c2-9626-4802-af5d-08d667595635
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3488; 
x-ms-traffictypediagnostic: VI1PR0402MB3488:
x-microsoft-antispam-prvs: <VI1PR0402MB3488BBE27CCB2D912D920B64E0B80@VI1PR0402MB3488.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);
 SRVR:VI1PR0402MB3488; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB3488; 
x-forefront-prvs: 0893636978
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(189003)(6512007)(53936002)(2906002)(71200400001)(71190400001)(86362001)(2201001)(26005)(97736004)(256004)(102836004)(6486002)(110136005)(186003)(386003)(68736007)(99286004)(316002)(52116002)(305945005)(446003)(76176011)(36756003)(6116002)(25786009)(11346002)(66066001)(8936002)(105586002)(6436002)(106356001)(2616005)(476003)(54906003)(81166006)(81156014)(14454004)(44832011)(3846002)(6506007)(8676002)(478600001)(5660300001)(486006)(2501003)(4326008)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3488;
 H:VI1PR0402MB2800.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9BYQCVVW7LV10Rc8crgdBLsW6jllZLyVVfprcFUrpTSJ4mZNfwT1eKeeM/DM7aE/Xo3SUXylanrAFjkycLtDtu4QrSxrHN3zOJ55zlW9jE4DPo9KiGW4iUfTXapajEncwztgiVsA9WO7VK3HYfpc9inTRvNsKSPK1HjZjUfsyle9qt84cA4kmsuWYCErDpOmLnCeGPRn/dOEZRyTSUGOALstdw/MjTc+unSiai6Qwrwkk0+Wcrv2ofWCNl2vwj/GKOCeQGD4rmwl03f/d/oUM8v53LC46trqadaV6K7vWIYaIrbIsQlhD5260VAeB8G8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa78f0c2-9626-4802-af5d-08d667595635
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2018 15:31:11.7956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3488
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_073126_268873_60BDE02E 
X-CRM114-Status: GOOD (  14.07  )
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
Cc: Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
 Roy Pledge <roy.pledge@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds a devicetree binding documentation for
FSL's DPAA2 console.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 Documentation/devicetree/bindings/misc/dpaa2-console.txt | 11 +++++++++++
 MAINTAINERS                                              |  1 +
 2 files changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/dpaa2-console.txt

diff --git a/Documentation/devicetree/bindings/misc/dpaa2-console.txt b/Documentation/devicetree/bindings/misc/dpaa2-console.txt
new file mode 100644
index 0000000..f4e16b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/dpaa2-console.txt
@@ -0,0 +1,11 @@
+DPAA2 console support
+
+Required properties:
+
+    - compatible
+        Value type: <string>
+        Definition: Must be "dpaa2-console".
+    - reg
+        Value type: <prop-encoded-array>
+        Definition: A standard property.  Specifies the region where the MCFBA
+                    (MC firmware base address) register can be found.
diff --git a/MAINTAINERS b/MAINTAINERS
index 7b76a80..229d4fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5969,6 +5969,7 @@ M:	Li Yang <leoyang.li@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/misc/dpaa2-console.txt
 F:	Documentation/devicetree/bindings/soc/fsl/
 F:	drivers/soc/fsl/
 F:	include/linux/fsl/
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
