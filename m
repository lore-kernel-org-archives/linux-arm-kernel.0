Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD832C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:37:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D17120869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 20:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="he77aqax";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="b9e+34WO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D17120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0LPQ8ANvIXE9zCn+zytt1VK0KJgAI7JvPe916wLEGts=; b=he77aqaxxkbXIH
	2OivXyZ4Biqyy9wO4U6A2T6KH3FKIFBXrsM+v3dXxZxdu3Z1WYGPzVqSaZyca0thVk6gaaKo26z+b
	ZlXAQs0fhDKzaA6PhqacowWJKVU/ug3SQxXG8L0Gt2N7Ltx2DMqnpU42nFiSQ3Ql1h5+Nqzk5GDEC
	WSWMWSn523BgOUvKQZ3XNgRERK65D0h94Kkx1Otosib4LBq/JHa4TKoIQrVeyQMH1OPzl2CHciJxw
	p9jah3gZ9xzjS+YoOlxF+54uLa8ERGaPfMzou3J2U3MPBhP7EwrSOjx/xY5l9eXz+1WbUwrpquOP/
	h5jAF5O8fyuZmcHDik1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZib9-0000L7-2P; Wed, 19 Dec 2018 20:37:43 +0000
Received: from nat-hk.nvidia.com ([203.18.50.4])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZib5-00009G-KI
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 20:37:41 +0000
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by
 nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c1aabef0000>; Thu, 20 Dec 2018 04:37:08 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
 by hkpgpgate101.nvidia.com (PGP Universal service);
 Wed, 19 Dec 2018 12:37:08 -0800
X-PGP-Universal: processed;
 by hkpgpgate101.nvidia.com on Wed, 19 Dec 2018 12:37:08 -0800
Received: from DRBGMAIL103.nvidia.com (10.18.16.22) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 20:37:01 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by DRBGMAIL103.nvidia.com
 (10.18.16.22) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 20:37:00 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS)
 id
 15.0.1395.4 via Frontend Transport; Wed, 19 Dec 2018 20:37:00 +0000
Received: from BYAPR12MB2759.namprd12.prod.outlook.com (20.177.125.224) by
 BYAPR12MB3431.namprd12.prod.outlook.com (20.178.196.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 20:36:57 +0000
Received: from BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::e84a:c18d:d054:a562]) by BYAPR12MB2759.namprd12.prod.outlook.com
 ([fe80::e84a:c18d:d054:a562%5]) with mapi id 15.20.1425.021; Wed, 19 Dec 2018
 20:36:54 +0000
From: Krishna Reddy <vdumpa@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v3 2/6] iommu/arm-smmu: Add support to program multiple
 ARM SMMU's identically
Thread-Topic: [PATCH v3 2/6] iommu/arm-smmu: Add support to program multiple
 ARM SMMU's identically
Thread-Index: AQHUi3HohTFTyEkkrkCvZNWsed0MjqWGdHoAgAAGqLA=
Date: Wed, 19 Dec 2018 20:36:54 +0000
Message-ID: <BYAPR12MB2759C4AB588260ECB46046E3B3BE0@BYAPR12MB2759.namprd12.prod.outlook.com>
References: <1543887414-18209-1-git-send-email-vdumpa@nvidia.com>
 <1543887414-18209-3-git-send-email-vdumpa@nvidia.com>
 <5e1b242c-d2d5-9478-6726-2921bea9f3dc@arm.com>
