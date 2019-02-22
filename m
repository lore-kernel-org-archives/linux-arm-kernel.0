Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BA0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:06:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616A820823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ryxsf1q5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sEmGkwuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616A820823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YwwmU8kSKduqew4ISGuPC9dAVKugJjF9SUxcKFO/DEc=; b=ryxsf1q5ggIJFB
	7qTPHpXPQF4akhJBf64vnu2uUBgMlfF6Heo8rgJLaI+qeSe8DvCKgA7lCUcSm86zkEjtb7zXtfV+W
	wgEhEQ7Yz1JPvLzcGcxXhPkMUT+t5xMZ6xx42y0hnl6tbQDlyHEqwI9IIFK3PvRLqV07YXjg/KP0l
	VfGcA6TmuXCGpLirAtD68kXbtuuQG3DYBos0KCe5Bg/CM+1NYjmhjNqitSxn45w54bU2KsnIfrF5a
	RjYL4QTugNpx8cC5885EKiSGuRYSpL6ingJs2ofark35BANH/2wXeo5EOu9hlNT/lVRua9mKQWCYT
	tMxMMkjrOyKHQbDowqzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9b3-0007i6-EA; Fri, 22 Feb 2019 12:06:29 +0000
Received: from mail-bn3nam01on060a.outbound.protection.outlook.com
 ([2a01:111:f400:fe41::60a]
 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9ag-0007Rg-LB
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:06:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv0RfrJRdXRVzR/Vwd3e6ti2Wj2/h/q1p+UbTXTrWcA=;
 b=sEmGkwuC0gQgpT/JszZ7r4anYL6QhSyVpmJsMfUZ7F+BXyTMqxmvGXFHLE5nxFdKYMaZljE4AzBaM78TtyJWroqmcOPip3X9GjgPlmlzY3q2ugN1X1ohaApzH79yYHAKg10MFzTD416j9FoR6W4mfuMvl7xdRk3xDW/tAjin2E0=
Received: from CY4PR02MB2709.namprd02.prod.outlook.com (10.175.80.9) by
 CY4PR02MB3144.namprd02.prod.outlook.com (10.165.88.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 22 Feb 2019 12:06:01 +0000
Received: from CY4PR02MB2709.namprd02.prod.outlook.com
 ([fe80::bc8d:c1a1:e7d9:2983]) by CY4PR02MB2709.namprd02.prod.outlook.com
 ([fe80::bc8d:c1a1:e7d9:2983%11]) with mapi id 15.20.1643.014; Fri, 22 Feb
 2019 12:06:01 +0000
From: Vishal Sagar <vsagar@xilinx.com>
To: Hyun Kwon <hyunk@xilinx.com>, Vishal Sagar <vishal.sagar@xilinx.com>
Subject: RE: [v3,2/2] media: v4l: xilinx: Add Xilinx MIPI CSI-2 Rx Subsystem
Thread-Topic: [v3,2/2] media: v4l: xilinx: Add Xilinx MIPI CSI-2 Rx Subsystem
Thread-Index: AQHUw9ThzhMGYnNitEGLUAxHlZdt+6Xrsvyw
Date: Fri, 22 Feb 2019 12:06:01 +0000
Message-ID: <CY4PR02MB27091FBBCEA4FBB0C3A760E4A77F0@CY4PR02MB2709.namprd02.prod.outlook.com>
References: <1549025766-135037-3-git-send-email-vishal.sagar@xilinx.com>
 <20190213194539.GA11819@smtp.xilinx.com>
In-Reply-To: <20190213194539.GA11819@smtp.xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsagar@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddab881a-6f61-416f-3ad4-08d698be1ce7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR02MB3144; 
x-ms-traffictypediagnostic: CY4PR02MB3144:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtDWTRQUjAyTUIzMTQ0OzIzOkRSclhOTXphNzRKTm5mZHZyVEw3YmlpcGIv?=
 =?utf-8?B?NlUzVDNtYWt6QUFrWUVsaTB0UkdRRS9CMHEycW04aDlhVmFYZ21EOElhb0FL?=
 =?utf-8?B?MjMrcm95TjZSV2pqTVNQajh6S3FpVUJpOXNzREIxQ3lXd1BNVjZweTJrY1Ry?=
 =?utf-8?B?aFpxb3pTc2hLR2hueURKMW9tRWxSS21QdVd6WEZhRk1zRkJ2OXVkbUNkSDFa?=
 =?utf-8?B?Q2JqSlJBbERxeWxpa2dJL2IweEZ4c3JYTjBFSmMvUGt5RHE1eWord3hCNzJx?=
 =?utf-8?B?YzR0Zyt0UFdiUDJPQzJ5RmloU1hUWkZoRkNCYXhJVyt1NUdFY2tvaTQ1cmUr?=
 =?utf-8?B?Si9uSEFYaUQxZnR2Q29na2FDUmRXdW1vQVcrOUVMZGI2MVQrL0xpekQxd3J0?=
 =?utf-8?B?dTEvK0hhV2MrQ295UG1Xd1dSWGNLeU5BVDJ5S29nYWFuWXdZZUNpY3pjc1Jx?=
 =?utf-8?B?UUI4dFRPRXBibzJqTWFhbUJXck1hOXh5Q3U4TXVsUVhqN3RLN0lkUjZiRTRT?=
 =?utf-8?B?WTRCNjJHYm01V09vWmRFQ25ac2JPaDJMQWE5YUtjNnNKckdzWGFpN2FJYlhK?=
 =?utf-8?B?ZHhMV3F3YmRONFdGVmVXcTlxYVZMeitTL0hpZDc2cnZ1OXdMNzcxZjRoVzU3?=
 =?utf-8?B?Lzl3QnZ1RlhlSUErVVBnclh6Vi8xSG9lQVo4a0p3bGZST29CNUZjUkN0MGd5?=
 =?utf-8?B?K0hGTUtObC9pakFkVXoxQmZockNseWtFb2FWUnREQ2ZLTmIrZXNqYXhONUx5?=
 =?utf-8?B?RHRZL1B5RVQwblN6VDlHWnVvK2ZDVDZYN3E0aEFLQW1iS1RZakJMRHB1MjhL?=
 =?utf-8?B?akVUTXZ0TWpQMjBnbnAvd0REbzdnb0RseEsxZnVOOXV2WlEwVU5XYWNxcVQ0?=
 =?utf-8?B?RFpQOCtEWVo5QkJtSUdTcFVIZVM2UjRwL2EvQlBXU3FxaUtTMGJab3pmS2dL?=
 =?utf-8?B?Vi9ma3VENDV4MGgrQnY3M0RIUzMyZEhNMDJ6ZEliS1ZWWG1ETWxaeDhKS0d2?=
 =?utf-8?B?bmZTTzVuY0RoeExzTi9FbzVhYXEySHZ1TmlrMUVNSklucE9mckQxemVHY2lM?=
 =?utf-8?B?TngrMjNxcHZ6d2lNbUVzM3F0Z1QyRWl2K2oyMVlNUi9MQVM3WVZnMGhyeUR1?=
 =?utf-8?B?Vkdsb0VEK3dsdDVxUGY0R1g5V2JHUStXVmREemJBT3JKQXAwenRSSm91Q3lB?=
 =?utf-8?B?RUtYcDQvV3B6MXRXMGJTVzlLb0hUR1UrdERkTEpRN21Ea2xKemJvQ2ExOW5S?=
 =?utf-8?B?S1FZVjR5ZjA4cGZQbVRYT3FvWHFTS3hiclF1VEJBbGd0ZmFOVXdjeEtDdFAw?=
 =?utf-8?B?dDVBcU9XaGV0MVhWSENZNEhFM08zelhOSFdFU1Nkc1l4dkZ1NTJBWDc1S21l?=
 =?utf-8?B?RGFWN29kYjRkZHFDOC9xR1FCN2xrNFZDSHlEY3dNVTZvUFNOOHdFWmF2My92?=
 =?utf-8?B?d01FRmhhUk1ZaWRvZnBvK2gzc3NBSDgzSlFqY2F0VkQ3MmlEOHd4ZVFlZm80?=
 =?utf-8?B?TFBXMENPQjh5dDlDMXZWRERYSThVcllsRUprYmNXaWRCWWZjbFFzNkxEVExk?=
 =?utf-8?B?WDhhb0VqOEY5KzhRMDFzRTJMUEVSZzVUeVVMZkU0elJtZ0Zic0JobEZPUUhT?=
 =?utf-8?B?RU5Ra2hVMXRQMktpeGprNUgrRUZ0WnRWblNTQ2hSeUpjYnFHbnVOa0k5Z3k3?=
 =?utf-8?B?cHVpVDJKTU0wQnFiMU81bWJTMFFGOUdqZXZsOUt2UVZOMERVVEsvdjB0QkJH?=
 =?utf-8?B?RkpUOExHVHZTT3BxU3dXTkRGdDg5cUtLcVd2ekdvTTZBNS9ZM2pwaEZTcGFl?=
 =?utf-8?B?OUkvL2gvMGcvKzcyeVNxbS9XVVRoNy9hQkk0ZVpNVjhwUDZJT1d5Z0Q4V01u?=
 =?utf-8?B?WVNNbmFDdkhDKzluV3hpY2xxcW5xSk5xTXpXcE1kNGZqQ280KzdnS2hhYkFR?=
 =?utf-8?B?Rm9STEZFSFAzSFI4eFRWZXNXemZjNkNYb3NRSkNvNlo3U1I1WFAxWGFYNHA5?=
 =?utf-8?B?blk2N1EvSkQ3dUhBdG1YVHF5djZBaXhmRUtnUT09?=
x-microsoft-antispam-prvs: <CY4PR02MB3144F2E5B9E37EA76E0D03F7A77F0@CY4PR02MB3144.namprd02.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(366004)(376002)(39860400002)(396003)(346002)(136003)(199004)(189003)(51914003)(45074003)(13464003)(9686003)(55016002)(26005)(6436002)(81166006)(8936002)(33656002)(99286004)(25786009)(4326008)(229853002)(8676002)(6636002)(486006)(476003)(97736004)(81156014)(186003)(11346002)(478600001)(7416002)(446003)(14454004)(107886003)(6246003)(105586002)(53936002)(54906003)(53546011)(3846002)(6506007)(106356001)(102836004)(316002)(86362001)(7736002)(7696005)(256004)(71190400001)(14444005)(2906002)(305945005)(74316002)(66066001)(71200400001)(6116002)(5660300002)(76176011)(30864003)(68736007)(110136005)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR02MB3144;
 H:CY4PR02MB2709.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HkIZu3HwgwggrD6L3K5yKsJ84HVxHBOkDiN65F7LFLsztWncYPzOiGebR0VVzxaaKhs3EVrWKZXCrL8PTkft4ZeqbEtJcWM6asMRebGvTW8P4qQtXbSXz6ArUBap2UwO5SYJ00De/c5Y2ribdUFsHneeRZdPIQE14z+QPGjYMqJwZ2xCbzT8YQmsXC1tPUqDROmNi2dgZAyM0ojm0QJQ5UJZ09pXiWEYh1T/lzZojE1GUHnuFZFAYxUXk/37TTe8hy+o8ukU8xtoSR3/WPXb+C+8VsCE2stPcvn36pKoB/aK9CPPDzmmamZfYrqSYKoRbrzXsuFL5XYIqESErly5R+Ir/yMiRJpuAHGS9TXCtbU9is2cKmys3mWSWnJ/8oNk26kHPKBcfLdv453+HgpjOkZgGozyF1NK+bm2i4PjiQY=
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddab881a-6f61-416f-3ad4-08d698be1ce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 12:06:01.3556 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_040607_131726_BB4BEF0E 
X-CRM114-Status: GOOD (  25.14  )
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Dinesh Kumar <dineshk@xilinx.com>, Sandip Kothari <sandipk@xilinx.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Michal Simek <michals@xilinx.com>,
 "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
 "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>,
 "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Hyun,

Thanks for reviewing. Apologies for the delayed response.

> -----Original Message-----
> From: Hyun Kwon [mailto:hyun.kwon@xilinx.com]
> Sent: Thursday, February 14, 2019 1:16 AM
> To: Vishal Sagar <vishal.sagar@xilinx.com>
> Cc: laurent.pinchart@ideasonboard.com; mchehab@kernel.org;
> robh+dt@kernel.org; mark.rutland@arm.com; Michal Simek
> <michals@xilinx.com>; linux-media@vger.kernel.org;
> devicetree@vger.kernel.org; sakari.ailus@linux.intel.com;
> hans.verkuil@cisco.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Dinesh Kumar <dineshk@xilinx.com>; Sandip Kothari
> <sandipk@xilinx.com>
> Subject: Re: [v3,2/2] media: v4l: xilinx: Add Xilinx MIPI CSI-2 Rx Subsystem
> 
> Hi Vishal,
> 
> Thanks for the patch. Sorry for the delay.
> 
> On Fri, 2019-02-01 at 18:26:06 +0530, Vishal Sagar wrote:
> > The Xilinx MIPI CSI-2 Rx Subsystem soft IP is used to capture images
> > from MIPI CSI-2 camera sensors and output AXI4-Stream video data ready
> > for image processing. Please refer to PG232 for details.
> >
> > The driver is used to set the number of active lanes, if enabled
> > in hardware. The CSI2 Rx controller filters out all packets except for
> > the packets with data type fixed in hardware. RAW8 packets are always
> > allowed to pass through.
> >
> > It is also used to setup and handle interrupts and enable the core. It
> > logs all the events in respective counters between streaming on and off.
> > The generic short packets received are notified to application via
> > v4l2_events.
> >
> > The driver supports only the video format bridge enabled configuration.
> > Some data types like YUV 422 10bpc, RAW16, RAW20 are supported when
> the
> > CSI v2.0 feature is enabled in design. When the VCX feature is enabled,
> > the maximum number of virtual channels becomes 16 from 4.
> >
> > Signed-off-by: Vishal Sagar <vishal.sagar@xilinx.com>
> > ---
> > v3
> > - Fixed comments given by Hyun.
> > - Removed DPHY 200 MHz clock. This will be controlled by DPHY driver
> > - Minor code formatting
> > - en_csi_v20 and vfb members removed from struct and made local to dt
> parsing
> 
> [snip]
> 
> > +};
> > +
> > +/*
> > + * struct xcsi2rxss_core - Core configuration CSI2 Rx Subsystem device
> structure
> > + * @dev: Platform structure
> > + * @iomem: Base address of subsystem
> > + * @irq: requested irq number
> > + * @enable_active_lanes: If number of active lanes can be modified
> > + * @max_num_lanes: Maximum number of lanes present
> > + * @datatype: Data type filter
> > + * @bayer: bayer pattern
> > + * @events: Structure to maintain event logs
> > + * @vcx_events: Structure to maintain VCX event logs
> > + * @en_vcx: If more than 4 VC are enabled
> > + * @lite_aclk: AXI4-Lite interface clock
> > + * @video_aclk: Video clock
> > + */
> > +struct xcsi2rxss_core {
> > +	struct device *dev;
> > +	void __iomem *iomem;
> > +	int irq;
> 
> This doesn't have to be stored.

Agree. I will remove it in next version.

> 
> > +	bool enable_active_lanes;
> > +	u32 max_num_lanes;
> > +	u32 datatype;
> > +	u32 bayer;
> > +	struct xcsi2rxss_event *events;
> > +	struct xcsi2rxss_event *vcx_events;
> > +	bool en_vcx;
> > +	struct clk *lite_aclk;
> > +	struct clk *video_aclk;
> > +};
> > +
> > +/**
> > + * struct xcsi2rxss_state - CSI2 Rx Subsystem device structure
> > + * @core: Core structure for MIPI CSI2 Rx Subsystem
> > + * @subdev: The v4l2 subdev structure
> 
> [snip]
> 
> > +
> > +/* Print event counters */
> > +static void xcsi2rxss_log_counters(struct xcsi2rxss_state *state)
> > +{
> > +	struct xcsi2rxss_core *core = &state->core;
> > +	int i;
> > +
> > +	for (i = 0; i < XCSI_NUM_EVENTS; i++) {
> > +		if (core->events[i].counter > 0)
> 
> Does checkpatch warn if putting {} here, and
> 
> > +			dev_info(core->dev, "%s events: %d\n",
> > +				 core->events[i].name,
> > +				 core->events[i].counter);
> > +	}
> > +
> > +	if (core->en_vcx)
> 
> here, and
> 
> > +		for (i = 0; i < XCSI_VCX_NUM_EVENTS; i++) {
> > +			if (core->vcx_events[i].counter > 0)
> 
> here? But up to you.

No checkpatch doesn't give warning. 

> 
> > +				dev_info(core->dev,
> > +					 "VC %d Frame %s err vcx events: %d\n",
> > +					 (i / 2) + XCSI_VCX_START,
> > +					 i & 1 ? "Sync" : "Level",
> > +					 core->vcx_events[i].counter);
> > +		}
> > +}
> > +
> > +/**
> > + * xcsi2rxss_log_status - Logs the status of the CSI-2 Receiver
> > + * @sd: Pointer to V4L2 subdevice structure
> > + *
> > + * This function prints the current status of Xilinx MIPI CSI-2
> 
> [snip]
> 
> > +
> > +/**
> > + * xcsi2rxss_s_ctrl - This is used to set the Xilinx MIPI CSI-2 V4L2 controls
> > + * @ctrl: V4L2 control to be set
> > + *
> > + * This function is used to set the V4L2 controls for the Xilinx MIPI
> > + * CSI-2 Rx Subsystem. It is used to set the active lanes in the system.
> > + * The event counters can be reset.
> > + *
> > + * Return: 0 on success, errors otherwise
> > + */
> > +static int xcsi2rxss_s_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> > +	struct xcsi2rxss_state *xcsi2rxss =
> > +		container_of(ctrl->handler, struct xcsi2rxss_state,
> > +			     ctrl_handler);
> > +	struct xcsi2rxss_core *core = &xcsi2rxss->core;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&xcsi2rxss->lock);
> > +
> > +	switch (ctrl->id) {
> > +	case V4L2_CID_XILINX_MIPICSISS_ACT_LANES:
> > +		/*
> > +		 * This will be called only when "Enable Active Lanes" parameter
> > +		 * is set in design
> > +		 */
> > +		if (core->enable_active_lanes) {
> > +			u32 active_lanes;
> > +
> > +			xcsi2rxss_clr_and_set(core, XCSI_PCR_OFFSET,
> > +					      XCSI_PCR_ACTLANES_MASK,
> > +					      ctrl->val - 1);
> > +			/*
> > +			 * This delay is to allow the value to reflect as write
> > +			 * and read paths are different.
> > +			 */
> > +			udelay(1);
> > +			active_lanes = xcsi2rxss_read(core, XCSI_PCR_OFFSET);
> > +			active_lanes &= XCSI_PCR_ACTLANES_MASK;
> > +			active_lanes++;
> > +			if (active_lanes != ctrl->val)
> > +				dev_info(core->dev, "RxByteClkHS absent\n");
> > +			dev_dbg(core->dev, "active lanes = %d\n", ctrl->val);
> > +		} else {
> > +			ret = -EINVAL;
> > +		}
> > +		break;
> > +	case V4L2_CID_XILINX_MIPICSISS_RESET_COUNTERS:
> > +		xcsi2rxss_reset_event_counters(xcsi2rxss);
> > +		break;
> > +	default:
> 
> -EINVAL?

Agree. I will add it in next version.

> 
> > +		break;
> > +	}
> > +
> > +	mutex_unlock(&xcsi2rxss->lock);
> > +
> > +	return ret;
> > +}
> > +
> 
> [snip]
> 
> > +
> > +static void xcsi2rxss_clk_disable(struct xcsi2rxss_core *core)
> > +{
> > +	clk_disable_unprepare(core->video_aclk);
> > +	clk_disable_unprepare(core->lite_aclk);
> > +}
> > +
> > +static int xcsi2rxss_parse_of(struct xcsi2rxss_state *xcsi2rxss)
> > +{
> > +	struct xcsi2rxss_core *core = &xcsi2rxss->core;
> > +	struct device_node *node = xcsi2rxss->core.dev->of_node;
> > +	struct device_node *ports = NULL;
> > +	struct device_node *port = NULL;
> > +	unsigned int nports;
> > +	bool en_csi_v20, vfb;
> > +	int ret;
> > +
> > +	en_csi_v20 = of_property_read_bool(node, "xlnx,en-csi-v2-0");
> > +	if (en_csi_v20) {
> > +		core->en_vcx = of_property_read_bool(node, "xlnx,en-vcx");
> > +		dev_dbg(core->dev, "vcx %s", core->en_vcx ? "enabled" :
> > +			"disabled");
> > +	}
> > +
> > +	dev_dbg(core->dev, "en_csi_v20 %s", en_csi_v20 ? "enabled" :
> > +		"disabled");
> 
> Would it be better to have these options visible with log?
> It can be printed as a part of final banner in probe. Up to you.
> 

Ok. Will put it under a new function xcsi2rxss_log_ipconfig()

> > +
> > +	core->enable_active_lanes =
> > +		of_property_read_bool(node, "xlnx,en-active-lanes");
> > +	dev_dbg(core->dev, "Enable active lanes property = %s\n",
> > +		core->enable_active_lanes ? "Present" : "Absent");
> > +
> > +	ret = of_property_read_u32(node, "xlnx,csi-pxl-format",
> > +				   &core->datatype);
> > +	if (ret < 0) {
> > +		dev_err(core->dev, "missing xlnx,csi-pxl-format property\n");
> > +		return ret;
> > +	}
> > +
> > +	switch (core->datatype) {
> > +	case XCSI_DT_YUV4228B:
> > +	case XCSI_DT_RGB444:
> > +	case XCSI_DT_RGB555:
> > +	case XCSI_DT_RGB565:
> > +	case XCSI_DT_RGB666:
> > +	case XCSI_DT_RGB888:
> > +	case XCSI_DT_RAW6:
> > +	case XCSI_DT_RAW7:
> > +	case XCSI_DT_RAW8:
> > +	case XCSI_DT_RAW10:
> > +	case XCSI_DT_RAW12:
> > +	case XCSI_DT_RAW14:
> > +		break;
> > +	case XCSI_DT_YUV42210B:
> > +	case XCSI_DT_RAW16:
> > +	case XCSI_DT_RAW20:
> > +		if (!en_csi_v20) {
> > +			ret = -EINVAL;
> > +			dev_dbg(core->dev, "enable csi v2 for this pixel
> format");
> > +		}
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	if (ret < 0) {
> > +		dev_err(core->dev, "invalid csi-pxl-format property!\n");
> > +		return ret;
> > +	}
> > +
> > +	dev_dbg(core->dev, "pixel format set as 0x%x\n", core->datatype);
> > +
> > +	vfb = of_property_read_bool(node, "xlnx,vfb");
> > +	dev_dbg(core->dev, "Video Format Bridge property = %s\n",
> > +		vfb ? "Present" : "Absent");
> 
> I'd collect all these print in one print or one location. But up to you.

Ok. Will put it under a new function xcsi2rxss_log_ipconfig()

> 
> > +
> > +	if (!vfb) {
> > +		dev_err(core->dev, "failed as VFB is disabled!\n");
> > +		return -EINVAL;
> > +	}
> 
> [snip]
> 
> > +	/* Register interrupt handler */
> > +	core->irq = irq_of_parse_and_map(node, 0);
> > +	ret = devm_request_irq(core->dev, core->irq, xcsi2rxss_irq_handler,
> > +			       IRQF_SHARED, "xilinx-csi2rxss", xcsi2rxss);
> > +	if (ret) {
> > +		dev_err(core->dev, "Err = %d Interrupt handler reg failed!\n",
> > +			ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int xcsi2rxss_probe(struct platform_device *pdev)
> > +{
> > +	struct v4l2_subdev *subdev;
> > +	struct xcsi2rxss_state *xcsi2rxss;
> > +	struct xcsi2rxss_core *core;
> > +	struct resource *res;
> > +	int ret, num_ctrls, i;
> > +
> > +	xcsi2rxss = devm_kzalloc(&pdev->dev, sizeof(*xcsi2rxss), GFP_KERNEL);
> > +	if (!xcsi2rxss)
> > +		return -ENOMEM;
> > +
> > +	core = &xcsi2rxss->core;
> > +	core->dev = &pdev->dev;
> > +
> > +	mutex_init(&xcsi2rxss->lock);
> > +
> > +	ret = xcsi2rxss_parse_of(xcsi2rxss);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	core->iomem = devm_ioremap_resource(core->dev, res);
> > +	if (IS_ERR(core->iomem))
> > +		return PTR_ERR(core->iomem);
> > +
> > +	ret = xcsi2rxss_clk_get(core);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = xcsi2rxss_clk_enable(core);
> > +	if (ret < 0)
> > +		return ret;
> 
> Not sure if I mentioned, please consider having these with
> stream on / off later.

We don't have a mechanism to reset the video path through software if it is connected to a Processor System Reset.
So for now I will keep it here.

> 
> I only have minor comments, and it looks fine to me. Please take a look at
> those comments, then
> 
> 	Reviewed-by: Hyun Kwon <hyun.kwon@xilinx.com>
> 
> Thanks,
> -hyun

Thanks,
Vishal

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
