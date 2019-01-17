Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADFEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:09:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77CE1205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="focooSSr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="soZu0BNe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CE1205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tKBr8+/UTtEI3leZIgm2pp5nRb+3sVklgzD+lSCtdoI=; b=focooSSru4jBK9
	bjwCSTkf+UMhY687h2uyppu2XQ8KLEJXoVudoz0ZDfFwPUgVr/+wZxsYB0uFKXkzKwVcuK/xNFY+F
	lVz9eMsyLEx74upHpL/88XGTolH1aoAkvb6vsb/eTe2jGiZthBEq5xBoEr2SrrcWe89awPREr34jO
	hhNePn/8sIcx4fhkl/s7h4isgFJPcSBBk1wQUeo7O3bsE3NB4DmI/yUT9aRUoqWO7y28aAKU0Stxb
	qaPQ5K6xxwCYMOqt4BJgYDQBI/tckDwsr0ZMLIQla4h67O438Krl+xg8+IPsnkU7TeWpm0lyjzPm8
	bhmdthoNEMbOymebeOFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkAEe-000237-75; Thu, 17 Jan 2019 16:09:40 +0000
Received: from mail-eopbgr720084.outbound.protection.outlook.com
 ([40.107.72.84] helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkAEa-00022e-AY
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 16:09:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSJTuAUkof/v4mX9NatQcrmRngz0wVmViznedB8xZOw=;
 b=soZu0BNelFeEE/m5vLb2EAEYb3iD1fVFqc4AwownrdT1Du7V20sxcurgfFrTZAbwHu9Swmm4FXsspzaTmpLWJccdRk21RESGVXj77+FPiQIVcAeE8/3V6psSS2vKfA8FQ/e28/1QccWcYHkptisgC9PzqrI40EXCCSQb7PLzGLA=
Received: from BYAPR02MB5591.namprd02.prod.outlook.com (20.177.230.89) by
 BYAPR02MB4725.namprd02.prod.outlook.com (52.135.232.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.25; Thu, 17 Jan 2019 16:09:31 +0000
Received: from BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::b99c:d66c:95dd:5a7b]) by BYAPR02MB5591.namprd02.prod.outlook.com
 ([fe80::b99c:d66c:95dd:5a7b%3]) with mapi id 15.20.1516.019; Thu, 17 Jan 2019
 16:09:31 +0000