In-Reply-To: <5e1b242c-d2d5-9478-6726-2921bea9f3dc@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2018-12-19T20:36:52.6244647Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic;
 Sensitivity=Unrestricted
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdumpa@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; BYAPR12MB3431;
 6:ANFYlYbp6RdW0DQdPROWcfg3WZxQrFdG/0W42S+TBjn9mmp2GlB3imipD5X6dyrRuTxNkh6Udu8MbMA11Xfas5lWtxT9Tlq7gajYkaNs/GdUkJ5wdIBzFnjbpr+fZKl6hFYLju4mhcIR0pC7soPscpycAd4NwS9kvNJULUegagoX0NBmRTsfn7gjNbZ8KOToVZSVYqwyBhSdSCa1eXxKh0O63mCyAjyN5hfNPxBGGqtYPP8yy0bwIqxMvm7Jc+1roV+uucgU5dNsv37GVKGx8cWZ6ZKldkzwvptQ/zglljRo3DEh/LQSdRWkRPgQs8dK5mjHDnAL2XjGwH8IHK96YwM4tc0CBRdkTPxxF/apChkXCm3PexggMPedeN04QT4M5hWcPAFbA5vB7yJjc1nUA2JKSQ2OYnoaebA1Tmd4oC0YJgkLbkPZ3OZkes+VHdXHUw8C7hpF73zpV2KnITfSjg==;
 5:oCKStBuh3d8rk/X8ZQZFmhDjkJAb2QzD6L3C6PACtfXl/LSbXVXNKl4siBrmcDvjwNlQW2kD1bz0t+EhRTpc84CilpEmbtUr9DWEWFryeMEi0dXn2KW+SaSmmVYTKU6ylWno4KD/dFALOu/JaMrNbRETn521vlmqcx3Iz472GAU=;
 7:Qd4KuuSsM4InHe0Y3TqupkUxHvZ6JfcHXMh2Q+mJBQv8h8BLv54ICD8ZjQgez+vQajdDk3d+5dqhA0HQl2La2Qtui8gBHLIWlrq2egBJXGsVi7X0X353PlqbkVdBtXNHIfVTHrGQvUwmMIwK1naerw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10009020)(136003)(396003)(376002)(39860400002)(366004)(346002)(199004)(51914003)(189003)(66066001)(26005)(186003)(6506007)(97736004)(76176011)(2501003)(25786009)(81166006)(102836004)(8936002)(7736002)(68736007)(99286004)(110136005)(316002)(54906003)(486006)(256004)(81156014)(8676002)(476003)(106356001)(105586002)(2906002)(33656002)(2201001)(5660300001)(71200400001)(74316002)(71190400001)(86362001)(229853002)(11346002)(446003)(6116002)(7696005)(3846002)(6436002)(305945005)(55016002)(9686003)(478600001)(4326008)(6246003)(53936002)(14454004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3431;
 H:BYAPR12MB2759.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-office365-filtering-correlation-id: 1231ef6d-853f-48a1-beb0-08d665f1b671
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:BYAPR12MB3431; 
x-ms-traffictypediagnostic: BYAPR12MB3431:
x-microsoft-antispam-prvs: <BYAPR12MB3431EFFE0574E02AAE9362DBB3BE0@BYAPR12MB3431.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:BYAPR12MB3431; BCL:0; PCL:0; RULEID:; SRVR:BYAPR12MB3431; 
x-forefront-prvs: 0891BC3F3D
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: hqCZOzFq86rtP1IOANk82Wp1MFbwkxiV6LoJ1jD4EZSPl30qnsegzccp1if7d2gI+RjH981NVsw4mAK4s7oi4VtrxCTOKunFq/2TpTMy9Pe+Kpp7PRjKewMpxtHL6bVsn/Dm9z0uioFNi60VfcezS31jSrKIR2F5EjbEYmeij+bAgoP83jNSM9Ladk6E3VSkSpE9AurRfwwRoCAMtU/zFWvwM+R2IVUA8qSHaJLx4U0BhWewS3T5vTboZJjnKcZSKAFnj/hDdJjrRu2+wORzy11Jx0icTScnMooKAh0W7MIWYkj5C6WGlqkCmDnLf6AR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1231ef6d-853f-48a1-beb0-08d665f1b671
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 20:36:54.0474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3431
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1545251844; bh=aTpf7kCBBu5S3aQqnvhWBB0E2KhZ+sHEu+lCbdxes14=;
 h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
 Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:msip_labels:authentication-results:
 x-originating-ip:x-ms-publictraffictype:
 x-microsoft-exchange-diagnostics:
 x-ms-exchange-antispam-srfa-diagnostics:
 x-forefront-antispam-report:
 x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
 x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
 x-ms-exchange-senderadcheck:x-exchange-antispam-report-cfa-test:
 x-forefront-prvs:received-spf:x-microsoft-antispam-message-info:
 spamdiagnosticoutput:spamdiagnosticmetadata:MIME-Version:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
 Content-Language:Content-Type:Content-Transfer-Encoding;
 b=b9e+34WOGpvT7cHw8+hgDO5F24vF+LmuBZc+eRSytScEDKgPMii7mlTIZUXxZpkfe
 /6t+cG402rLRLWvchf04IQDgBbUv0qyhxogn9q33Y1UyqAs+Zq5iF4572Pdl3i6s4s
 EKQDcXIipr4osWEgCSr1KoT6YHhfCtx3JzWtGg49I3BkY184av845NjddBIV0m9qHr
 LjCCZONyHFlo4291gTDL3h+4IjVtHejxvqCR1QFxUVMQ57wTi1HiY8VmNbKFw5ocCH
 +Kf4WiUSgW4g/K2UCK7p/RoYMgfPAsnjOabJ6Amir659IJyLiCpeE+YWb7Q2TJaLNQ
 JMgOziNnrAgvw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_123740_325940_3EF8E4AA 
X-CRM114-Status: GOOD (  16.72  )
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
Cc: Sachin Nikam <Snikam@nvidia.com>,
 "Thomas Zeng \(SW-TEGRA\)" <thomasz@nvidia.com>,
 Juha Tukkinen <jtukkinen@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 Pritesh Raithatha <praithatha@nvidia.com>, "jon.he@arm.com" <jon.he@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Timo Alho <talho@nvidia.com>, "olof@lixom.net" <olof@lixom.net>, Yu-Huan
 Hsu <YHsu@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Thierry Reding <treding@nvidia.com>,
 Alexander Van Brunt <avanbrunt@nvidia.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Robin,
Thanks for the feedback :)

