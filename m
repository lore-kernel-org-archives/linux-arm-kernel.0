Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7431CC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:50:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448D020656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZSo5SrVK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="vSOX/8rQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448D020656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3TMflWRMPNyfLQNHOA48lS0/nDniesXvB4zzjh9qSnw=; b=ZSo5SrVKLFMuaY
	yR8syKvc04sLww8yFra7IHqWuA+ZLdGjj/InzrK+dqOK5e5EC465KNDUN8dD7UdmjcO3TuKLlEwYb
	FEK4HTUpkFGSCIXqJwSzA+fJt1OGhgQPb5eB6U4o5hjKs2tvmbQ7nGvhINLg217cmTOl09MSyc3Gd
	TBMcQ263AVs7B51BQQzTyJaqbIqtP8rCKVpDS/UD981PT279gSQNx8DXvX6vgSGVG+g2lztBxbG3F
	Tg1CWSV7LDNtjPT+KAzEM9goSWGAkGxyjvIIeOWOGyh6P8cgEFa9JRpEQ5Uucuxj0Mpz+Ojkf9ePY
	UZ5rFGlR9OQsk8P3KxvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1giyse-0005wX-WE; Mon, 14 Jan 2019 09:50:05 +0000
Received: from mail-eopbgr770079.outbound.protection.outlook.com
 ([40.107.77.79] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1giyqW-00049B-U6
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 09:48:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rP7xA5NMqRjMfp4LF8ScFD4hQyaRzqra5X7dErhA2mw=;
 b=vSOX/8rQdVl8MHJ9n/sYzFMc4zTZCSYNHZdNHPi3EykQ0iPI3FK4NNSuAw1kgOnt3vFC7Gu0mIauHedlOBTm5I16+/tVC9OwYoBseVbf4aut74/OZsTeuGDbt0Jryd+N8USxGbY7r9KB/cPThbTVNYal2gJ1YuCET6dr8tOfsig=
Received: from CY4PR02MB2709.namprd02.prod.outlook.com (10.175.59.19) by
 CY4PR02MB2200.namprd02.prod.outlook.com (10.169.180.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Mon, 14 Jan 2019 09:47:48 +0000
Received: from CY4PR02MB2709.namprd02.prod.outlook.com
 ([fe80::208e:498e:e558:12]) by CY4PR02MB2709.namprd02.prod.outlook.com
 ([fe80::208e:498e:e558:12%3]) with mapi id 15.20.1516.019; Mon, 14 Jan 2019
 09:47:41 +0000
From: Vishal Sagar <vsagar@xilinx.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, Vishal Sagar
 <vishal.sagar@xilinx.com>
Subject: RE: [PATCH 1/2] media: dt-bindings: media: xilinx: Add Xilinx MIPI
 CSI-2 Rx Subsystem
Thread-Topic: [PATCH 1/2] media: dt-bindings: media: xilinx: Add Xilinx MIPI
 CSI-2 Rx Subsystem
Thread-Index: AQHUp1LB9yVBRVhU3kSv/sTypyy0J6WqXxWg
Date: Mon, 14 Jan 2019 09:47:41 +0000
Message-ID: <CY4PR02MB2709C346C4BEF853C48C32DCA7800@CY4PR02MB2709.namprd02.prod.outlook.com>
References: <1527620084-94864-1-git-send-email-vishal.sagar@xilinx.com>
 <1527620084-94864-2-git-send-email-vishal.sagar@xilinx.com>
 <20190108130457.syjuq7u7vep3km3h@paasikivi.fi.intel.com>
In-Reply-To: <20190108130457.syjuq7u7vep3km3h@paasikivi.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsagar@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR02MB2200;
 6:/uHEqzJr6Su7Ml5R1FLlQ3PlMXVJGvomO0wsW9PqRz3+8zQHmUvwII8LZp6t+7sxsdw3ABBhPPot930/hs6hZEkybBanlDeVHqByW6d8J0FUu3evxGTrf/qYNWWPvfYNB2cW/zvuEp/db2tzQ3QlEg2wh7OUA56jv7Ko2AJ61aH+3d3jkLeEKTA18LLEAiZA9We7Z+WIzGEgBFfefqVIjDmEle79GL41yROOCqt5SvJzn15Vzxu+uH1sTtdgZKx9hOJWWsEy02Do8kG0Cra5+8IkNb/lnEeXF0s5zRcGh2PmsSGDF59Gq0ueZVRxflJZWDi3V77a6kabEQ/6ZeK/KqW+itm96zp9OKfBNMtfNZtgP8bT9lyfOUgwHYzYx60GdV6/eOf55Bx6Lq0ke1pDqOKJhqSRYQw04reP4ubNMxaA1MIzOE1u/LRp27ZlqgrbR70pVM3OP1T0vJLFDN0ecA==;
 5:8VULKAmBnjuHb1+bSxlGISYzB4e1IgNzsW1YqMZi6ciPZ3xzOZr0bBP8NRpc/5MXTb1SxAi+TeQhUnIxsPL6tryzX6PSDeu90ymT5Np1/iXGCpy3LKDesZI4l62yJTIFTA7qcSajtithRYPS/ulhqwC05sEnYDRH6U4Pjns516c0t7fyq6h1hHd/Doczd6NutE7HBgeLNESVNEbnw13FVA==;
 7:VTWXnguPCVlD261ykmEw+QnuT/56ZPbSPk3BQgkdzpbEk8LrLouKnIHx5DiQ4n7DSeFVEzGX0tVrr+6gA0b99qhkf68g8gOg4izMyReVWIvItdlyXW4xwUCr9p4NL81WFSjdMGReHKMwfgWrarZ2yg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10009020)(39860400002)(366004)(136003)(346002)(376002)(396003)(189003)(199004)(13464003)(76176011)(256004)(478600001)(7696005)(2906002)(102836004)(8936002)(6636002)(229853002)(71190400001)(71200400001)(81156014)(5024004)(55016002)(105586002)(5660300001)(8676002)(14444005)(97736004)(53546011)(106356001)(6506007)(305945005)(446003)(74316002)(11346002)(81166006)(33656002)(6116002)(3846002)(7736002)(6436002)(476003)(14454004)(54906003)(86362001)(4326008)(110136005)(316002)(7416002)(6306002)(6246003)(66066001)(68736007)(26005)(486006)(9686003)(186003)(53936002)(99286004)(25786009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR02MB2200;
 H:CY4PR02MB2709.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-office365-filtering-correlation-id: 83915dfa-8c37-4776-6ef6-08d67a0553bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR02MB2200; 
x-ms-traffictypediagnostic: CY4PR02MB2200:
x-microsoft-antispam-prvs: <CY4PR02MB22009DAA72918D1D4DC29DEAA7800@CY4PR02MB2200.namprd02.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GttNiF+pSl91IBY2eY600hNHno63EPCSuzr/X4wSkmJVWtzI7qYm0MrJ1cXqmfu8NlLtzKnYMtF82bq0NIrzPdIqmIerr2vBJjEc9vnO3lHasqLastd4o88EczEbHluh9DL4tuI41/OcM1z39MaqgMf39WtSUb95qgl8botVZjMWNBli+XoI5nwKIKNxlDJIAW6sx6XZLgR31szXgxYKxJyeaAX6FoPEFZosiUHtWwKkaBMmWIE18T7b+QucK7O0Tz2WBN4rar7if1XfD1Tav/xjvOUPy76pakoJN9OsMjkDe9fjNNmTGByy7/mfH/fXE4JaD997pKZBSlwjyqoIjlRu0YlRbMqu/jZz10Ow+U4/TN9lrzNfjHJoqovaqxcKOeHvzYfjIDt07sm3SZrBj097ywb0A/cjSfziLYqkB8g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83915dfa-8c37-4776-6ef6-08d67a0553bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2019 09:47:41.5529 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2200
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_014753_179795_EBADD0DC 
X-CRM114-Status: GOOD (  33.28  )
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
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "hans.verkuil@cisco.com" <hans.verkuil@cisco.com>,
 "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michals@xilinx.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Sakari,

Thanks for reviewing this. 

> -----Original Message-----
> From: Sakari Ailus [mailto:sakari.ailus@linux.intel.com]
> Sent: Tuesday, January 08, 2019 6:35 PM
> To: Vishal Sagar <vishal.sagar@xilinx.com>
> Cc: Hyun Kwon <hyunk@xilinx.com>; laurent.pinchart@ideasonboard.com;
> Michal Simek <michals@xilinx.com>; linux-media@vger.kernel.org;
> devicetree@vger.kernel.org; hans.verkuil@cisco.com; mchehab@kernel.org;
> robh+dt@kernel.org; mark.rutland@arm.com; Dinesh Kumar
> <dineshk@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 1/2] media: dt-bindings: media: xilinx: Add Xilinx MIPI CSI-2
> Rx Subsystem
> 
> EXTERNAL EMAIL
> 
> Hi Vishal,
> 
> The patchset hard escaped me somehow earlier and your reply to Rob made me
> notice it again. Thanks. :-)
> 
> On Wed, May 30, 2018 at 12:24:43AM +0530, Vishal Sagar wrote:
> > Add bindings documentation for Xilinx MIPI CSI-2 Rx Subsystem.
> >
> > The Xilinx MIPI CSI-2 Rx Subsystem consists of a DPHY, CSI-2 Rx, an
> > optional I2C controller and an optional Video Format Bridge (VFB). The
> > active lanes can be configured at run time if enabled in the IP. The
> > DPHY register interface may also be enabled.
> >
> > Signed-off-by: Vishal Sagar <vishal.sagar@xilinx.com>
> > ---
> >  .../bindings/media/xilinx/xlnx,csi2rxss.txt        | 117
> +++++++++++++++++++++
> >  1 file changed, 117 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> >
> > diff --git a/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> b/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> > new file mode 100644
> > index 0000000..31ed721
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> > @@ -0,0 +1,117 @@
> > +
> 
> Extra newline.
> 