From: Anurag Kumar Vulisha <anuragku@xilinx.com>
To: Kishon Vijay Abraham I <kishon@ti.com>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>
Subject: RE: [PATCH v5 2/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy
 core
Thread-Topic: [PATCH v5 2/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy
 core
Thread-Index: AQHUltf+YluIb4uVqUmedk5eQWaR76Wxt22AgAIUbRA=
Date: Thu, 17 Jan 2019 16:09:31 +0000
Message-ID: <BYAPR02MB5591E4BF4C547C3E29D9CF8AA7830@BYAPR02MB5591.namprd02.prod.outlook.com>
References: <1545140733-20689-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <1545140733-20689-3-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <b521679a-0c79-44b1-8a2b-1f3391a362ae@ti.com>
In-Reply-To: <b521679a-0c79-44b1-8a2b-1f3391a362ae@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BYAPR02MB4725;
 6:YiNQcLP1HkR/ljunmpHXuQXyjJHdByZttQcRL44vXM0MBRyD0aPpAH3y3ajN5G9/c/idGJzfNGJaVBkgR3qTZ1iCLLYiy3s9DrAvv60op1JH5IrlAbRhvmblI4CgxCNTeixtuYj8rz1rhT203R+bUx7mu/qqLCE6rZ/vZYmT4deuEEGTaBISbygexugBIOvEbMR3kdBA97A4HNBiyfmmYxdmc4qpbyQMIHUmMfutlRouqjytgkDfhal+GseA1zFho7OoGtWOKIDX+ZQHiYWhjWdO2IMC4tREyty/V5GDBwZ+ZDJngr0MBkbkIwQnOZTnEWVrYtVxTkyBYsybvoNeLb+uAJ60yxkeV9YyJWFKvqdG+JgwzgdtAFxzUQlcqwUJYOpiz0TNOgksyMcFqA/rUrvhI0o4edtZknDWMCqei3FLCPrwWfx4ezzoz3/fKggO3Q9oHzwP1SRNNtxbl9PTXA==;
 5:12PCb/WiLnkpg12xMXhnzvCDGfcyG8xEkG+/mApDrfGHcrcxJibfAIK+4EWo1/Wt3x4L+rvfuudo/8cBF4pXxAVyM4q/+uRVeuEo7gBXtT1GJxtB7DJLeen/tnGBD2wBtDayaLA27MSVhezttIhg/DQddcjVUbVn4ddZ/1hMvmoVb7LgqN5MGlqR6VQXXBLiZ0+ryFCUJbKpblBaYQhZ3A==;
 7:P8+Jw4M6KcbtibBlDSZY1vX6usf79qHc6uktxRFWvI5ViZaURsC6A+AvoDwLjMCouA2Fkn3N9Zx/LXaSWmbYvuj2qMReMFImKV1oGKS1Y0MeC8Em5BRYuX5GoNneeG7ProHTF94gUVlor11eD58sEA==
x-ms-office365-filtering-correlation-id: 1c627370-94e4-4ede-e665-08d67c962a49
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:BYAPR02MB4725; 
x-ms-traffictypediagnostic: BYAPR02MB4725:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB47255D963DC23755196EC473A7830@BYAPR02MB4725.namprd02.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(346002)(366004)(376002)(39860400002)(136003)(396003)(189003)(199004)(13464003)(110136005)(478600001)(316002)(99286004)(86362001)(54906003)(6246003)(7736002)(97736004)(305945005)(6506007)(256004)(68736007)(26005)(229853002)(186003)(8936002)(81156014)(81166006)(102836004)(74316002)(8676002)(76176011)(486006)(7696005)(53936002)(5660300001)(105586002)(39060400002)(55016002)(25786009)(106356001)(33656002)(2501003)(2906002)(446003)(11346002)(476003)(66066001)(4326008)(6436002)(6116002)(3846002)(71190400001)(71200400001)(9686003)(14454004)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB4725;
 H:BYAPR02MB5591.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vLWvBHbSwL5KglisbKYa2uTAmBQws4irJ3huP9/5GJvdppeqBYowHShaFw+ciwJ8pJ7XRUo+/bJu4g9r5tjjOlrF/llidOzUf6II4nCAZ0yGWIsK7nj+VdIoRpN71OhMDPfLylrzHTtXKO00J3zQjuQE6bWkm85Aq8YUeMzpziYZbQ9oONfn7hk3KjdHhFe9kPEJIuJ02UjasdrTBvHOoVcMu8wD9OJ6fjHmlremKUdA4mfkO1oWQPce5jaH4vSuubInit1Mj5nXVzgWlAZyfMwmqA9oDu6frVdIBxBaGR8XpJ+Nb495cGFEXGnPhyqlIbMVGRbLy089+HQVyJ8P3xpdWoGmYuEz2xYCuP6N6lCN1tKNyARTdDDkfqFX6oJWAV6iYg8rcUTmxsQqlTEMNYYPSszo4OQ5eUDrjyyoDrk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c627370-94e4-4ede-e665-08d67c962a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 16:09:31.4387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4725
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_080936_416937_157A4506 
X-CRM114-Status: GOOD (  18.30  )
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
>Sent: Wednesday, January 16, 2019 1:38 PM
>To: Anurag Kumar Vulisha <anuragku@xilinx.com>; robh+dt@kernel.org; Mark
>Rutland <mark.rutland@arm.com>; vivek.gautam@codeaurora.org
>Cc: Michal Simek <michals@xilinx.com>; v.anuragkumar@gmail.com; sundeep
>subbaraya <sundeep.lkml@gmail.com>; Ajay Yugalkishore Pandey
><APANDEY@xilinx.com>; linux-kernel@vger.kernel.org; linux-arm-
>kernel@lists.infradead.org; devicetree@vger.kernel.org
>Subject: Re: [PATCH v5 2/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy core
>
>Hi,
>
>On 18/12/18 7:15 PM, Anurag Kumar Vulisha wrote:
>> ZynqMP SoC has a Gigabit Transceiver with four lanes. All the high
>> speed peripherals such as USB, SATA, PCIE, Display Port and Ethernet
>> SGMII can rely on any of the four GT lanes for PHY layer. This patch
>> adds driver for that ZynqMP GT core.
>>
>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>> ---
>> Changes in v5:
>> 	1. No functional changes. Added missing Author name
>>
>> Changes in v4:
>> 	1. Moved include/dt-bindings/phy/phy.h into patch 1 as suggested by
>> 	   "Rob Herring"
>>
>> Changes in v3:
>> 	1. Corrected the Documentation as suggested by "Vivek Gautam"
>>
>> Changes in v2:
>> 	1. Fixed the compilation error when compiled phy-zynqmp.c as a module
>> 	2. Added CONFIG_PM macro in phy-zynqmp.c driver
>> ---
>>  drivers/phy/Kconfig            |    8 +
>>  drivers/phy/Makefile           |    1 +
>>  drivers/phy/phy-zynqmp.c       | 1582
>++++++++++++++++++++++++++++++++++++++++
>>  include/linux/phy/phy-zynqmp.h |   52 ++
>>  4 files changed, 1643 insertions(+)
>>  create mode 100644 drivers/phy/phy-zynqmp.c  create mode 100644
>> include/linux/phy/phy-zynqmp.h
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig index
>> 60f949e..7a3c900 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -40,6 +40,14 @@ config PHY_XGENE
>>  	help
>>  	  This option enables support for APM X-Gene SoC multi-purpose PHY.
>>
>> +config PHY_XILINX_ZYNQMP
>> +	tristate "Xilinx ZynqMP PHY driver"
>> +	depends on ARCH_ZYNQMP
>> +	select GENERIC_PHY
>> +	help
>> +	  Enable this to support ZynqMP High Speed Gigabit Transceiver
>> +	  that is part of ZynqMP SoC.
>> +
>>  source "drivers/phy/allwinner/Kconfig"
>>  source "drivers/phy/amlogic/Kconfig"
>>  source "drivers/phy/broadcom/Kconfig"
>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile index
>> 0301e25..2335e85 100644
>> --- a/drivers/phy/Makefile
>> +++ b/drivers/phy/Makefile
>> +/**
>> +
>> +/**
>> + * xpsgtr_override_deemph - override PIPE TX de-emphasis
>> + * @phy: pointer to phy
>> + * @plvl: pre-emphasis level
>> + * @vlvl: voltage swing level
>> + *
>> + * Return: None
>> + */
>> +void xpsgtr_override_deemph(struct phy *phy, u8 plvl, u8 vlvl) {
>> +	struct xpsgtr_phy *gtr_phy = phy_get_drvdata(phy);
>> +	struct xpsgtr_dev *gtr_dev = gtr_phy->data;
>> +	static u8 pe[4][4] = { { 0x2, 0x2, 0x2, 0x2 },
>> +			       { 0x1, 0x1, 0x1, 0xFF },
>> +			       { 0x0, 0x0, 0xFF, 0xFF },
>> +			       { 0xFF, 0xFF, 0xFF, 0xFF } };
>> +
>> +	writel(pe[plvl][vlvl],
>> +	       gtr_dev->serdes + gtr_phy->lane * L0_TX_ANA_TM_18_OFFSET +
>> +	       L0_TX_ANA_TM_18);
>> +}
>> +EXPORT_SYMBOL_GPL(xpsgtr_override_deemph);
>
>I thought I gave a feedback to get rid of export symbol. This will make the consumer
>driver tied to this PHY driver.
>

Thanks a lot for spending your time in reviewing this patch. With the current implementation,
if phy-zynqmp.c driver is not compiled and consumer driver calls xpsgtr_override_deemph()
routine, static inline function in phy-zynqmp.h gets called and error -ENODEV is returned. So,
with the current implementation the consumer driver is already depending on phy-zynqmp.c
driver. Please correct me if  my understanding is wrong

Best Regards,
Anurag Kumar Vulisha
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
