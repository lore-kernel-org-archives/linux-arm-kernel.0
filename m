Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49256C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:06:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1842081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GCfuNV7Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="I4mlEf/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1842081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LMvzzfx0muFwhruYzapI5AOO/xJQIMP+RQ8RinG1Syk=; b=GCfuNV7Y2ImFDj
	xqreRpwvyaVSEZM7kYx4kGwMIaiXk6Ua6O8+V0OOV8Ks4z31XDgaKB+1wM/44WervNQvCuCE062yI
	mnjXF/cy4ZlM1AEchmBbETh27jVD10A7Wmp9qgmIRZfFtWNqsGAc3VksFqzDoz7axXSrS8KqZOMmc
	2AbrGHuTTP4TWkE3rW+qAYaHXbnrn9NKsg52nHhRwwSksOtJUUxzlrzo8IRKDuBYDiQa6c8rIizcq
	0FzCGoRmFnSJfLmwjnZm0kaT16by/ChZvPjm6RB4rxjE3IXL5e6klbnhfqp1oT4C4iQZOA74RgGut
	ypEiHie8PecRRzAveRJQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9af-0007Rh-6c; Fri, 22 Feb 2019 12:06:05 +0000
Received: from mail-eopbgr710079.outbound.protection.outlook.com
 ([40.107.71.79] helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9ab-0007Qf-2p
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:06:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEW8kvMUVAbMzBU9HOX5ibJEpaPZvQRnu8p+ZkxvHq8=;
 b=I4mlEf/XwTO20zHEN5xTPEWl3vDE7OugYtJUcgmRwz4eIDiieivbDD8N5G/Tc1zm8prb+vWIW9Bq6vRFhPfOXpUd22AiGg2fOl+PvFtUpdJvkp7sNT3fGhD1Alo//JKkp5YGTPfRX61gcDAQCHhW5uUVogjLTeepr9BvOVoqhO8=
Received: from CY4PR02MB2709.namprd02.prod.outlook.com (10.175.80.9) by
 CY4PR02MB2455.namprd02.prod.outlook.com (10.173.42.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Fri, 22 Feb 2019 12:05:55 +0000
Received: from CY4PR02MB2709.namprd02.prod.outlook.com
 ([fe80::bc8d:c1a1:e7d9:2983]) by CY4PR02MB2709.namprd02.prod.outlook.com
 ([fe80::bc8d:c1a1:e7d9:2983%11]) with mapi id 15.20.1643.014; Fri, 22 Feb
 2019 12:05:55 +0000
From: Vishal Sagar <vsagar@xilinx.com>
To: Luca Ceresoli <luca@lucaceresoli.net>, Vishal Sagar
 <vishal.sagar@xilinx.com>, Hyun Kwon <hyunk@xilinx.com>,
 "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, Michal
 Simek <michals@xilinx.com>, "linux-media@vger.kernel.org"
 <linux-media@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "sakari.ailus@linux.intel.com"
 <sakari.ailus@linux.intel.com>, "hans.verkuil@cisco.com"
 <hans.verkuil@cisco.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Dinesh Kumar <dineshk@xilinx.com>, Sandip
 Kothari <sandipk@xilinx.com>
Subject: RE: [PATCH v3 2/2] media: v4l: xilinx: Add Xilinx MIPI CSI-2 Rx
 Subsystem
Thread-Topic: [PATCH v3 2/2] media: v4l: xilinx: Add Xilinx MIPI CSI-2 Rx
 Subsystem
Thread-Index: AQHUui2l5ecr9Ru5u0itGn9PqazmdqXaeJcAgAADeXCAADxWgIAQ8ezg
Date: Fri, 22 Feb 2019 12:05:55 +0000
Message-ID: <CY4PR02MB2709DC93D6F6F1BA181B9607A77F0@CY4PR02MB2709.namprd02.prod.outlook.com>
References: <1549025766-135037-1-git-send-email-vishal.sagar@xilinx.com>
 <1549025766-135037-3-git-send-email-vishal.sagar@xilinx.com>
 <3923069f-7c69-c601-0ded-f7629696ef9b@lucaceresoli.net>
 <CY4PR02MB2709000898D5E290B5EE99F4A7640@CY4PR02MB2709.namprd02.prod.outlook.com>
 <7fc3bd7b-4537-3df5-12ee-55ebec17a8bd@lucaceresoli.net>
In-Reply-To: <7fc3bd7b-4537-3df5-12ee-55ebec17a8bd@lucaceresoli.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsagar@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: facf0467-10d7-4389-f781-08d698be1964
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR02MB2455; 
x-ms-traffictypediagnostic: CY4PR02MB2455:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtDWTRQUjAyTUIyNDU1OzIzOjJ1YlBYdXl1YnlEU0VEbFpxUXp2YWVhcjJT?=
 =?utf-8?B?Ui9MSExhUjJHR3NEU1pUcDNPd2MwMGVrZU82cnlUdFVXZWpNd3h3THFjSksr?=
 =?utf-8?B?bDJEcmR5WW5YVnFkNFh5UmIyTTdxeTE2RTcxa2xYZ1hsY3FGVVlsT1NVV01l?=
 =?utf-8?B?UytNM0ZyZThkY05OL0JiMTA3bFlmZ1I1bUQrRjB2RjdQZmlpUVhweDREOEVF?=
 =?utf-8?B?TlFydm15M2h2dkFxbkJTN1ZvU0EwcTdyZDRHdUk0c29nbi9UT0hBTndIMEdt?=
 =?utf-8?B?RlNqNXFkOVRseUNXQ1J3S0JUOGlmYTF1SUJwR3U4Zk9wdEcvTlhZU0hjL3ZI?=
 =?utf-8?B?enh4d2RlSWxCVW9FWWgwWWxKbkxWVkJ6bit5T090c2pVckNMOXhQQnRTME5G?=
 =?utf-8?B?RFJXZjB1NE1RWWkrbVd5RzZ2dFVjUmdxNkFDOG1WM2kyZEdUYzd3dGJaQVgx?=
 =?utf-8?B?K2ZnTW5Rbi8rbHBpakx6T2FWUi9WZ1ByUEI0S1U3UVFrM2srVDlZa2luQmpH?=
 =?utf-8?B?RW5pdWhQdVlRcXdmMkIyRXhpTFlEaUlrU2NJY1dBd3loMWJxUFAyTnNzV1NO?=
 =?utf-8?B?eExaTnpDMGp3bFZMWkJJcUJ1dGovUU1RZ0R6ZEt1NFJrdFdEZmhjN3VlcWhV?=
 =?utf-8?B?K2VsVFhrbEZ3c3hmQ0xJNVprYnFDRXNlbXlOVFFlWFdTa3VaOEZzczJEVTlH?=
 =?utf-8?B?VDR6aksvcklzU3ZOWFNZcGoyUHBpV1QvVmsraVhmdCtEQ0kyYjZ6NVdmdWxX?=
 =?utf-8?B?T1kyWHZTZ1hYSldsR0RkOEFzbktVWjZOSUFoc2QreGc0VHlMbmwwQThlVXhZ?=
 =?utf-8?B?cFh3OWZQaE1qQy9UQWFtdHFjeXhNdStuVmlUQk5TbVVPTmIzTXJ3ZTZXSFBl?=
 =?utf-8?B?T1h5aWU3OGc2eERac2dtR2hIenA3QUhZdVpmNVlKenM3MXdxNGxhTGtDT3c2?=
 =?utf-8?B?dW1Bd0I3OWlHN2txbXdRNEJRcUN5b29aNmFoV1ViYnRjUjhJSDI3WFZyelBC?=
 =?utf-8?B?bWhrdlVtZkt2WlB6VGNUbUNvZGttVi9XeVdYQW1nczVJdXAxM2ljVUlab3p3?=
 =?utf-8?B?UEVJOEw1eWpLTEZRdFVmblR4d2F2Y1FTZWViTjZ1ZW9yWWlqbnpzTDRPVklx?=
 =?utf-8?B?cWRJSnFrMmwrNkFGcHl3RDkyQWR3SmlJeGhGSWdqMHVwWk50ZWtjTHdvZitq?=
 =?utf-8?B?VEZQZ2VRRlZiSGhLWHQ2RmcxbU4rQllTaGdOeENKa1BuZU9jUUVsSzdBc3U3?=
 =?utf-8?B?VUh1NVJPeTdac1Z6ZmNkUEx5ZmVoM3lQWUl0MHJrMjJrS21TRXRMTjI4S2xJ?=
 =?utf-8?B?TjJYc0ZQL1lNelFFNVFzR2F4SW5MRkNpUWlkdzA2R2cxdTJVbklPVnJoNE5v?=
 =?utf-8?B?cHhNR2hUQXZ0eStpY2VKaWY0VFFWNmtHSWVoanNkdWQrYVM3Qmd3T3FmbWlQ?=
 =?utf-8?B?NGkxa0FTNGU4bTBHSzNZck5RSE4vRFhVc3VYWldEd0h5T0dNR0FkaVR0QXUx?=
 =?utf-8?B?eGFsY1NkQ1Q4UDYzZ1dCOW9IcW9pT2IwVGs4R3V0R2htRXNUaDNEY3hwaXVQ?=
 =?utf-8?B?SXMwTkdDSFNsVlB4amI3YlZNSlMwcjg1RTNIQXlpeVVveXFZYkZ1VzU3NTUz?=
 =?utf-8?B?U09Xcml2aU85MEdJNHB1UHQ1ZnlPZUxMRldqMjlBTTB6LzBNZVA3b3NSbk9D?=
 =?utf-8?B?RWR2OHczSzVvcmx6SGJYaUVKclduZlpWSzF6dFdkYVQ1TkJwb0ZuRW5aVHpv?=
 =?utf-8?B?a0ViS2hNQzlHOU1Pb2VPRUxVQzNJYTdwMkt4NU1pY2tlb0xhWFljYmJLdTJX?=
 =?utf-8?B?cWxuUnY5aXVmcWdnRjdVL1pFNDlwYm5sdGxxOW1FR0RIU25KZzQvVlZRMk9i?=
 =?utf-8?Q?E32V//JF2G0=3D?=
x-microsoft-antispam-prvs: <CY4PR02MB2455B2DADEDF1F49592E4A96A77F0@CY4PR02MB2455.namprd02.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(366004)(136003)(376002)(39850400004)(13464003)(199004)(51914003)(189003)(9686003)(106356001)(55016002)(6636002)(71200400001)(66066001)(2501003)(3846002)(93886005)(6306002)(256004)(76176011)(53546011)(5660300002)(6116002)(186003)(102836004)(305945005)(25786009)(71190400001)(53936002)(105586002)(6436002)(8676002)(7736002)(74316002)(81156014)(81166006)(6506007)(7696005)(68736007)(8936002)(99286004)(86362001)(97736004)(14454004)(476003)(2906002)(229853002)(316002)(446003)(6246003)(11346002)(478600001)(486006)(33656002)(966005)(2201001)(26005)(110136005)(7416002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR02MB2455;
 H:CY4PR02MB2709.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p8u7zBwcZwupoTkqENKibL6nQeWEKMQ0YsITXo8Gr+QqN7gal81AE7wLohopnJN4JSzVqVAIFUz5Ffn3i71kMFVwGJJUPHKJfMrjclYDeCSvGKI4Q1hVk5VuECe/GENRJRmEWC62UyT/nHPrtUAKySdkaP8LijlpIrr0y1o2Ok5iXvVa4Y6lVCVcnRUyQS4VkT4+GvKhgnlesi6uq9v80z2GQhnuRJlLj5OQ1oJm/M19ihFUUKGLjHPnBKwGBaRLhtQzf/gosEIuS5v8dYB/zx3o7iuc8W8hR+a3W/lpZXkMAg6K6wzv6e0XiuMerxNv8o0clOSx9F1xsDsqaOuViIb9cltBEKfx1eaSmfvkuBOZIdYrSdYGM6C+FPj5AQGerNY6jGVym4dvKDBE11DtBoE9CYTfsoUvDWeu2lwsRYw=
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: facf0467-10d7-4389-f781-08d698be1964
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 12:05:55.4927 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2455
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_040601_181681_379FAAFE 
X-CRM114-Status: GOOD (  17.68  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Luca,

Apologies for the delayed response. 

> -----Original Message-----
> From: Luca Ceresoli [mailto:luca@lucaceresoli.net]
> Sent: Monday, February 11, 2019 8:01 PM
> To: Vishal Sagar <vsagar@xilinx.com>; Vishal Sagar <vishal.sagar@xilinx.com>;
> Hyun Kwon <hyunk@xilinx.com>; laurent.pinchart@ideasonboard.com;
> mchehab@kernel.org; robh+dt@kernel.org; mark.rutland@arm.com; Michal
> Simek <michals@xilinx.com>; linux-media@vger.kernel.org;
> devicetree@vger.kernel.org; sakari.ailus@linux.intel.com;
> hans.verkuil@cisco.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Dinesh Kumar <dineshk@xilinx.com>; Sandip Kothari
> <sandipk@xilinx.com>
> Subject: Re: [PATCH v3 2/2] media: v4l: xilinx: Add Xilinx MIPI CSI-2 Rx
> Subsystem
> 
> Hi,
> 
> thanks for the quick reply.
> 
> On 11/02/19 13:43, Vishal Sagar wrote:
> >>> +static int xcsi2rxss_start_stream(struct xcsi2rxss_state *state)
> >>> +{
> >>> +     struct xcsi2rxss_core *core = &state->core;
> >>> +     int ret = 0;
> >>> +
> >>> +     xcsi2rxss_enable(core);
> >>> +
> >>> +     ret = xcsi2rxss_reset(core);
> >>> +     if (ret < 0) {
> >>> +             state->streaming = false;
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     xcsi2rxss_intr_enable(core);
> >>> +     state->streaming = true;
> >>
> >> Shouldn't you propagate s_stream to the upstream subdev here calling
> >> v4l2_subdev_call(..., ..., s_stream, 1)?
> >>
> >
> > This is done by the xvip_pipeline_start_stop() in xilinx-dma.c for Xilinx Video
> pipeline.
> 
> Indeed it does, however other CSI2 RX drivers do propagate s_stream in
> their own s_stream. Not strictly related to this driver, but what's the
> logic for having these two different behaviors?
> 

I am not really sure about this. I agree with what you say but
in case the s_stream() is implemented here, then the sensor's s_stream() will be called twice.
I don't think this would be the correct behavior.

> Also xvip_pipeline_start_stop() only follows the graph through
> entity->pads[0], so it looks like it cannot handle entities with
> multiple sink pads. How would it be able to handle e.g. the AXI4-Stream
> Switch [0], which has 2+ sink pads?
> 

I agree with you about this. There should be a different mechanism for this. 

Regards
Vishal Sagar

> [0]
> https://www.xilinx.com/support/documentation/ip_documentation/axis_infra
> structure_ip_suite/v1_1/pg085-axi4stream-infrastructure.pdf
> (page 16).
> 
> --
> Luca
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
