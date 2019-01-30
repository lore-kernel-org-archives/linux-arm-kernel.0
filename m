Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503BDC282D5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:48:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1271D2184D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Xwd5ROKS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xtU48DQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1271D2184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nyKmvD5Avn9eiU4vCJZUt4k2YCaR2R72xixpQ3hnBxc=; b=Xwd5ROKS04P+6S
	376H2Lf1mA41uJ5VAwLpySpD540oJpbhiA7gq1o+pVsxymQDw9Iq/l4inPUIxy5dqIa9TryGgQKsg
	IjWEaGrltxJkQK6vgM9Y3P+bRDl2oa4vEJh1stZy8K2WSOANq3MllZcumzapP1OPr1n5vOyqEGnr/
	hCYNLdbUK1WVT7ehxxlpXCxcYnA+K0m4Bhms6//kdo5M72rNjQ0q85hRnPLx06x8DVIqh+/X8v7pz
	fXeVU8yLDXS15tACCGIOwe1MiU5TXt2fGo1Wmjb2Pd0FCKEPnIv6jbL1syb9v/ehoRCENjpanjgN4
	wc4QgcbKKpXZcK+gI/+w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goijn-0007Km-S7; Wed, 30 Jan 2019 05:48:39 +0000
Received: from mail-eopbgr750045.outbound.protection.outlook.com
 ([40.107.75.45] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goijk-0007KB-D3
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 05:48:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUhgNHTSr0fPBcy6BGuluOx3OWf/ABzQnkEluIpOe8E=;
 b=xtU48DQeOWut73g58vi++onrtAlZRvRkYVFLVi9D79nEmgDDQ4NWrFpmZCg4lYfEXZdJ/oc2Fb6obV6BKdF8Hlf49kcDppEF9VTORVI/LpqRqAj8U3yTTq/Enrt8I+2fiAexZLtNz5G52mFAxXUN+N8HfYpPFp85dCa0WZdcLnc=
Received: from CY4PR02MB2709.namprd02.prod.outlook.com (10.175.59.19) by
 CY4PR02MB2503.namprd02.prod.outlook.com (10.173.40.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Wed, 30 Jan 2019 05:48:32 +0000
Received: from CY4PR02MB2709.namprd02.prod.outlook.com
 ([fe80::c41a:f0ef:3b4e:6903]) by CY4PR02MB2709.namprd02.prod.outlook.com
 ([fe80::c41a:f0ef:3b4e:6903%3]) with mapi id 15.20.1558.023; Wed, 30 Jan 2019
 05:48:32 +0000
From: Vishal Sagar <vsagar@xilinx.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: RE: [PATCH 1/2] media: dt-bindings: media: xilinx: Add Xilinx MIPI
 CSI-2 Rx Subsystem
Thread-Topic: [PATCH 1/2] media: dt-bindings: media: xilinx: Add Xilinx MIPI
 CSI-2 Rx Subsystem
Thread-Index: AQHUp1LB9yVBRVhU3kSv/sTypyy0J6WqXxWggBpUWACAAraqkA==
Date: Wed, 30 Jan 2019 05:48:31 +0000
Message-ID: <CY4PR02MB270952A6BEE16CA27CE8C601A7900@CY4PR02MB2709.namprd02.prod.outlook.com>
References: <1527620084-94864-1-git-send-email-vishal.sagar@xilinx.com>
 <1527620084-94864-2-git-send-email-vishal.sagar@xilinx.com>
 <20190108130457.syjuq7u7vep3km3h@paasikivi.fi.intel.com>
 <CY4PR02MB2709C346C4BEF853C48C32DCA7800@CY4PR02MB2709.namprd02.prod.outlook.com>
 <20190128120018.ztdxmcq4tizwwepn@paasikivi.fi.intel.com>
In-Reply-To: <20190128120018.ztdxmcq4tizwwepn@paasikivi.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsagar@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR02MB2503;
 6:pBhFuKqI+WnaLLK8vIW0knP7cB53y4JOOsykhLFglFwRpJ+FMeJHH4rCYM4eSXOlOf53GKokOVKctUK67Hw8aSQHB6a2Svq6rZHFEir+E9KCChtiJfEOnv0VZSJoh2By9dk/cab0/brdS6VKxGI8xbtXSzfpd1IJ56r+Mu7G6DwPPVggAtE30PRQHsoq3sEHjOAh8W8MBAzK9Ji5hTGuX37DxaT37m9/mx45eNbDinNzMfsyoWvixrxzQJy8JHPvQo+zifwh0c4tOfu9hJuBLaXtUo3U/sEd4AJgDcqIx5cpZXaV6ANAGfPO4XnMr2RTeGscxKjix0+9+1vrU2w5ZK4vFYaqXVqxOI6daBLFt1Ikyi9db9aBjyg2WnUTCl72YzyEGXLU7X0J9WVBht9PBZU1xFqV4tZn9tT0Qwc6HxUnXiOOIwZ9Sor2fl31EsUHrEuKtorabbzRuhmYY/7tpA==;
 5:tlYfOgvnY1ipOrocmmQrv284MvG4gFyh9YoTs8aS/6jsEDQTMl8qUnDNkkVIHST1D1478VLdbiaIAEc8bgPlQcAWJ4AasMeJ41l0yDxL65mnrZQUwML7bciLatZteQVRkrhPWjiC5BbWx3PWAM1xHjlG7OwaRNTiDyQICkDQ8KdHcM4A9scGbAvUcRBrGk7B4zQT4othavOgKglTmcOKKg==;
 7:Gzp7qgxsg4q5xvKJEm37k7vAelAYPUIUuGvipPYZux7RECARQ4VFX6fFMTCXiYzd2tb3zA94ZYdW9RWoyJ/K3P6TBAu90Y9ceIGMtXuDlQyN0MI0F0AxOUzG535+HdnFu4oJXQ2+phyiD8leKR1iew==
x-ms-office365-filtering-correlation-id: 4e76d553-4daf-4c5c-c1ae-08d68676913e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR02MB2503; 
x-ms-traffictypediagnostic: CY4PR02MB2503:
x-microsoft-antispam-prvs: <CY4PR02MB250373CD48F15BB1BDFE9198A7900@CY4PR02MB2503.namprd02.prod.outlook.com>
x-forefront-prvs: 0933E9FD8D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(39860400002)(396003)(136003)(346002)(366004)(376002)(13464003)(199004)(189003)(486006)(2906002)(446003)(6436002)(11346002)(6246003)(229853002)(476003)(106356001)(6306002)(478600001)(97736004)(81166006)(316002)(14454004)(99286004)(8936002)(93886005)(9686003)(66066001)(7736002)(74316002)(55016002)(105586002)(81156014)(8676002)(25786009)(76176011)(256004)(54906003)(4326008)(26005)(305945005)(53936002)(7696005)(3846002)(71190400001)(6916009)(33656002)(6506007)(53546011)(68736007)(6116002)(186003)(7416002)(14444005)(102836004)(71200400001)(86362001)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR02MB2503;
 H:CY4PR02MB2709.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qsT9nKBOVmGr2Jugkup7EWJtVLitOO95jnElVBQoNFVlvG5MsWmsYVSp8BEfFxNuumm9oouAekFaHDQ6tNhwd3iMZUZulWewN30MK7O3lJnd2FVNI8TIcGG5i6knfygYmkVwfM8Dvgym27eG6bjhRlqMFtkMcPzh+xgsOJiUhN9+TKBVa5UL2/CgKIVihSB+b0ka9RU07LyPAcS3cvicbzAvLzoUd40r1WND/3DULg+3R/6wBYAFDATPgjK/r9JJoz+mYRLdDR8MLFQMISPE8t53sTNbL9kRkQF1xa1/UY359GhL+AYTOy1F1s/+qqg/INPx0Pigo4+uW8H4lApetk1UK9WehQFLgFzWwT0kfrwgh75yMDUyeqbAb2wq4v2jTbwpUh9MOB1o7hXh7OWL26E9R2w504o4+eDUyQoWMV0=
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e76d553-4daf-4c5c-c1ae-08d68676913e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2019 05:48:31.9414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2503
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_214836_524400_F9384723 
X-CRM114-Status: GOOD (  35.79  )
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
 Dinesh Kumar <dineshk@xilinx.com>, Hyun Kwon <hyunk@xilinx.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Michal Simek <michals@xilinx.com>,
 "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
 Vishal Sagar <vishal.sagar@xilinx.com>,
 "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sakari,

> -----Original Message-----
> From: Sakari Ailus [mailto:sakari.ailus@linux.intel.com]
> Sent: Monday, January 28, 2019 5:30 PM
> To: Vishal Sagar <vsagar@xilinx.com>
> Cc: Vishal Sagar <vishal.sagar@xilinx.com>; Hyun Kwon <hyunk@xilinx.com>;
> laurent.pinchart@ideasonboard.com; Michal Simek <michals@xilinx.com>;
> linux-media@vger.kernel.org; devicetree@vger.kernel.org;
> hans.verkuil@cisco.com; mchehab@kernel.org; robh+dt@kernel.org;
> mark.rutland@arm.com; Dinesh Kumar <dineshk@xilinx.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] media: dt-bindings: media: xilinx: Add Xilinx MIPI CSI-2
> Rx Subsystem
> 
> Hi Vishal,
> 
> On Mon, Jan 14, 2019 at 09:47:41AM +0000, Vishal Sagar wrote:
> > Hi Sakari,
> >
> > Thanks for reviewing this.
> >
> > > -----Original Message-----
> > > From: Sakari Ailus [mailto:sakari.ailus@linux.intel.com]
> > > Sent: Tuesday, January 08, 2019 6:35 PM
> > > To: Vishal Sagar <vishal.sagar@xilinx.com>
> > > Cc: Hyun Kwon <hyunk@xilinx.com>; laurent.pinchart@ideasonboard.com;
> > > Michal Simek <michals@xilinx.com>; linux-media@vger.kernel.org;
> > > devicetree@vger.kernel.org; hans.verkuil@cisco.com; mchehab@kernel.org;
> > > robh+dt@kernel.org; mark.rutland@arm.com; Dinesh Kumar
> > > <dineshk@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> > > kernel@vger.kernel.org
> > > Subject: Re: [PATCH 1/2] media: dt-bindings: media: xilinx: Add Xilinx MIPI
> CSI-2
> > > Rx Subsystem
> > >
> > > EXTERNAL EMAIL
> > >
> > > Hi Vishal,
> > >
> > > The patchset hard escaped me somehow earlier and your reply to Rob made
> me
> > > notice it again. Thanks. :-)
> > >
> > > On Wed, May 30, 2018 at 12:24:43AM +0530, Vishal Sagar wrote:
> > > > Add bindings documentation for Xilinx MIPI CSI-2 Rx Subsystem.
> > > >
> > > > The Xilinx MIPI CSI-2 Rx Subsystem consists of a DPHY, CSI-2 Rx, an
> > > > optional I2C controller and an optional Video Format Bridge (VFB). The
> > > > active lanes can be configured at run time if enabled in the IP. The
> > > > DPHY register interface may also be enabled.
> > > >
> > > > Signed-off-by: Vishal Sagar <vishal.sagar@xilinx.com>
> > > > ---
> > > >  .../bindings/media/xilinx/xlnx,csi2rxss.txt        | 117
> > > +++++++++++++++++++++
> > > >  1 file changed, 117 insertions(+)
> > > >  create mode 100644
> > > Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> > > >
> > > > diff --git
> a/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> > > b/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> > > > new file mode 100644
> > > > index 0000000..31ed721
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> > > > @@ -0,0 +1,117 @@
> > > > +
> > >
> > > Extra newline.
> > >
> >
> > Will remove it in next version.
> >
> > > > +Xilinx MIPI CSI2 Receiver Subsystem Device Tree Bindings
> > > > +--------------------------------------------------------
> > > > +
> > > > +The Xilinx MIPI CSI2 Receiver Subsystem is used to capture MIPI CSI2
> traffic
> > > > +from compliant camera sensors and send the output as AXI4 Stream
> video
> > > data
> > > > +for image processing.
> > > > +
> > > > +The subsystem consists of a MIPI DPHY in slave mode which captures the
> > > > +data packets. This is passed along the MIPI CSI2 Rx IP which extracts the
> > > > +packet data. This data is taken in by the Video Format Bridge (VFB),
> > > > +if selected, and converted into AXI4 Stream video data at selected
> > > > +pixels per clock as per AXI4-Stream Video IP and System Design UG934.
> > > > +
> > > > +For more details, please refer to PG232 MIPI CSI-2 Receiver Subsystem.
> > > >
> > >
> +https://www.xilinx.com/support/documentation/ip_documentation/mipi_csi
> > > 2_rx_subsystem/v3_0/pg232-mipi-csi2-rx.pdf
> > > > +
> > > > +Required properties:
> > > > +
> > > > +- compatible: Must contain "xlnx,mipi-csi2-rx-subsystem-2.0" or
> > > > +  "xlnx,mipi-csi2-rx-subsystem-3.0"
> > > > +
> > > > +- reg: Physical base address and length of the registers set for the device.
> > > > +
> > > > +- interrupt-parent: specifies the phandle to the parent interrupt
> controller
> > > > +
> > > > +- interrupts: Property with a value describing the interrupt number.
> > > > +
> > > > +- xlnx,max-lanes: Maximum active lanes in the design.
> > > > +
> > > > +- xlnx,vc: Virtual Channel, specifies virtual channel number to be filtered.
> > > > +  If this is 4 then all virtual channels are allowed.
> > >
> > > This seems like something a driver should configure, based on the
> > > configuration of the connected device.
> > >
> >
> > The filtering of the Virtual channels is property of the hardware IP and is fixed
> in design.
> > This is not software controlled.
> 
> So... you have different IP blocks between which (one of) the difference(s)
> is the virtual channel?
> 

