Return-Path: <SRS0=E6Hv=PM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE037C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:05:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B7D421872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ckBQdEqZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Gd7WvbjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B7D421872
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+TYzWOdFc2b2FDNz+7jfYvY8VpIgeqoaO4j7MmprA+E=; b=ckBQdEqZ/cXMue
	JQo8yaLabeWCdcfojrm6HBwQ9nj3FqnG7KoDqcp0qmTieK7VgFiVAdSG74LAwoAaRnvT/D3ZioO9X
	FzLy3Yw5PXGbF/9N5Zhx2Tvwnub70gTUj1EXq2uvTB7ODhZTTRKOV1vjSfCq/K5WvKXfzQVqXaw6m
	d7yz7zXUPBxYL8UHu7wXO8kVTkr0uIW9OlDctL4ycjs/2+yOzOZ9ozES2RxmDrhk/GqS5sG9WIaA/
	Q9xQtetAUVjJhO6SQLDWtpHPZNH/293ymkXl+0SlzAO5GHiJZ8XPkby/+SevIknKwwDAHGwe13jds
	04+gfHk29vJwX47riCGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gfViZ-0007nC-5M; Fri, 04 Jan 2019 20:05:19 +0000
Received: from mail-co1nam04on071c.outbound.protection.outlook.com
 ([2a01:111:f400:fe4d::71c]
 helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfViV-0007mj-8g
 for linux-arm-kernel@lists.infradead.org; Fri, 04 Jan 2019 20:05:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov4QoRJ+5fC76+F5V68rtx0wk+4ImJZAeeG4nAilmb4=;
 b=Gd7WvbjL2snpJrE43vzB86LlRbkyiJO7o/OE1pUEJp5O0oErVa/iZPAzmeTUtrr6oz1wLarKtUe8Bsv+RdssBYeGZKD4v1hjOghTGbFr+mUAGw8lpDA8MoNAehmOWCgc4bS9rA5ntOl770N+YRPlKWnf7sgMDGlH27kIRAzaPtA=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0165.namprd21.prod.outlook.com (10.173.192.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.1; Fri, 4 Jan 2019 20:05:10 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::704f:14f3:5d34:cf6]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::704f:14f3:5d34:cf6%3]) with mapi id 15.20.1516.000; Fri, 4 Jan 2019
 20:05:10 +0000
From: Michael Kelley <mikelley@microsoft.com>
To: Marc Zyngier <marc.zyngier@arm.com>, KY Srinivasan <kys@microsoft.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>, "catalin.marinas@armm.com"
 <catalin.marinas@armm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org"
 <devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>,
 "apw@canonical.com" <apw@canonical.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, Stephen Hemminger <sthemmin@microsoft.com>, vkuznets
 <vkuznets@redhat.com>
Subject: RE: [PATCH 2/4] arm64: hyperv: Add support for Hyper-V as a hypervisor
Thread-Topic: [PATCH 2/4] arm64: hyperv: Add support for Hyper-V as a
 hypervisor
Thread-Index: AQHUghEnmAHBKrXmHkmtduFUzC9VJqVzciwAgAb8qWCAAjmMgIAX6uiA
Date: Fri, 4 Jan 2019 20:05:10 +0000
Message-ID: <CY4PR21MB077301ECE13325F8C75EE941D78E0@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
 <20181122031059.16338-2-kys@linuxonhyperv.com>
 <39e47e32-2738-e39a-4ddb-9d27d2513beb@arm.com>
 <CY4PR21MB0773002BFD385052A830A979D7A70@CY4PR21MB0773.namprd21.prod.outlook.com>
 <e0374a07-809c-cabd-2eb6-e6b5ad84742e@arm.com>
