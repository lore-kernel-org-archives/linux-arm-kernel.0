Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAD_ENC_HEADER,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41426C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:14:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1230821900
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 12:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BEuhMLIq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="L3kUorww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1230821900
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=odt72ukfF97ICSdnIDI9jfE6Y64Hf4zf/IO/ukWBKNI=; b=BEuhMLIquVlfww
	LRvI4d/5ZV0PMfGuBnOX2hcEszH4Aez6tdNU0G94R2LT4mjpAm3QdLI1+k1S1qHJlvAbFG8STW22b
	I9AHOg68m8zdqFHDbWp6h+Jp97vsZ0XbXVFcncUe3y0hwo0D9Tw1OJEJLvQJ9VfGO8vDIszYF2YcS
	ooYH6QeM4NJVu6nGzKIXraXq78ISNlcrCOrhymvC/DOVMnO8nqCGXmh9LRBm/yCYF6paOOMBaoQm2
	tE/usn514UvArFzitUle2dsJkzCCJakAhr6JkL6RMZJcTB2GwqTHBC1q4sWbYTWL2IbCwRnItVP4/
	PQ2uR8V0C4nvBSRLy/Pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guFuT-0000Ya-5S; Thu, 14 Feb 2019 12:14:33 +0000
Received: from esa3.microchip.iphmx.com ([68.232.153.233])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guFuP-0000Xm-KR
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 12:14:31 +0000
X-IronPort-AV: E=Sophos;i="5.58,368,1544511600"; d="scan'208";a="26730443"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 14 Feb 2019 05:14:26 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS)
 id 14.3.352.0; Thu, 14 Feb 2019 05:14:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYBXDRkcg6cnpoDUxjro0pt5dAiDMLk+TW1WtUyqdC8=;
 b=L3kUorwwa8YQqQHRaWWx5i3g+YWeH2wrzG4InaCkCBjIsmrZUqlZxU6HeICw3ZVoAGcjWra7Hxv8TwvbbW22LNfJyYSpn1sX94nO/pnCiRcOxg+35lHz6O7bYH/u8TlMWZVth3WD23PoU8v5yJ41L34F9o07zuG92X7yomzBZ5E=
