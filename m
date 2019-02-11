Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CCAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:43:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E6F218A6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PKU5Y0ux";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tWqeMaYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E6F218A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DsYZ7ziFsyrYQbKUoe8ITb8os1v/hi+OregeDZAftNo=; b=PKU5Y0uxe/3Fu3
	IjLtcKWyLbNuJoYGPfjGWmX9rTTX4k3+KtfpEE2gJwqmbDowlB/6btdnDacZyPp0qM1ypDhbnx7/u
	u53hVtuOpvE1nksNeFrFxjOW0k6yI/hwJYlYOvx5vKYEa9WoWKYpwE6bhSHCD6kRXyUkyNUIoDvU8
	TaYZgx0Pj1iApiBKC3BlmHUuYJmwwaNP5bLL0aUT+YTbg3FCX3qJeU1f8PSZe0bTIzFOFHfR6+dKz
	fRj+VOQepIyaBQuxu5PmrRNLuUHoiKO3KmnBNOXCpzRIcZSoQj239zRFjMu6wSDA3tJMxwN21rrn3
	nEKLJ5jHv8el6gDQgjTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAwC-0006UW-0I; Mon, 11 Feb 2019 12:43:52 +0000
Received: from mail-eopbgr750082.outbound.protection.outlook.com
 ([40.107.75.82] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAva-0005wJ-33
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:43:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRQug7SNBHkzR+3IOWQr3TkGbMFynznZ47ufNM7EJ00=;
 b=tWqeMaYdEjIhB82lHlZy/XUWufu20yg09k1I8YbQC0ndYXMf8MgH9bRgALdHIydmJ5qBXyFPx/XQ6KL/8MIT3m35QDCICbvn+Bn32QKQzo4qPEHKMz2oYbAExyof0CiMyAUgTxEJR3jrs2fX4gp5qnw66EFskpKhR7VAt+TzbyQ=
Received: from CY4PR02MB2709.namprd02.prod.outlook.com (10.175.80.9) by
 CY4PR02MB2472.namprd02.prod.outlook.com (10.173.40.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Mon, 11 Feb 2019 12:43:08 +0000
Received: from CY4PR02MB2709.namprd02.prod.outlook.com
 ([fe80::bc8d:c1a1:e7d9:2983]) by CY4PR02MB2709.namprd02.prod.outlook.com
 ([fe80::bc8d:c1a1:e7d9:2983%10]) with mapi id 15.20.1601.023; Mon, 11 Feb
 2019 12:43:08 +0000
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
Thread-Index: AQHUui2l5ecr9Ru5u0itGn9PqazmdqXaeJcAgAADeXA=
Date: Mon, 11 Feb 2019 12:43:08 +0000
Message-ID: <CY4PR02MB2709000898D5E290B5EE99F4A7640@CY4PR02MB2709.namprd02.prod.outlook.com>
References: <1549025766-135037-1-git-send-email-vishal.sagar@xilinx.com>
 <1549025766-135037-3-git-send-email-vishal.sagar@xilinx.com>
 <3923069f-7c69-c601-0ded-f7629696ef9b@lucaceresoli.net>
In-Reply-To: <3923069f-7c69-c601-0ded-f7629696ef9b@lucaceresoli.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsagar@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR02MB2472;
 6:YbjDiExMJRZOu7d6+OcVPirfWNudjt9zg5dtHrQohLL1BIcwLJVrTeMsKRalgQimw+y+mlKRaX1XW07ajXf797r5mi9tR+DYVOEallXANQtT3oCrrVq8qBZBofuW34B4Nbxi2920qnQYYsdnsZBzpXYPtk612VpygrBYpxbny7KBADvpYfWRiVwcSpk47mdgvc+MhccNSsTvbGKB2oZbEAnVTvm8DnaC3sDfvtWES3+/tifAGaz8eoRsa+gyiGF8a7ePeZeqX1a9htdhFhALCTFM5wiEvd8SZItWs4zBtBEtoXxF1OBe0k2FGOLz0gbekPpLmChQBGAxA3exr3T3nlX7HAESBNl3QRrjl1KDo5Upb/gLfDqeKBT6rvM2n45eQvtgrRiUqYv1oeTIM/SAAZMO5SLGnK/JDB4GfIc6IpfCv4gt7zkZ8P6+7XsKNP3AwOiuUU9bPtINKks6/yWCiw==;
 5:t3pEbVa6dDC4aiOSptFL0wrJbYwo4IkGLTm4fmoZffCC0OvG5ZLdIvCWnFxDneZ+QMIiKAXYojh87gp3envXKGrdeqoz9rvFcl32N9mCbs+S8fFARbFBkkjCowQJiAaQD3cgteGv7f/3gvuivHjKbEdRVhz07Rz28/yMtWDGh9ZZrCuGcnbzEUDnmgT/E4AMq5HihHWr/PP2/bSxHKI2qw==;
 7:6/Yldqf+C30Xf40+rjQhdD3Z5+moK2PEha7penII7rdOBosTCIopTOQmLxZHP7GPjH0piWjwIUL7I5QX651cv+gerigT2ku2UgnXacMuiE9ys5C2p3v1VLTj7w0Dr81I9rYC82jbU/1bIprYpXYSkg==
x-ms-office365-filtering-correlation-id: 02193727-3ba2-40c8-70df-08d6901e79c5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR02MB2472; 
x-ms-traffictypediagnostic: CY4PR02MB2472:
x-microsoft-antispam-prvs: <CY4PR02MB2472B678AF11656D1C6DCA81A7640@CY4PR02MB2472.namprd02.prod.outlook.com>
x-forefront-prvs: 0945B0CC72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(13464003)(76176011)(97736004)(6436002)(99286004)(2501003)(55016002)(66066001)(7416002)(9686003)(6246003)(316002)(86362001)(229853002)(7696005)(2201001)(81166006)(53546011)(81156014)(6506007)(33656002)(8936002)(6116002)(26005)(6636002)(305945005)(106356001)(7736002)(8676002)(11346002)(476003)(486006)(71200400001)(71190400001)(74316002)(14454004)(102836004)(25786009)(256004)(110136005)(53936002)(2906002)(105586002)(446003)(478600001)(68736007)(3846002)(186003)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR02MB2472;
 H:CY4PR02MB2709.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: guKH8VzbTD9gnT81mZpdhe+HpxUCjnYHnE9Xmg7A+5YzB7AvZNx7q/1fzvfr9sJVr1BVJunVz9zZosQDZEwNDRBOEZWJrtv0wmSTg+RiSxziokpHeT4KLaTDA4JAynUcga3VgFRaZxlG/A6mwfjC4DJtOwY2pDqxtEHN1KCxwl629kvDQU1zXu3e2phAjLhg7BnHKrJ1mmpn6H2DksMzEriwOpsDJ6CkeJtb9TKxS3Vux99NwXSa291pOVqpBrQg/pkH1oQ24Yi+yCnxnFXW6aAeR/Q3S57w1ogQqxJ21SIjvmBgW5REoOL6vDRei432ngvT8k/amxgxsWPZOdigKG4tkJkTjwajU8dQCczdhAQipk+VfQhz6lxcrhJp/CUYV0Ra2o+VlS6Hnig/z4LP8BZgVIvM4Cy9WrYYGDdnN8A=
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02193727-3ba2-40c8-70df-08d6901e79c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2019 12:43:08.4974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2472
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_044315_208914_AA37C754 
X-CRM114-Status: GOOD (  21.69  )
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

Thanks for reviewing this. 

> -----Original Message-----
> From: Luca Ceresoli [mailto:luca@lucaceresoli.net]
> Sent: Monday, February 11, 2019 4:12 PM
> To: Vishal Sagar <vishal.sagar@xilinx.com>; Hyun Kwon <hyunk@xilinx.com>;
> laurent.pinchart@ideasonboard.com; mchehab@kernel.org;
> robh+dt@kernel.org; mark.rutland@arm.com; Michal Simek
> <michals@xilinx.com>; linux-media@vger.kernel.org;
> devicetree@vger.kernel.org; sakari.ailus@linux.intel.com;
> hans.verkuil@cisco.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Dinesh Kumar <dineshk@xilinx.com>; Sandip Kothari
> <sandipk@xilinx.com>
> Subject: Re: [PATCH v3 2/2] media: v4l: xilinx: Add Xilinx MIPI CSI-2 Rx
> Subsystem
> 
> EXTERNAL EMAIL
> 
> Hi Vishal,
> 
> On 01/02/19 13:56, Vishal Sagar wrote:
> > The Xilinx MIPI CSI-2 Rx Subsystem soft IP is used to capture images
> > from MIPI CSI-2 camera sensors and output AXI4-Stream video data ready
> > for image processing. Please refer to PG232 for details.
> 
> For those unused to Xilinx documentation I'd use the full document name
> ("MIPI CSI-2 Receiver Subsystem v4.0") or, even better, a stable URL if
> available.
> 

Ok. I will add the full documentation name here and URL.

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
> 
> ...
> 
> > +/**
> > + * xcsi2rxss_reset - Does a soft reset of the MIPI CSI2 Rx Subsystem
> > + * @core: Core Xilinx CSI2 Rx Subsystem structure pointer
> > + *
> > + * Core takes less than 100 video clock cycles to reset.
> > + * So a larger timeout value is chosen for margin.
> > + *
> > + * Return: 0 - on success OR -ETIME if reset times out
> > + */
> > +static int xcsi2rxss_reset(struct xcsi2rxss_core *core)
> > +{
> > +     u32 timeout = XCSI_TIMEOUT_VAL;
> 
> The comment about the timeout is duplicated here and at the #define
> line. Why not removing the define above and just putting
> 
>   u32 timeout = 1000; /* us */
> 
> here? It would make the entire timeout logic appear in a unique place.
> 

Agree. It was kept like that as the timeout value was being used in some other place in earlier patch versions.
I will do as suggested in next version.

> > +static int xcsi2rxss_start_stream(struct xcsi2rxss_state *state)
> > +{
> > +     struct xcsi2rxss_core *core = &state->core;
> > +     int ret = 0;
> > +
> > +     xcsi2rxss_enable(core);
> > +
> > +     ret = xcsi2rxss_reset(core);
> > +     if (ret < 0) {
> > +             state->streaming = false;
> > +             return ret;
> > +     }
> > +
> > +     xcsi2rxss_intr_enable(core);
> > +     state->streaming = true;
> 
> Shouldn't you propagate s_stream to the upstream subdev here calling
> v4l2_subdev_call(..., ..., s_stream, 1)?
> 

This is done by the xvip_pipeline_start_stop() in xilinx-dma.c for Xilinx Video pipeline.

> > +     return ret;
> > +}
> 
> 
> --
> Luca

Regards
Vishal Sagar
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
