Return-Path: <SRS0=uP4V=P7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C11AC282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:10:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F692085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QJFM+o0V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="KnP9zsYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F692085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X79tQ3nkA0kqqhISxJzbUriUjyb65eitcOcNfLQ3XiA=; b=QJFM+o0VJzdTme
	bYk12P6vCOTmYQyo2IvoZhH1i7Tj0wv/4c2L61cquqJzsGt1cmfK9bVZahKeftswWS50NroF81xZ0
	7o9lFUzTQFkSEN1T0M6YWvRqPBSZVkBjfHfhEJMYZ2yuDxjmFKWbAEZBVDc+N3/namYElE2Tg0j9a
	ZXayc+WJ3MWhAphv/CwrF6tSEyk+qkdgLudN8NVKkkqJXE+1h+YAAESCPEv3tzOUtdPLsAeZVa/2g
	0I7EdY/swpha4hx7LzlrrMkLD6949jZR1iFyGOV9tZuEGnGDUH9pZWr/NivTZrKRcRYwFvjrk1AJO
	da4T0VdNwArB2bgDMikQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmL6c-00049X-G4; Wed, 23 Jan 2019 16:10:22 +0000
Received: from mail-eopbgr820074.outbound.protection.outlook.com
 ([40.107.82.74] helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmL6X-000498-Oa
 for linux-arm-kernel@lists.infradead.org; Wed, 23 Jan 2019 16:10:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf9H9/CbKJptqJMQCSsR3tchXIF8pG0mSE4i+V2JGpk=;
 b=KnP9zsYQajau29zydz0Gd3fxbGL9HZ7HGpZv21CmKlXzVBKAvHNC9vsgAwlcLPv9ZQ+srelbu9qkII19kbIiDYpAWOeBSzHAXFE/pcO8seH5TrhdeVBaQFSjdHBLVaWtN79aHl4dloLios2q0HE9ynjVtH9bW8XhfzG98BE+xhY=
Received: from BYAPR02MB5591.namprd02.prod.outlook.com (20.177.230.89) by
 BYAPR02MB4549.namprd02.prod.outlook.com (52.135.239.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Wed, 23 Jan 2019 16:10:11 +0000
Received: from BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::6841:7658:27bb:cd55]) by BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::6841:7658:27bb:cd55%4]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 16:10:11 +0000
From: Anurag Kumar Vulisha <anuragku@xilinx.com>
To: Kishon Vijay Abraham I <kishon@ti.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>
Subject: RE: [PATCH v5 2/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy
 core
Thread-Topic: [PATCH v5 2/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy
 core
Thread-Index: AQHUltf+YluIb4uVqUmedk5eQWaR76Wxt22AgAIUbRCABZ+FgIADzBGw
Date: Wed, 23 Jan 2019 16:10:11 +0000
Message-ID: <BYAPR02MB5591D126E2290CFCAF335317A7990@BYAPR02MB5591.namprd02.prod.outlook.com>
References: <1545140733-20689-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1545140733-20689-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <b521679a-0c79-44b1-8a2b-1f3391a362ae@ti.com>
 <BYAPR02MB5591E4BF4C547C3E29D9CF8AA7830@BYAPR02MB5591.namprd02.prod.outlook.com>
 <6f0c2f35-f6cd-88ec-32b9-9be247fab4e5@ti.com>
In-Reply-To: <6f0c2f35-f6cd-88ec-32b9-9be247fab4e5@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BYAPR02MB4549;
 6:4Vp37h4zhAGP86h6/DI7QR51+unziPliqraqpiHcIK7QuRd5hopwTcZLRECAMcykoKqAp9wtKcH9dhWokTDZb9UjM2AVeeMVdJv+UEsvrxmFuMtuKOYexBX6J6iD6MhOY0ivYvnKsdETFjsQoUvMeI1ya6T89XVwBR76/iXe2/t7q0ROJt2ZtQ0XRYHjpp5pJ8O3f5KDs4t0LrQ33EKuF8G0QOscGsBpuokOYPjqTLC6TQPhTU4CnGI9t+QjyF0SsVe/QkHpZ253311WtPVK5y9rVRG465LfcVqXE7IsxD51/sXPsV9QaFJYp1loyGrr6v9QrAG3zGgTd1YzD50UAFjKddRKHp9Jb9ijAzck+bLtsYEGEdOfPAJirNXstqgyeXWEdvNbvgQfBKllPOIDehCafwMlDL8H5n6FsYFyB6JeT/Gxhn8aKSFJbr3TkbXQDB0tJW1v/YJQavNz2iq/zA==;
 5:gsANyREfjo2emY4Pnm8sVUQyNTXcetQUIwuBnN3JMR/GOisCFnCyw/13Tva768nOBcR3CUOVYUqxaUZjGgx9M10bhmF0oWUVsdaYtKR+iKYhhYFbIxXyXLnssjysjV274HgfSBvPSaaYEbgt4NSjUNA0EcyrUPYk+OpTpMEaFgICi8rh91Q/5nR77EZ0Q18RYk2iG2mWjzJ4m8LCNyObWA==;
 7:YVd/3WYfI2CpCostcwapfsnLaWHKhBMDFKy1z8kNHVNUhI/yLOGZR3ztg+XQ9EomxsbKh1owTUyt8NZIwGFVKtQHkX6o6SmP57NDJrQQd71Y4GeqYkK9/4WldYUIqsDldfsYjFg4xZaocpm/zABBGg==
x-ms-office365-filtering-correlation-id: c3b11ec3-2ab7-49d7-23f3-08d6814d407a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BYAPR02MB4549; 
x-ms-traffictypediagnostic: BYAPR02MB4549:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB454931BDCB3E0018A74078D4A7990@BYAPR02MB4549.namprd02.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(396003)(346002)(39860400002)(136003)(199004)(189003)(13464003)(316002)(6436002)(186003)(54906003)(33656002)(478600001)(110136005)(66066001)(25786009)(71200400001)(71190400001)(14444005)(53936002)(6246003)(229853002)(39060400002)(486006)(256004)(2501003)(305945005)(4326008)(7736002)(9686003)(86362001)(105586002)(106356001)(97736004)(476003)(14454004)(8936002)(74316002)(81156014)(6116002)(68736007)(81166006)(8676002)(76176011)(99286004)(93886005)(6506007)(53546011)(7696005)(102836004)(26005)(11346002)(446003)(55016002)(2906002)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB4549;
 H:BYAPR02MB5591.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +9JuiOMURUWffz+zWUyN3L2JW774KV3SLGG/nhQE6jGjB2oxH0xylTdi/wvid0979i4gfElKuEP/M48hCaxV/negUnfkk8lS2lVJc4YxkmzAgD5oRIHU6lvvXogjP4cGWtQDjEUFzLljHjMm/3vFllcs/Wy3r2rEGJcgl7EayMsPRS9LXjWk0SEPOR8BmcxpeRSSd4crGkadVe/iU7JiecVh3lAi6sy33ddZ1LIFveiOWf0Fow4ovDRbjBRd7B1kz0Xd3m9/T2JAsMaRFMbRdvBKM2M8QDJPCM0qkCQk2GErehquCpBs5Qc6/nC6k9sPLRm48YrUYXW62d1wPZ+BYIDN+Y+b4iluLudozO2r5o/SqGZY+lUvG6Lp4UIjf+bUODGz89cgAcsFQOTqNjZFTZY665wByltGA2LbVhQyips=
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b11ec3-2ab7-49d7-23f3-08d6814d407a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 16:10:11.2465 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4549
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_081017_900344_2EE655CC 
X-CRM114-Status: GOOD (  19.79  )
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
 Ajay Yugalkishore Pandey <APANDEY@xilinx.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 sundeep subbaraya <sundeep.lkml@gmail.com>, Michal Simek <michals@xilinx.com>,
 "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Kishon,

>-----Original Message-----
>From: Kishon Vijay Abraham I [mailto:kishon@ti.com]
>Sent: Monday, January 21, 2019 11:16 AM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; robh+dt@kernel.org; Mark
>Rutland <mark.rutland@arm.com>; vivek.gautam@codeaurora.org
>Cc: Michal Simek <michals@xilinx.com>; v.anuragkumar@gmail.com; sundeep
>subbaraya <sundeep.lkml@gmail.com>; Ajay Yugalkishore Pandey
><APANDEY@xilinx.com>; linux-kernel@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; devicetree@vger.kernel.org
>Subject: Re: [PATCH v5 2/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy core
>
>Hi Anurag,
>
>On 17/01/19 9:39 PM, Anurag Kumar Vulisha wrote:
>> Hi Kishon,
>>
>>> -----Original Message-----
>>> From: Kishon Vijay Abraham I [mailto:kishon@ti.com]
>>> Sent: Wednesday, January 16, 2019 1:38 PM
>>> To: Anurag Kumar Vulisha <anuragku@xilinx.com>; robh+dt@kernel.org; Mark
>>> Rutland <mark.rutland@arm.com>; vivek.gautam@codeaurora.org
>>> Cc: Michal Simek <michals@xilinx.com>; v.anuragkumar@gmail.com; sundeep
>>> subbaraya <sundeep.lkml@gmail.com>; Ajay Yugalkishore Pandey
>>> <APANDEY@xilinx.com>; linux-kernel@vger.kernel.org; linux-arm-
>>> kernel@lists.infradead.org; devicetree@vger.kernel.org
>>> Subject: Re: [PATCH v5 2/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy core
>>>
>>> Hi,
>>>
>>> On 18/12/18 7:15 PM, Anurag Kumar Vulisha wrote:
>>>> ZynqMP SoC has a Gigabit Transceiver with four lanes. All the high
>>>> speed peripherals such as USB, SATA, PCIE, Display Port and Ethernet
>>>> SGMII can rely on any of the four GT lanes for PHY layer. This patch
>>>> adds driver for that ZynqMP GT core.
>>>>
>>>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>>>> ---
>>>> Changes in v5:
>>>> 	1. No functional changes. Added missing Author name
>>>>
>>>> Changes in v4:
>>>> 	1. Moved include/dt-bindings/phy/phy.h into patch 1 as suggested by
>>>> 	   "Rob Herring"
>>>>
>>>> Changes in v3:
>>>> 	1. Corrected the Documentation as suggested by "Vivek Gautam"
>>>>
>>>> Changes in v2:
>>>> 	1. Fixed the compilation error when compiled phy-zynqmp.c as a module
>>>> 	2. Added CONFIG_PM macro in phy-zynqmp.c driver
>>>> ---
>>>>  drivers/phy/Kconfig            |    8 +
>>>>  drivers/phy/Makefile           |    1 +
>>>>  drivers/phy/phy-zynqmp.c       | 1582
>>> ++++++++++++++++++++++++++++++++++++++++
>>>>  include/linux/phy/phy-zynqmp.h |   52 ++
>>>>  4 files changed, 1643 insertions(+)
>>>>  create mode 100644 drivers/phy/phy-zynqmp.c  create mode 100644
>>>> include/linux/phy/phy-zynqmp.h
>>>>
>>>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig index
>>>> 60f949e..7a3c900 100644
>>>> --- a/drivers/phy/Kconfig
>>>> +++ b/drivers/phy/Kconfig
>>>> @@ -40,6 +40,14 @@ config PHY_XGENE
>>>>  	help
>>>>  	  This option enables support for APM X-Gene SoC multi-purpose PHY.
>>>>
>>>> +config PHY_XILINX_ZYNQMP
>>>> +	tristate "Xilinx ZynqMP PHY driver"
>>>> +	depends on ARCH_ZYNQMP
>>>> +	select GENERIC_PHY
>>>> +	help
>>>> +	  Enable this to support ZynqMP High Speed Gigabit Transceiver
>>>> +	  that is part of ZynqMP SoC.
>>>> +
>>>>  source "drivers/phy/allwinner/Kconfig"
>>>>  source "drivers/phy/amlogic/Kconfig"
>>>>  source "drivers/phy/broadcom/Kconfig"
>>>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile index
>>>> 0301e25..2335e85 100644
>>>> --- a/drivers/phy/Makefile
>>>> +++ b/drivers/phy/Makefile
>>>> +/**
>>>> +
>>>> +/**
>>>> + * xpsgtr_override_deemph - override PIPE TX de-emphasis
>>>> + * @phy: pointer to phy
>>>> + * @plvl: pre-emphasis level
>>>> + * @vlvl: voltage swing level
>>>> + *
>>>> + * Return: None
>>>> + */
>>>> +void xpsgtr_override_deemph(struct phy *phy, u8 plvl, u8 vlvl) {
>>>> +	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
>>>> +	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
>>>> +	static u8 pe[4][4] = { { 0x2, 0x2, 0x2, 0x2 },
>>>> +			       { 0x1, 0x1, 0x1, 0xFF },
>>>> +			       { 0x0, 0x0, 0xFF, 0xFF },
>>>> +			       { 0xFF, 0xFF, 0xFF, 0xFF } };
>>>> +
>>>> +	writel(pe[plvl][vlvl],
>>>> +	       gtr_dev->serdes + gtr_phy->lane * L0_TX_ANA_TM_18_OFFSET +
>>>> +	       L0_TX_ANA_TM_18);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(xpsgtr_override_deemph);
>>>
>>> I thought I gave a feedback to get rid of export symbol. This will make the
>consumer
>>> driver tied to this PHY driver.
>>>
>>
>> Thanks a lot for spending your time in reviewing this patch. With the current
>implementation,
>> if phy-zynqmp.c driver is not compiled and consumer driver calls
>xpsgtr_override_deemph()
>> routine, static inline function in phy-zynqmp.h gets called and error -ENODEV is
>returned. So,
>> with the current implementation the consumer driver is already depending on phy-
>zynqmp.c
>> driver. Please correct me if  my understanding is wrong
>
>If the same consumer is used with 5 different PHYs, we would be adding 5
>different APIs for PHY functionality. We would also like to avoid the compiling
>out option if we use something like a multi_v7_defconfig where a single image
>is used for multiple platforms.
>
Thanks for your comment. As of now the Xilinx Display Port driver is designed to work
with this phy-zynqmp driver (may be generic in future).  Along with Display Port , this
phy driver is being used by 4 other consumer drivers and compiling phy driver as module
might fail if it is tightly coupled with Display Port driver.

Instead , can we use the platform data of the phy->dev to provide the phy platform
specific API's to the consumer drivers. The consumer drivers will  include the
phy-zynqmp.h and call dev_get_platdata(&phy->dev) and call the respective phy
specific APIs. In this way we can get rid of export symbols from driver. The below
is the pseudo code changes for using platform data. Please let me know your opinion
on this,

--- a/include/linux/phy/phy-zynqmp.h
+++ b/include/linux/phy/phy-zynqmp.h
+struct xpsgtr_pdata 
+       int (* xpsgtr_override_deemph)(struct phy *phy, u8 plvl, u8 vlvl);
+       int (* xpsgtr_margining_factor)(struct phy *phy, u8 plvl, u8 vlvl);
+       int (* xpsgtr_wait_pll_lock)(struct phy *phy);
+       int (* xpsgtr_usb_crst_assert)(struct phy *phy);
+       int (* xpsgtr_usb_crst_release)(struct phy *phy);
+       void *pdata;
+}; 

--- a/drivers/phy/phy-zynqmp.c                                                  
+++ b/drivers/phy/phy-zynqmp.c
-int xpsgtr_override_deemph(struct phy *phy, u8 plvl, u8 vlvl)                  
+static int xpsgtr_override_deemph(struct phy *phy, u8 plvl, u8 vlvl)           
 {                                                                              
        struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);                      
        struct xpsgtr_dev *gtr_dev = gtr_phy->data;                             
@@ -327,9 +327,8 @@ int xpsgtr_override_deemph(struct phy *phy, u8 plvl, u8 vlvl)
                                                                                
        return 0;                                                               
 }                                                                              
-EXPORT_SYMBOL_GPL(xpsgtr_override_deemph);                                     
                                                                                
-int xpsgtr_margining_factor(struct phy *phy, u8 plvl, u8 vlvl)                 
+static int xpsgtr_margining_factor(struct phy *phy, u8 plvl, u8 vlvl)          
 {                                                                              
        struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);                      
        struct xpsgtr_dev *gtr_dev = gtr_phy->data;                             
@@ -344,7 +343,6 @@ int xpsgtr_margining_factor(struct phy *phy, u8 plvl, u8 vlvl)
                                                                                
        return 0;                                                               
 }                                                                              
-EXPORT_SYMBOL_GPL(xpsgtr_margining_factor);                                    
                                                                                
/**                                                                            
  * xpsgtr_set_txwidth - This function sets the tx bus width of the lane        
@@ -1111,6 +1107,13 @@ static int xpsgtr_phy_init(struct phy *phy)              
        if (gtr_phy->protocol == ICM_PROTOCOL_SGMII)                            
                xpsgtr_misc_sgmii(gtr_phy);                                     
                                                                                
+       struct xpsgtr_pdata * pdata =                                           
+                       kmalloc(sizeof(struct xpsgtr_pdata), GFP_KERNEL);       
+       pdata->xpsgtr_override_deemph = xpsgtr_override_deemph;                 
+       pdata->xpsgtr_margining_factor = xpsgtr_margining_factor;               
+       pdata->xpsgtr_wait_pll_lock = xpsgtr_wait_pll_lock;                     
+       phy->dev.platform_data = (void *)pdata;                                 
+                                                                               
        /* Bring controller out of reset */                                     
        ret = xpsgtr_controller_release_reset(gtr_phy);                         
        if (ret != 0) {                                                         
@@ -1306,6 +1309,8 @@ static int xpsgtr_phy_exit(struct phy *phy)               
        /* As we are exiting, clear skip_phy_init flag */                       
        gtr_phy->skip_phy_init = false;                                         
                                                                                
+       kfree(phy->dev.platform_data);                                          
+                                                                               
        return 0;                                                               
 }                    

Thanks,
Anurag Kumar Vulisha

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