Received: from MWHPR11MB1920.namprd11.prod.outlook.com (10.175.54.19) by
 MWHPR11MB1518.namprd11.prod.outlook.com (10.172.54.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 14 Feb 2019 12:14:24 +0000
Received: from MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55]) by MWHPR11MB1920.namprd11.prod.outlook.com
 ([fe80::d917:8496:9d53:1f55%9]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 12:14:24 +0000
From: <Claudiu.Beznea@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
 <mark.rutland@arm.com>, <Nicolas.Ferre@microchip.com>,
 <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: [PATCH v2 0/3] add slow clock support for SAM9X60
Thread-Topic: [PATCH v2 0/3] add slow clock support for SAM9X60
Thread-Index: AQHUxF7SveX1oJyCE0iOBw5P5Z4pFQ==
Date: Thu, 14 Feb 2019 12:14:23 +0000
Message-ID: <1550146447-1441-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0502CA0024.eurprd05.prod.outlook.com
 (2603:10a6:803:1::37) To MWHPR11MB1920.namprd11.prod.outlook.com
 (2603:10b6:300:110::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [213.233.85.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48c4f261-992c-4523-5b95-08d69275f4ad
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);
 SRVR:MWHPR11MB1518; 
x-ms-traffictypediagnostic: MWHPR11MB1518:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1; MWHPR11MB1518;
 23:391/TaVUgs0BFoBQ2KwkGsPnCg6lMx/5NHOIOK/?=
 =?iso-8859-1?Q?Dc6CU4MLppoTvHA5z9vRvVX8BA5CwtDsmdScKHxB8o6xDeEDCozx2c4wXL?=
 =?iso-8859-1?Q?uHqMsV6TCATfkk97qa20lajao+AJJfvV42MFAtoLeMQzIai32kD8UmryS4?=
 =?iso-8859-1?Q?olKkuVyuScHQLCDQfG2hNraf3WMxUPD1vWIBEFvYdkjnDhciTA+L1unrDq?=
 =?iso-8859-1?Q?M7QxsOJwyUKwJRV31p6iMhoVOKcbu9rEPFW6PDgih6LtzwwPsRZ6aqdAgl?=
 =?iso-8859-1?Q?/9MULos133qvGzXOpkU61G+/ZilXOzEyCawCrVPAVy6Ax/ze6IEsFmuXfP?=
 =?iso-8859-1?Q?WdJ1uu9pPLMcj9kslNgbX6OgaQz+cGXwLHygb8/6aLMsf/oQ8WPElH7nf/?=
 =?iso-8859-1?Q?Dyh2wddBXRmIO7m6UAKfYa9qw9zqNdrscS+L2xFjmeeFguaNDsPHQ9jTHk?=
 =?iso-8859-1?Q?s3rXGiDCrdTIOZh8ErSx6uZlInSpU2bWR64fffZOqy2ixqc9zDt+961UWg?=
 =?iso-8859-1?Q?48PfVkhbv0N6fhAVt1Ln3ZV/8kaaKjHHC6zNTh3C1X40cABPL7LTeKqZ8v?=
 =?iso-8859-1?Q?RYvMfCzR251SloYncRKcMI0VB8aLLwRGluOLqDJZf2yXsUf5Y2lO4TeFgf?=
 =?iso-8859-1?Q?e+1K/q+pykZutgxL0//d6m6Lk8jz+nW/ajfL2Giz89bHggSaWvEMEkXHCQ?=
 =?iso-8859-1?Q?JxCfDFypzAWy54dVOROFEL95x2fWlKDyEvqTm9nnt8A8rYI5dkKrTArBDO?=
 =?iso-8859-1?Q?VC2c/DFnI3aH50/D2p3iqHdSOYSuiZhiUXcKLEjtU/iA3E7y85qND3fiUh?=
 =?iso-8859-1?Q?AYbKXe6glVZwip7J2/5P87G7CoNyfcCIlQ67xMKuJ3MtlOnegChRmGvjwj?=
 =?iso-8859-1?Q?URSP7dWSMWohbe8B4cRB3pZpPQlY9mlExy0/DiLuZYxp2lOpwokcXoFEKQ?=
 =?iso-8859-1?Q?38e8Gc1iqnbSj3ifJ4BEuAEaBQ7+Wh57KaaVQlsImRoG03gUOMzeMQzBQZ?=
 =?iso-8859-1?Q?Y3kRzOcisS4DX5WgtwLfCbSk2zGHkC1ABnmNLoRvX4a5pKl54UtGkAGCua?=
 =?iso-8859-1?Q?RTAMGyNFLLklF/rqYrTv+5qY6uQAGcToIzpWc48dSJ7JFxanCLFsp1ozh9?=
 =?iso-8859-1?Q?dm8lqOadYa5smVldn2BdtQq5n0OuMBLacccub7sfby9iyhrQ2sz9yxKs+c?=
 =?iso-8859-1?Q?nKRXlESfUfAQ8nAfVAuXDcr51TWFn2RxJd/eaGa0IiJGGh8qv7gTHG1aWl?=
 =?iso-8859-1?Q?Cme6EL0cfdM0ItGeL?=
x-microsoft-antispam-prvs: <MWHPR11MB1518CFA9AA92BB793609C9D687670@MWHPR11MB1518.namprd11.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(136003)(366004)(346002)(376002)(199004)(189003)(72206003)(107886003)(476003)(25786009)(4326008)(52116002)(486006)(6512007)(14454004)(6636002)(478600001)(4744005)(36756003)(3846002)(2616005)(6116002)(97736004)(8936002)(50226002)(54906003)(110136005)(99286004)(7736002)(256004)(186003)(71200400001)(2501003)(316002)(71190400001)(106356001)(68736007)(26005)(81166006)(105586002)(81156014)(2906002)(305945005)(66066001)(6486002)(53936002)(86362001)(6436002)(386003)(102836004)(6506007)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR11MB1518;
 H:MWHPR11MB1920.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Stb2NX0iYNNCGhrI8MNGuy6HzNGkyzRCmXVUkzqkVtlghjdu6KiFwwiVrWjSS679fX6CBaAAPymHzoXqUl+sYEmqdqtDs3ct5gGWlP4Eie3LNiwG2A0Bq0jl/iIKsauvDIOf1DicTgIxne4gZLyFPo89TY35ZqZuTLRd9Vzv104gVlSrv3suXj5jZIfYeJhf97o5GPIjZA3Hmj/LfR41/O35zW9xddZW93D4qRPkuuX4oskM173EurwuxYX+iR2zF9jjs1vSLlmNenoEeme7wYN/H7XsiZXpZROgV6fiBF9SDIjbf1eOwCUlJjQ01lsnArdsGF2ouDB8+gDqSVvz0Vrs8VpgRkhOjlYNkdtuFtvA5LL5HTX/MsfZqJJ6sdWxzMlbus5Y7l2XmZKeKR7AEagTnFgPdZdR0WZ8GtxIDuQ=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c4f261-992c-4523-5b95-08d69275f4ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 12:14:19.7445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1518
X-OriginatorOrg: microchip.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_041429_791774_DDA57C40 
X-CRM114-Status: UNSURE (   8.26  )
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
Cc: devicetree@vger.kernel.org, Claudiu.Beznea@microchip.com,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Hi,

This series add slow clock support for SAM9X60. Apart from previous IPs, this
one uses different offsets in control register for different functionalities.
The series adapt current driver to work for all IPs using per IP
configurations initialized at probe.

Thank you,
Claudiu Beznea

Changes in v2:
- split patch 1/1 from v1 in 2 patches: one adding register bit offsets
  support (patch 1/3 from this series), one adding support for SAM9X60
  (patch 2/3 from this series)
- fix compatible string from "microchip,at91sam9x60-sckc" to
  "microchip,sam9x60-sckc"

Claudiu Beznea (3):
  clk: at91: sckc: add support to specify registers bit offsets
  clk: at91: sckc: add support for SAM9X60
  dt-bindings: clk: at91: add bindings for SAM9X60's slow clock
    controller

 .../devicetree/bindings/clock/at91-clock.txt       |   3 +-
 drivers/clk/at91/sckc.c                            | 142 ++++++++++++++++-----
 2 files changed, 109 insertions(+), 36 deletions(-)

-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