Will remove it in next version. 

> > +Xilinx MIPI CSI2 Receiver Subsystem Device Tree Bindings
> > +--------------------------------------------------------
> > +
> > +The Xilinx MIPI CSI2 Receiver Subsystem is used to capture MIPI CSI2 traffic
> > +from compliant camera sensors and send the output as AXI4 Stream video
> data
> > +for image processing.
> > +
> > +The subsystem consists of a MIPI DPHY in slave mode which captures the
> > +data packets. This is passed along the MIPI CSI2 Rx IP which extracts the
> > +packet data. This data is taken in by the Video Format Bridge (VFB),
> > +if selected, and converted into AXI4 Stream video data at selected
> > +pixels per clock as per AXI4-Stream Video IP and System Design UG934.
> > +
> > +For more details, please refer to PG232 MIPI CSI-2 Receiver Subsystem.
> >
> +https://www.xilinx.com/support/documentation/ip_documentation/mipi_csi
> 2_rx_subsystem/v3_0/pg232-mipi-csi2-rx.pdf
> > +
> > +Required properties:
> > +
> > +- compatible: Must contain "xlnx,mipi-csi2-rx-subsystem-2.0" or
> > +  "xlnx,mipi-csi2-rx-subsystem-3.0"
> > +
> > +- reg: Physical base address and length of the registers set for the device.
> > +
> > +- interrupt-parent: specifies the phandle to the parent interrupt controller
> > +
> > +- interrupts: Property with a value describing the interrupt number.
> > +
> > +- xlnx,max-lanes: Maximum active lanes in the design.
> > +
> > +- xlnx,vc: Virtual Channel, specifies virtual channel number to be filtered.
> > +  If this is 4 then all virtual channels are allowed.
> 
> This seems like something a driver should configure, based on the
> configuration of the connected device.
> 

