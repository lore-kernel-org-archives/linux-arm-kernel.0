Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011EEC04EBF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:52:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68DE2146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eU7XRjLS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="tbDJiGBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68DE2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WC6XxzIsctXPc6y9a3452xYwZlnGoDP71vpbA/oSiLI=; b=eU7XRjLSPBpjbw
	tCno5uTkv4yiFAjdFKm5y7kxwDqGufd4pBLzlwNeu6qxNQQu1WLgWQy7BZQYDfcg8ev4MzqMau/0g
	Z72/EKNwi3wiIUavZwPf6rOAOPxmVAq82Sj/lgSGo5Aj9hvxCGeR60o4jaDnmQZRQXUkCnDDVEcFV
	5+nLqXED4JbeegdmmKEuNiWka+l6NWmFWHZRjPqaitjDdezr9yh7y7/QLcwyCRFYwcZdVZUl9mU2F
	8jZOsojPB/CxN7/6w7uR/r3jOcCiJrAhNmvPGGfvnBqIXXH549BJQ0j/OZYm+Z++qOOB4gZCVsutj
	5fwiPZjubL2yG2nHBKPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gU7Ni-0006Qy-Ee; Tue, 04 Dec 2018 09:52:42 +0000
Received: from esa1.microchip.iphmx.com ([68.232.147.91])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gU7Ne-0006On-Pw
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 09:52:40 +0000
X-IronPort-AV: E=Sophos;i="5.56,313,1539673200"; d="scan'208";a="24818631"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 04 Dec 2018 02:52:26 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 4 Dec 2018 02:52:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx8RTOLHjFGz64565bGMn3Uo9q3o6mxJx1rNblBddic=;
 b=tbDJiGBpBT5r4H3mEsB4yqQwWos8AihUuMnEBSkZnoHQOsefktTXtxMt4jQiHUmY+E/cclENRQp8kCEkzqp/YO2fys57RNndkI5aU0K9QI1ica+d72HPTuzF0JmLLo+assgH5HTFv4k+yYVeVd8+rE/iD4mpVOH1i1e2oxaarTA=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2083.namprd11.prod.outlook.com (10.174.112.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Tue, 4 Dec 2018 09:52:24 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::853f:28dc:6c66:cfb1%5]) with mapi id 15.20.1404.016; Tue, 4 Dec 2018
 09:52:24 +0000
From: <Andrei.Stefanescu@microchip.com>
To: <lgirdwood@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <gregkh@linuxfoundation.org>, <Nicolas.Ferre@microchip.com>,
 <Cristian.Birsan@microchip.com>, <Claudiu.Beznea@microchip.com>
Subject: [PATCH v3 0/3] add support for MCP16502 PMIC
Thread-Topic: [PATCH v3 0/3] add support for MCP16502 PMIC
Thread-Index: AQHUi7cOioaYpdg38U6AU5gvRbXQdA==
Date: Tue, 4 Dec 2018 09:52:24 +0000
Message-ID: <1543917126-32572-1-git-send-email-andrei.stefanescu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0214.eurprd07.prod.outlook.com
 (2603:10a6:802:58::17) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BN6PR1101MB2083;
 6:eZoo9BRuk2JSOI7/q1OiJGMkiy/mDEyzquJU4poivts50s35yZTySf3D+JMFI5jAmOi8U4Tcsldb2vCw6H/akcRuatAW2PLFg0cOmw6ceBBwLtBGrFGlYKO9JIo9T9yvW7+/XDZxeUesLYpuw+MQA4CUjwrMsq/JX3VquUtWGZ9SFQblwxmM1+oOilquevrA99EmV/lhBh2SyqSEfvDnTS9N/uEIKTqt4AS3wkF3kCptyY2jif1ABXNg3iM/ZblQ4bWoIqa6GoWCX/ha4rJuWjOUDsTP9T3D4jOut/JgSv+BNE45XEAdu98Nxisp6zn5vfjwKOOKIBXj7A8+TVwNukf/nHx3dIUXVaElXbZeDPTgVaasn3/YZdMvbhEZ0JqIZFcGdQl3eR8B/s8B1LgcniWsASQ9WEMFZeWYznJi4EUQZHpNhi9v3GoZCoAIwQAyZTMlVaZlWhxZkw/Qxianyw==;
 5:tFSmz6ddfaczrEkGkY2+2lDuTcRDk+O6FaPFymBxNcSafGtw8A6/SmLn6H/tVsCHoGTKmOemJ3PIc4gLCIrf5Eyd35QSjNSIJVXb7t2DrRErOvIPNIgq1sURxE4++bs6GfRK0p/uH449t967u2l7MQadZi+TEAkA1YH0udnxGWk=;
 7:uf5eTmrP6Wyi/2rhdRLpHrDgpqmIxLdGwYYdaQhfnN7u/U2K11vXap9rmg3HTVLNR+AZ2gJuYNPQCY6ISVh68NUhOe+9vpzkoHL4piEtIgKBvAD64FbaT5VbhGrSfgh3Tcfg4T1Q89v/ZOBx+fCbMA==
