Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F599C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:56:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9A521741
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TlF/reYs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SHfyZZFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9A521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WHgQaLsV1wBTRotZQP1II7+ase17epqVMtnTaA0ls1k=; b=TlF/reYsW7lyfp
	DovDr1nj4sgnX+Bzc6AoH4cM4GQ4usGpihKS695+4jOd1zx6TNd+HEALQyp2JhnGezQUT9rc8dzwX
	Q+CpqR50ckKa6ZLwgjvRxdr/eFze+RdDSODc0rn1l94uKNrk3Iv5oJ8e0eQZJ27OIm9jZnRpsPtY8
	tCgMMRMzNVwTn0kaYwsYFYvYHOi/W5lghMYaVSjcgvBFd+lrvdwzphppXr2Ssmi1F9TTxlFYAJVIQ
	+tOU5AIPyEHygP4/9tiuK+TlPGc0P0Z7EflGfmyiQAdJIIlp7yh8NAJFq2LueWQ0oE8+WyuS1B17y
	MVNfphR5yI4Bvbw0gW4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZu7x-00049z-4t; Thu, 20 Dec 2018 08:56:21 +0000
Received: from mail-db5eur03on060f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0a::60f]
 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZu7t-00048b-Ej
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 08:56:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKjfdlfTufn/6WM5DbBbvEtt1I5sJDVpyJNBXPNoL+w=;
 b=SHfyZZFGCyX2vdNSQBscZ7kQ1TJ0nV4vhWYrt7PhfjCh7Ty4/5hmCG2SV4LilZKWDquARKXI3Qiruzk3F91hfz2W3r2IdD1nglSX0+V1J65qVH3xblhyDmySAJlNUF0sO1vVcGxKhRgEybqR8cMdnELFHolCPtuY59ugpVw7N/E=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3797.eurprd04.prod.outlook.com (52.133.29.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Thu, 20 Dec 2018 08:55:59 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::987c:cb59:96c9:6b71%2]) with mapi id 15.20.1425.025; Thu, 20 Dec 2018
 08:55:59 +0000
From: Anson Huang <anson.huang@nxp.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "a.zummo@towertech.it"
 <a.zummo@towertech.it>, "alexandre.belloni@bootlin.com"
 <alexandre.belloni@bootlin.com>, Aisheng Dong <aisheng.dong@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>, Andy Gross <andy.gross@linaro.org>,
 "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>, "heiko@sntech.de"
 <heiko@sntech.de>, "arnd@arndb.de" <arnd@arndb.de>,
 "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
 "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
 "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
 "ezequiel@collabora.com" <ezequiel@collabora.com>, "olof@lixom.net"
 <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-rtc@vger.kernel.org"
 <linux-rtc@vger.kernel.org>