In-Reply-To: <e0374a07-809c-cabd-2eb6-e6b5ad84742e@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-01-04T20:05:07.5544968Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2605:e000:ccc4:8800:dcbf:42e7:5afa:6bf3]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR21MB0165;
 6:8IjsLOousmngWUs1TS0UulcIeu0fYTqCfPllx6G1OPURLHoOxkDUmUHSxpHCp2DaojkQ5zg/sAzx8gUKGl+HbwZ8n/0kM8jg0q/Nl4ATVl8gmBtbQIjSX7POduLwbNPBRzoZdJDhUs84m4/pNlEMjezxHmURfvBZMspfLgNtlkaU64KIHL97/I8SSHtSqqVS6//Sr+0WnIDLSJA1cxe8AOQILqu0F91vdTfS0IIc0uW00T8fPPakWfQSmNx2q701syHE0JAsJ/vwinpdOEmdYugKjYi5nwtc6HlcHtr1SVPqKghYa2V0O1tkImDiRNk0tM5IHi8jgGlzG7ACFUeJ9Fm0AIq29wfIh0thoSm1Vw1tL2zpAltMgZsLaflbkKwF/MSov9i3tMnIoERm8Voxvi9z3gl3GtEMDuLmzngIjP7Y4ioFLs/88xHhFyFJhSaRdPsTAKHRL3hsbrOHOwpfrA==;
 5:hLxAL2FkWQFpLz0BoWgInyXo2RM9DT+xhfyS1OTIxNOfROnUMm+MbRQzD2mJQd6tVKLNn0AyCbHwvj8AsmjkiR/Ef+Apj/d55E9BVsp0mFBkUhns4OMZcMLLzYCNN6fJpMIroVdaOt5wbW8Ffm1mNJfZ6tIIUnpCQURCoUxbUEpGwSKLlWZwDQ3ARAoonv1PFayyg/v1IwAFrAnfYFFNbw==;
 7:stvFVhqyjb1j1YJjScvcFcrY+MFmWXIeS93lMGCWQHlEj4sz4NQgInPKgJ57LiDa/qnENeuS4qmWwDcMLlI8KIBms05hNUECMmqWsfv9yRLlrA8JYWXH38s/Z2o4SmhWV/71CdCWszNSmchQW/6Ahw==
x-ms-office365-filtering-correlation-id: 40cdba9f-ed53-4b86-7bdc-08d6727fee8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);
 SRVR:CY4PR21MB0165; 
x-ms-traffictypediagnostic: CY4PR21MB0165:
x-ms-exchange-purlcount: -3
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <CY4PR21MB016506CCC02E9F75FD5212B8D78E0@CY4PR21MB0165.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(2018427008)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);
 SRVR:CY4PR21MB0165; BCL:0; PCL:0; RULEID:; SRVR:CY4PR21MB0165; 