The filtering of the Virtual channels is property of the hardware IP and is fixed in design. 
This is not software controlled.

> > +
> > +- xlnx,csi-pxl-format: This denotes the CSI Data type selected in hw design.
> > +  Packets other than this data type (except for RAW8 and User defined data
> > +  types) will be filtered out. Possible values are RAW6, RAW7, RAW8, RAW10,
> > +  RAW12, RAW14, RGB444, RGB555, RGB565, RGB666, RGB888 and
> YUV4228bit.
> 
> This should be configured at runtime instead through V4L2 sub-device
> interface; it's not a property of the hardware.
>

This too is a property of the hardware IP and is fixed to one data type during design to reduce gate count.
So for e.g. if RGB888 is selected during design, then the hardware will only pass across RGB888 packet data to output.
(RAW8 packets are also allowed to pass through for all data types selected)
This is used in the driver to determine the media bus format of the connected pads.

> > +
> > +- xlnx,axis-tdata-width: AXI Stream width, This denotes the AXI Stream width.
> > +  It depends on Data type chosen, Video Format Bridge enabled/disabled and
> > +  pixels per clock. If VFB is disabled then its value is either 0x20 (32 bit)
> > +  or 0x40(64 bit) width.
> > +
> > +- xlnx,video-format, xlnx,video-width: Video format and width, as defined in
> > +  video.txt.
> 
> Ditto.
> 
Again these are fixed values and can't be changed at run time. 
These are used to determine the media bus format.