Your understanding is correct. 

The Xilinx CSI2 Rx subsystem has the 3 blocks -
1 - Xilinx CSI2 Rx controller
2 - Xilinx DPHY in Rx mode (whose register interface may be disabled/fixed configuration to reduce logic gate count).
3 - Xilinx I2C controller (used as CCI - camera control interface)

The virtual channel filtering is a property of the CSI2 Rx controller.
This was present in v1 as I wanted the IP configuration to be available for debug.
This has been removed in v2 as it is not really used in the driver.

> >
> > > > +
> > > > +- xlnx,csi-pxl-format: This denotes the CSI Data type selected in hw
> design.
> > > > +  Packets other than this data type (except for RAW8 and User defined
> data
> > > > +  types) will be filtered out. Possible values are RAW6, RAW7, RAW8,
> RAW10,
> > > > +  RAW12, RAW14, RGB444, RGB555, RGB565, RGB666, RGB888 and
> > > YUV4228bit.
> > >
> > > This should be configured at runtime instead through V4L2 sub-device
> > > interface; it's not a property of the hardware.
> > >
> >
> > This too is a property of the hardware IP and is fixed to one data type
> > during design to reduce gate count. So for e.g. if RGB888 is selected
> > during design, then the hardware will only pass across RGB888 packet data
> > to output. (RAW8 packets are also allowed to pass through for all data
> > types selected) This is used in the driver to determine the media bus
> > format of the connected pads.
> 
> If I understand this correctly, RAW8 and user defined data types will
> always pass through, plus the other data types listed here. Is that right?

