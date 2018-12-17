Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA985C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:01:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD7820874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CXDx26iq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EJErctTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD7820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ix4KzVW6stBD/lD7ylzpDX0Y1fyhAhMK1Uge7BAE3MA=; b=CXDx26iqs9XHWM
	0qo/foLNwjOFpp/fpXleB+Iw7ZCbxY0otR1sN8hvNHcHk3M6x8eVZYWvH8wfxJYQt4a+XvRpW0Bwo
	DmrqJyxFEe54S7HXTjot5jj5C1liEKyLuR14bWUiW6KdPEHr1f9GpcCF0W8GPWGnk4r8TLRDqml1O
	wALFM//PwFB+c7PkUifmfWHymsrn9v5W5XxrSRcoak12iqU8C0XXU1rGT0hPnNhp8is1sz15Tv6Gf
	5OTDQ83lDGWV9NfTK1qVxoT9ql1ft7NO2gZqdJ8KaHgE6sItdF1KvISNV+2vvERBes7SAoyeglS+/
	e2d3uYfQUYrC2htbUXRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYuOS-0007Xh-MN; Mon, 17 Dec 2018 15:01:16 +0000
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYuOF-0007Fd-37
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 15:01:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ChYejurtTzqE5HsfIckpofM37CRBNi+t1CVUE5Rx0o=;
 b=EJErctTtXNqMbpyxevSPsKVwiFcrXj+G2n0oq0xzPUp6fnp7gihTMRqruna6LUipr4xSdMbwnjVxzmOMlQDOY6h+q/SK/b1ckTgBt/96HZ1h6dClEE8PDwHljScXFjhwLphFUKy1lM4zENKcUFDQJGsKFUxNbqT0hAogLMWLbbI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB6212.eurprd04.prod.outlook.com (20.179.34.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Mon, 17 Dec 2018 15:00:51 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::9125:e806:7303:d8e6%6]) with mapi id 15.20.1425.021; Mon, 17 Dec 2018
 15:00:51 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V5 1/4] dt-bindings: serial: lpuart: add imx8qxp compatible
 string
Thread-Topic: [PATCH V5 1/4] dt-bindings: serial: lpuart: add imx8qxp
 compatible string
Thread-Index: AQHUlhlNkGyPa1kyyE6if9lfu2cjRA==
Date: Mon, 17 Dec 2018 15:00:51 +0000
Message-ID: <1545058517-18643-2-git-send-email-aisheng.dong@nxp.com>
References: <1545058517-18643-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1545058517-18643-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::29) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR04MB6212;
 6:S8qi/xUhGatppiPUd+eVEUbpTDwvNJif9kTkop5MGd1tIUACD7FCcj2SJy0p1ijh9T0x3a2DqKibm/NMcw5k8PDYTL2xvZRFuW2SZe2XYKosmQxw66e6Qqm+/a1ueehzpU9Xxcvl8a9oxlrVBhWrjAV9DAAdZD7ofkT46GbvgTDyRy+y9VnKhFDN6Oqc6IgmwPpLNE5Jlg9dQHYdqcoj3OPreiiO1f62jNAAaBQ53AP7Z9GZfQdfNlajVw+A5l1yW9rOF7pxdo/RoTGzx1zeGltwEMdC/jCVjOBjl0vrmCnfzvspqDACgwBbpK/VczyC0WVsPum8naF+JdirYHdDbR9H4fTgLMyJt4VvGaH8KNA5HrME5dWD4mPf4JVZugdHOwnmmlsT/AaAqfsptExKFfzl5YnW1SU32JfHvzbf5FFjkLz6JhgopEzIx2jVXU53MXze2HgN7X0F/g1Qq3dBiQ==;
 5:lvPIdjTL21xNGOCMuYxlnm57VzKmjeBKuFjVib3LinpaiKJTknFKrwzO+5fss4vCR+pfn4GKxN7fpS8ZZYADsaRzzk2VqjxJlJZ6mToh12dOToHdyL9Ql8D8ZsezOnzEPwMv//gaHao10TJakNIp7hZpeetV5erXy9v/gh+TbNQ=;
 7:ltBUMcRrWmJdjVopizlMJnLrqm4hERHp8EeVGPkHUsawwVYAvmSsYUY0w6dOwtHuMNCVIwZP7IWiTFYhARicnXYatqbdAjChi8Utz2N0Og6DiZEOQ5znf7YAG2PVRob41OgpHBVcv5Lnu25TuD18tw==
x-ms-office365-filtering-correlation-id: 89053282-a590-4499-395d-08d664306f8a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM0PR04MB6212; 
x-ms-traffictypediagnostic: AM0PR04MB6212:
x-microsoft-antispam-prvs: <AM0PR04MB6212AF12A011D0CA5CB5BBC780BC0@AM0PR04MB6212.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005020)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);
 SRVR:AM0PR04MB6212; BCL:0; PCL:0; RULEID:; SRVR:AM0PR04MB6212; 
x-forefront-prvs: 08897B549D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(366004)(136003)(396003)(189003)(199004)(2351001)(81166006)(81156014)(6512007)(39060400002)(99286004)(305945005)(8676002)(106356001)(8936002)(105586002)(6506007)(386003)(186003)(316002)(2616005)(102836004)(6916009)(26005)(11346002)(446003)(3846002)(476003)(478600001)(486006)(6486002)(36756003)(76176011)(44832011)(50226002)(256004)(5660300001)(6116002)(66066001)(5640700003)(25786009)(6436002)(71200400001)(71190400001)(7416002)(52116002)(54906003)(97736004)(7736002)(2501003)(14454004)(53936002)(2906002)(4326008)(86362001)(68736007)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR04MB6212;
 H:AM0PR04MB4211.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2QDSjadB8sRVZAHHyjnL6bghZeboyE5c9yljSbwWpO7Ky3ze7bNGImiu0m+YYj6c4Ek+vcN/RPh6pfhYtB/84WTaUfovOJX1kH+xga05a0uUQpxo1TSuiHX6a9/ri2vrZIrKhYzhxe+c+ZyeWkuf2X5yjn3Eeaz35XmMdUigdgfhA9QgO/GBUSSCuZs2RZXontWAWGjBi3mf2pEnaVQmuIFsFtoYjtKdSvncX7pYrZ4wfqo89eagbkGY+ZuZxvqlqnUvRqhiFosJs2QZDnSsEcy17QtK8QxxKQPjPQrvW09ufeOUPpG2MZO7RLpDrCKh
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89053282-a590-4499-395d-08d664306f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2018 15:00:51.6885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6212
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_070103_133453_FBD87546 
X-CRM114-Status: GOOD (  12.30  )
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
 "dongas86@gmail.com" <dongas86@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add imx8qxp compatible string

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-serial@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
index 6bd3f2e..21483ba 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.txt
@@ -8,6 +8,8 @@ Required properties:
     on LS1021A SoC with 32-bit big-endian register organization
   - "fsl,imx7ulp-lpuart" for lpuart compatible with the one integrated
     on i.MX7ULP SoC with 32-bit little-endian register organization
+  - "fsl,imx8qxp-lpuart" for lpuart compatible with the one integrated
+    on i.MX8QXP SoC with 32-bit little-endian register organization
 - reg : Address and length of the register set for the device
 - interrupts : Should contain uart interrupt
 - clocks : phandle + clock specifier pairs, one for each entry in clock-names
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