>The whole point of the library idea was to factor out the code in such a way that all the details
>specific to a particular implementation can be kept together. But what this patch does is insert
>Tegra194-specific handling all through the 'common' code, which is the exact opposite of that concept
>and just makes more hard-to-maintain mess.

In an attempt to reuse most of the ARM SMMU implementation, which heavily relies on data from arm_smmu_device,
The library code has been added with some functionality only usable by Tegra194 SMMU driver. 
In V4 patches, I am working on to add a mechanism to override writel/readl functions in library so that
Tegra smmu driver can override read/write functions and handle programming of multiple instances on its own. 

>The amount of copy-paste duplication in patch #4 has the opposite problem - about 95% of that isn't 
>Tegra194-specific at all (I mean, how many fsl_mc instances does it have?), and having multiple copies of
> generic code with the potential to diverge is also not what anyone wants.

I have split the code in a way that library only contains the code that deals with register programming.
And avoided platform driver code and DT parsing code getting into library, which can allow drivers changing
Independently if necessary in future.

> Plus I don't think ending up building 
> multiple separate drivers will even work in general - thanks to the current state of
>bus_set_iommu() etc., you can't use the regular driver for your third SMMU at the same time.

Good point!
From code, platform_dma_configure/of_dma_configure/of_iommu_configure takes care
of setting right iommu_ops for devices based on the iommu DT node they have in iommus=<> entry.

If iommu.c is updated to use dev->bus->dma_configure(),  then it doesn't really need to use dev->bus->iommu_ops.
dev->bus->dma_configure() can be used to set dev->dma_ops to the right one, if dev->dma_ops is not
already set. 
If this approach looks good, I can make a patch to clean up bus->iommu_ops usage related code to allow
devices to use specific SMMU instance as they need.

>I think what really needs to be done is to conceptually split the driver into "architecture" and "implementation"
> layers - at some point after the holidays we're probably going to sit down and go through all the various quirks and
> specifics we know about to try and figure out what that should actually look like.

If you can provide some high level details on what to keep in library vs implementation after holidays, I would be
 happy to rework the patches.  Will look forward for further discussions on this.

-KR

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