Correct.

> 
> >
> > > > +
> > > > +- xlnx,axis-tdata-width: AXI Stream width, This denotes the AXI Stream
> width.
> > > > +  It depends on Data type chosen, Video Format Bridge enabled/disabled
> and
> > > > +  pixels per clock. If VFB is disabled then its value is either 0x20 (32 bit)
> > > > +  or 0x40(64 bit) width.
> > > > +
> > > > +- xlnx,video-format, xlnx,video-width: Video format and width, as defined
> in
> > > > +  video.txt.
> > >
> > > Ditto.
> > >
> > Again these are fixed values and can't be changed at run time.
> > These are used to determine the media bus format.
> 
> What kind of values can the xlnx,video-format property have? How about
> xlnx.video-width? Where can video.txt be found?
> 

The video.txt is present at Documentation/devicetree/bindings/media/xilinx/video.txt
But I have removed this from v2 as the media bus format can be derived from the CSI pixel format 
as described above.

> >
> > > > +
> > > > +- port: Video port, using the DT bindings defined in ../video-interfaces.txt.
> > > > +  The CSI 2 Rx Subsystem has a two ports, one input port for connecting
> to
> > > > +  camera sensor and other is output port.
> > > > +
> > > > +- data-lanes: The number of data lanes through which CSI2 Rx Subsystem
> is
> > > > +  connected to the camera sensor as per video-interfaces.txt
> > >
> > > This is somewhat different from the documentation in video-interfaces.txt.
> > > Could you align the two? I don't think there's a need to document standard
> > > properties in device binding files elaborately; rather just the hardware
> > > specific bits.
> > >
> >
> > Agree. In this current IP there is no way to re-order the lanes which are set at
> design time.
> > So physical and logical lanes are at same index. This could only be used to
> determine how many lanes are allowed to be programmed.
> > For e.g. if design has set the number of lanes as 4 and xlnx,en-active-lanes is
> present, then the number of lanes
> > can be set from 1 to 4.
> 
> Ack.
> 
> --
> Regards,
> 
> Sakari Ailus
> sakari.ailus@linux.intel.com

Regards
Vishal Sagar


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