Subject: [PATCH V5 0/4] Add i.MX system controller RTC driver
Thread-Topic: [PATCH V5 0/4] Add i.MX system controller RTC driver
Thread-Index: AQHUmEHTAAw0zsYv3U6nEtMaAOkB6Q==
Date: Thu, 20 Dec 2018 08:55:59 +0000
Message-ID: <1545295872-20169-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0021.apcprd03.prod.outlook.com
 (2603:1096:202::31) To AM6PR0402MB3911.eurprd04.prod.outlook.com
 (2603:10a6:209:1c::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM6PR0402MB3797;
 6:zwf1+iz63/8KdOAfIIZfWianwyU1yVyR2tQOPltho1RcASY8jmTrBIrRQ4hgUZqseOPGNg9eQQYcyQ2n0yt3kba/51HHmY4eQKX7A+AaNk5Yd49kNtkLbGts8WCBGEdDUYtoOuMlL09nzN8C1vywbTH7ljVivZXcq3Ek69D+9my5gDpZDOCJwOlpBJWBgp287+2lZZwHtT5d94/Sx71xjzQLwU/lY7X7SxP05ZVmjLXy3B4UXvH2nd472BYEMvbUE891rTNEUxUqtzUednlbTziIFSbHQDjQc25kdvdXlOdAIk1XOFMvU94YcBROETCjB2BM6UsQdd2FSDonO3DKrLMlDLTmiZ0QNPxl7MchhIMM7fm5SQVCmnHNvlX3BrMx3S4wI/MqHr+h6Gd2+Ew/XBo8RwsOXu2Y/MMke8/0sGvRZY/loYe4itCaD7jK+Z7AMGUBc/9VgNzxjiS91MISqg==;
 5:/sWh1q/wctRhZNp7TuA1IcqqfLoDEwFXSgNanzeo751gfoE9NirL+bH6LR0JdRhQ4tVDB1oqe7h3Bod99RIBxbqst8FfiaqQL4QL23PhvhNNEZOXdwtiWtfu3HDU8sChqn9al+ldn2vZzcVVC8jcQYFfXxCY5ZCDA/3DmM+EdkE=;
 7:w6KNGlj4pqyKFu/iu1Fkzl95dMWEdPmLTpMMGIutO2WPuJCEJILTPY6oRB4f82P74NX6aJFl6lWp1iV7k36PFPdt72CxOPMAcUrZbkis9iTh/k/F34PAg3PyENjG7lYGxFBrq2RylX7vw9dgLFSY6w==
x-ms-office365-filtering-correlation-id: 916d32dc-f5ac-4bef-6b8e-08d66658f5eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM6PR0402MB3797; 
x-ms-traffictypediagnostic: AM6PR0402MB3797:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR0402MB37973DD707ED6A79E9C0BD7FF5BF0@AM6PR0402MB3797.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);
 SRVR:AM6PR0402MB3797; BCL:0; PCL:0; RULEID:; SRVR:AM6PR0402MB3797; 
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(486006)(6436002)(106356001)(71190400001)(8676002)(81156014)(81166006)(71200400001)(14454004)(6486002)(52116002)(2201001)(36756003)(26005)(68736007)(316002)(186003)(86362001)(105586002)(110136005)(102836004)(6506007)(386003)(99286004)(4326008)(478600001)(966005)(3846002)(476003)(6116002)(66066001)(2616005)(5660300001)(7416002)(6306002)(6512007)(305945005)(256004)(8936002)(7736002)(25786009)(53936002)(50226002)(97736004)(2906002)(2501003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR0402MB3797;
 H:AM6PR0402MB3911.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ldwZ2yQMu2ewIe4XPXdEOpxVGeyazmMMoNpvEtWHSZTeELClJioJJfk4hrCZvrbtOofHMHKnY1KgdUAd6lfIYXRW3QeQCKhTM0gFnwGnTQMYInDobmkB2xtZgd3LLIYwM6TARGKL4A1OooRyS33kR+HYBIUEooybiLyvWRMGzfDGMvCIBqoZmo6/zKrj6Akm/Y1Dlc+Gk2R7ke00o+w18M4V7DJxj4trEhe6ALHm/2IGNVURb8RUBgXTF9Rl6T3sDHKmbOUrDmcAbrMd9IHNOlc7u36ClI5iScACBc4+NSeA+gaCqVwlw4KGQEXjd36f
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916d32dc-f5ac-4bef-6b8e-08d66658f5eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 08:55:59.1127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3797
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_005617_499627_C563EC24 
X-CRM114-Status: GOOD (  11.32  )
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
Cc: dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller, the system controller is in charge of system
power, clock and secure RTC etc. management, Linux kernel
has to communicate with system controller via MU (message unit)
IPC to do RTC operation.

Since the RTC set time MUST to be done in secure EL3 mode (required
by system controller firmware) and ALARM functions needs to be done
with general MU IRQ handle, these are NOT ready NOW, so this patch
ONLY supports RTC read time for now.

Note that this patch set is based on [V4,5/5] defconfig: arm64: add imx8qxp support,
https://patchwork.kernel.org/patch/10677315/

Anson Huang (4):
  rtc: add i.MX system controller RTC support
  dt-bindings: rtc: add binding doc for i.MX system controller RTC
    driver
  defconfig: arm64: add i.MX system controller RTC support
  ARM64: dts: imx: add i.MX8QXP system controller RTC support

 .../devicetree/bindings/rtc/rtc-imx-sc.txt         |  10 ++
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   4 +
 arch/arm64/configs/defconfig                       |   1 +
 drivers/rtc/Kconfig                                |   6 ++
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-imx-sc.c                           | 104 +++++++++++++++++++++
 6 files changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-imx-sc.txt
 create mode 100644 drivers/rtc/rtc-imx-sc.c

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