x-ms-office365-filtering-correlation-id: d1c612e9-13cd-432a-5cce-08d659ce30d0
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BN6PR1101MB2083; 
x-ms-traffictypediagnostic: BN6PR1101MB2083:
x-microsoft-antispam-prvs: <BN6PR1101MB20834E71B589BBA33F66501DEDAF0@BN6PR1101MB2083.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501493)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:BN6PR1101MB2083; BCL:0; PCL:0; RULEID:; SRVR:BN6PR1101MB2083; 
x-forefront-prvs: 0876988AF0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(136003)(396003)(376002)(39860400002)(366004)(199004)(189003)(386003)(54906003)(478600001)(186003)(2501003)(72206003)(14454004)(110136005)(2616005)(107886003)(316002)(26005)(102836004)(105586002)(106356001)(6506007)(4326008)(97736004)(39060400002)(36756003)(53936002)(68736007)(81166006)(7736002)(81156014)(6436002)(256004)(8936002)(8676002)(305945005)(6512007)(6636002)(66066001)(14444005)(86362001)(25786009)(2906002)(476003)(486006)(6116002)(99286004)(6486002)(71200400001)(52116002)(5660300001)(71190400001)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1101MB2083;
 H:BN6PR1101MB2243.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LrHuu4+k+bEceNHcPGYAzenFUNg0QgySbQILWC5QzELfo5ilUHTxoFLbn3fNyA/JV4fIsDqZmqp0lM2mSdxpRyN85XRjxyVpl7RCl7JoQ4gGoDL+RunI+d1dnLgHOLlvOOlOGwZSrk4m0QQFjFgYK8ra67opJUccI1ucX30aqMCAcCUPJoDBLSFd3HUwZyLduu3bKd5iRTjPKHjrohV9UKDOIWtZVml1xcAOzU/M1thydIE/cvCgLtaeY3X2CZYvhIfzbl3QvB88BRWjuSPbQHmodfKfeVo80VOa/BfkNOWvA8XdpinMgTYKAbZRLCnlgwwGipmNNHxuwBtLEGh48Lx+3l2R0PgfqFgrNce/3po=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c612e9-13cd-432a-5cce-08d659ce30d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2018 09:52:24.0183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2083
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_015238_846134_CA080BAC 
X-CRM114-Status: GOOD (  14.95  )
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
Cc: devicetree@vger.kernel.org, Andrei.Stefanescu@microchip.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MCP16502 is a Power Management IC from Microchip.
It has 4 Buck outputs and 2 LDOs. The buck regulators
can be used in two modes: normal(FPWM) and low-power(Auto PFM).

This patch series adds support for the MCP16502 PMIC.

v3:
- use CONFIG_SUSPEND and CONFIG_PM to fix compile errors for some configs

v2:
- use lpm-gpios instead of lpm-gpio in devicetree bindings documentation
- describe the regulators present on the PMIC in the devicetree bindings
  documentation
- add SPDX license inside a C++ comment
- prefix macro
- remove mcp16502_update_regulator and mcp16502_read
- replace ?: with if-else
- change some if-else with switch statements for legibility
- use regmap helpers for regultor settings during runtime
- make mcp16502_get_status read the status from the PMIC STS registers
- use module_i2c_driver
- use the PMIC's Hibernate registers for suspend-to-mem, the PMIC's
  Low-power registers for standby and the PMIC's Active registers for
  normal runtime

Note about mcp16502_suspend:
- mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_HIB) has now been changed to
  mcp16502_gpio_set_mode(mcp, MCP16502_OPMODE_LPM) for legibility.

Note that the function call only sets the LPM pin of the PMIC to high.
This puts the PMIC in Low-power operating mode. Hibernate operating mode
is reached when the MPU sets the PWRHLD line to zero (typically when
entering suspend-to-ram).

Andrei Stefanescu (3):
  regulator: dt-bindings: add MCP16502 regulator bindings
  MAINTAINERS: add maintainer for MCP16502 PMIC driver
  regulator: mcp16502: add regulator driver for MCP16502

 .../bindings/regulator/mcp16502-regulator.txt      | 143 ++++++
 MAINTAINERS                                        |   7 +
 drivers/regulator/Kconfig                          |   9 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/mcp16502.c                       | 555 +++++++++++++++++++++
 5 files changed, 715 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
 create mode 100644 drivers/regulator/mcp16502.c

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