> > +
> > +- port: Video port, using the DT bindings defined in ../video-interfaces.txt.
> > +  The CSI 2 Rx Subsystem has a two ports, one input port for connecting to
> > +  camera sensor and other is output port.
> > +
> > +- data-lanes: The number of data lanes through which CSI2 Rx Subsystem is
> > +  connected to the camera sensor as per video-interfaces.txt
> 
> This is somewhat different from the documentation in video-interfaces.txt.
> Could you align the two? I don't think there's a need to document standard
> properties in device binding files elaborately; rather just the hardware
> specific bits.
> 

Agree. In this current IP there is no way to re-order the lanes which are set at design time.
So physical and logical lanes are at same index. This could only be used to determine how many lanes are allowed to be programmed.
For e.g. if design has set the number of lanes as 4 and xlnx,en-active-lanes is present, then the number of lanes 
can be set from 1 to 4.

> > +
> > +Optional properties:
> > +
> > +- xlnx,en-active-lanes: Enable Active lanes configuration in Protocol
> > +  Configuration Register.
> > +
> > +- xlnx,dphy-present: This is equivalent to whether DPHY register interface is
> > +  enabled or not.
> > +
> > +- xlnx,iic-present: This shows whether subsystem's IIC is present or not. This
> > +  affects the base address of the DPHY.
> > +
> > +- xlnx,vfb: Video Format Bridge, Denotes if Video Format Bridge is selected
> > +  so that output is as per AXI stream documented in UG934.
> > +
> > +- xlnx,ppc: Pixels per clock, Number of pixels to be transferred per pixel
> > +  clock. This is valid only if xlnx,vfb property is present.
> > +
> > +Example:
> > +
> > +       csiss_1: csiss@a0020000 {
> > +               compatible = "xlnx,mipi-csi2-rx-subsystem-3.0";
> > +               reg = <0x0 0xa0020000 0x0 0x20000>;
> > +               interrupt-parent = <&gic>;
> > +               interrupts = <0 95 4>;
> > +
> > +               xlnx,max-lanes = <0x4>;
> > +               xlnx,en-active-lanes;
> > +               xlnx,dphy-present;
> > +               xlnx,iic-present;
> > +               xlnx,vc = <0x4>;
> > +               xlnx,csi-pxl-format = "RAW8";
> > +               xlnx,vfb;
> > +               xlnx,ppc = <0x4>;
> > +               xlnx,axis-tdata-width = <0x20>;
> > +
> > +               ports {
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +
> > +                       port@0 {
> > +                               reg = <0>;
> > +
> > +                               xlnx,video-format = <XVIP_VF_YUV_422>;
> > +                               xlnx,video-width = <8>;
> > +                               csiss_out: endpoint {
> > +                                       remote-endpoint = <&vcap_csiss_in>;
> > +                               };
> > +                       };
> > +                       port@1 {
> > +                               reg = <1>;
> > +
> > +                               xlnx,video-format = <XVIP_VF_YUV_422>;
> > +                               xlnx,video-width = <8>;
> > +
> > +                               csiss_in: endpoint {
> > +                                       data-lanes = <1 2 3 4>;
> > +                                       /* MIPI CSI2 Camera handle */
> > +                                       remote-endpoint = <&vs2016_out>;
> > +                               };
> > +
> > +                       };
> > +
> > +               };
> > +       };
> > --
> > 2.7.4
> >
> > This email and any attachments are intended for the sole use of the named
> recipient(s) and contain(s) confidential information that may be proprietary,
> privileged or copyrighted under applicable law. If you are not the intended
> recipient, do not read, copy, or forward this email message or any attachments.
> Delete this email message and any attachments immediately.
> 
> Could you drop this from v2?
> 

Ok. 

Regards
Vishal Sagar

> --
> Regards,
> 
> Sakari Ailus
> sakari.ailus@linux.intel.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