x-forefront-prvs: 0907F58A24
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(346002)(366004)(136003)(376002)(396003)(199004)(189003)(186003)(486006)(53936002)(97736004)(68736007)(22452003)(76176011)(2201001)(74316002)(25786009)(7416002)(86362001)(305945005)(7736002)(5660300001)(86612001)(81166006)(8676002)(81156014)(256004)(8936002)(478600001)(9686003)(7696005)(71190400001)(8990500004)(71200400001)(10090500001)(55016002)(2906002)(99286004)(1511001)(93886005)(6116002)(229853002)(110136005)(46003)(6346003)(316002)(105586002)(10290500003)(33656002)(106356001)(6436002)(2501003)(102836004)(446003)(14454004)(6246003)(476003)(6506007)(11346002)(921003)(1121003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR21MB0165;
 H:CY4PR21MB0773.namprd21.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tpoew6110lno1p09bRQ4LaJCI2e9xNhr1iixlhdRSbkKOi0bim/6qd8wA7ZUUKj8ViMIU0TcgZEiNy3ux1GX2NYI9YJQs9cqF+OiX1+6zH9aWJWaMamheD3CuQnJCDdqXCRBlKytmmBXDoBUjIjZmxfio90ZCD/ha/Qa1BgEN690BVHt2E0GPxWTJHKfeiFOiTO8hF9EbqrVA74iay3+3htQRFGfmFoHXpwtHymCF6uWK5uxNitGYmush4E1fVKuqJarETaAlZ9fPHKbNZhvKkjlAzQd6TWYMIrkARQJNUqGu+e4ULl0nS/mZQy6WSiX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cdba9f-ed53-4b86-7bdc-08d6727fee8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2019 20:05:10.5889 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0165
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190104_120515_382142_1B7B3CD5 
X-CRM114-Status: GOOD (  24.30  )
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

From: Marc Zyngier <marc.zyngier@arm.com> Sent: Thursday, December 13, 2018 3:23 AM

> >> As Will said, this isn't a viable option. Please follow SMCCC 1.1.
> >
> > I'll have to start a conversation with the Hyper-V team about this.
> > I don't know why they chose to use HVC #1 or this register scheme
> > for output values.  It may be tough to change at this point because
> > there are Windows guests on Hyper-V for ARM64 that are already
> > using this approach.
> 
> I appreciate you already have stuff in the wild, but there is definitely
> a case to be made for supporting architecturally specified mechanisms in
> a hypervisor, and SMCCC is definitely part of it (I'm certainly curious
> of how you support the Spectre mitigation otherwise).
>

The Hyper-V guys I need to discuss this with are not back from the
holidays until January 7th.  I'll follow up on this thread once I've
had that conversation.

> >>> +static int hv_cpu_init(unsigned int cpu)
> >>> +{
> >>> +	u64 msr_vp_index;
> >>> +
> >>> +	hv_get_vp_index(msr_vp_index);
> >>> +
> >>> +	hv_vp_index[smp_processor_id()] = msr_vp_index;
> >>> +
> >>> +	if (msr_vp_index > hv_max_vp_index)
> >>> +		hv_max_vp_index = msr_vp_index;
> >>> +
> >>> +	return 0;
> >>> +}
> >>
> >> Is that some new way to describe a CPU topology? If so, why isn't that
> >> exposed via the ACPI tables that the kernel already parses?
> >
> > Hyper-V's hypercall interface uses vCPU identifiers that are not
> > guaranteed to be consecutive integers or to match what ACPI shows.
> > No topology information is implied -- it's just unique identifiers.  The
> > hv_vp_index array provides easy mapping from Linux's consecutive
> > integer IDs for CPUs when needed to construct hypercall arguments.
> 
> That's extremely odd. The hypervisor obviously knows which vCPU is doing
> a hypercall, and if referencing another vCPU, the virtualized MPIDR_EL1
> value should be used. I don't think deviating from the architecture is a
> good idea (but I appreciate this is none of your doing). Following the
> architecture would allow this code to directly use the cpu_logical_map
> infrastructure we already have.

I see what you are getting at.  However, some Hyper-V hypercalls allow
specifying arbitrary sets of vCPUs.  These hypercalls are used to define
target processors in the virtual PCI code (which I have not yet brought over
to ARM64) and in enlightenments for IPIs and TLB flushes (used by
Windows guests and Linux guests on x86, but not yet brought over to Linux
ARM64, if they ever will be).  These hypercalls take bitmaps as arguments,
similar to a Linux cpumask, as defined in Sections 7.8.7.3 thru 7.8.7.5 in the
Hyper-V TLFS.  So Hyper-V defines its own VP index that is akin to the index 
into the cpu_logical_map, though it may not be the same mapping.  My earlier
comments may have been misleading -- the Hyper-V VP index is an integer
ranging from 0 thru (# vCPUs - 1).

With these requirements, Hyper-V defining its own VP index seems like
a reasonable thing to do.  And since Hyper-V provides the same hypercall
interfaces for both x86 and ARM64 implementations, and for Windows
guests, there's not much choice but to use the Hyper-V VP index as specified.

Michael


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
