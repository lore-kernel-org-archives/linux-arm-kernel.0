Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50C0C282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:00:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63562175B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QmOItJGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63562175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kkt9vGqiAyyC3W0yF7qzANmApKJIN5Y28TKCEC7hGCY=; b=QmOItJGWaE5GGz
	LgigJr/JQSdsyq7kg+1LN8HjMu8LOOoEmVzTQqC5NxtrtrEx9KaKcBz8+kzcmbrhPbe99CbGIjWk9
	AlDCUpv8nmcwIBGYMa5oNiADvJMI/FJr0A+wNa7PXAHZQ4zzEGdHg32v4MtYv9c1wJxu76RlnEyiY
	lMi4qH3UUBA9Dw1qbjQ4YD4HKCNw5eflJdbiID7/hh3RAR2IX3IkgK1C+K8EjzRPJzxiVJKn6o6LF
	XxFIQ3NydxGj5dSJPOuRvoumIzY+psrFCK7BvqsN/GVTS1Ze4OrjTlRxhiUnc3PXW7tMthgosz5cT
	jYipqed2VlRlwVVrH23Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go5aV-0002Ru-TO; Mon, 28 Jan 2019 12:00:27 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go5aS-0002RY-I7
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 12:00:26 +0000
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 28 Jan 2019 04:00:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,534,1539673200"; d="scan'208";a="138458007"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
 by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2019 04:00:19 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
 id D4C9A20609; Mon, 28 Jan 2019 14:00:18 +0200 (EET)
Date: Mon, 28 Jan 2019 14:00:18 +0200
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Vishal Sagar <vsagar@xilinx.com>
Subject: Re: [PATCH 1/2] media: dt-bindings: media: xilinx: Add Xilinx MIPI
 CSI-2 Rx Subsystem
Message-ID: <20190128120018.ztdxmcq4tizwwepn@paasikivi.fi.intel.com>
References: <1527620084-94864-1-git-send-email-vishal.sagar@xilinx.com>
 <1527620084-94864-2-git-send-email-vishal.sagar@xilinx.com>
 <20190108130457.syjuq7u7vep3km3h@paasikivi.fi.intel.com>
 <CY4PR02MB2709C346C4BEF853C48C32DCA7800@CY4PR02MB2709.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR02MB2709C346C4BEF853C48C32DCA7800@CY4PR02MB2709.namprd02.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_040024_669771_F4405BA8 
X-CRM114-Status: GOOD (  36.57  )
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

Hi Vishal,

On Mon, Jan 14, 2019 at 09:47:41AM +0000, Vishal Sagar wrote:
> Hi Sakari,
> 
> Thanks for reviewing this. 
> 
> > -----Original Message-----
> > From: Sakari Ailus [mailto:sakari.ailus@linux.intel.com]
> > Sent: Tuesday, January 08, 2019 6:35 PM
> > To: Vishal Sagar <vishal.sagar@xilinx.com>
> > Cc: Hyun Kwon <hyunk@xilinx.com>; laurent.pinchart@ideasonboard.com;
> > Michal Simek <michals@xilinx.com>; linux-media@vger.kernel.org;
> > devicetree@vger.kernel.org; hans.verkuil@cisco.com; mchehab@kernel.org;
> > robh+dt@kernel.org; mark.rutland@arm.com; Dinesh Kumar
> > <dineshk@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/2] media: dt-bindings: media: xilinx: Add Xilinx MIPI CSI-2
> > Rx Subsystem
> > 
> > EXTERNAL EMAIL
> > 
> > Hi Vishal,
> > 
> > The patchset hard escaped me somehow earlier and your reply to Rob made me
> > notice it again. Thanks. :-)
> > 
> > On Wed, May 30, 2018 at 12:24:43AM +0530, Vishal Sagar wrote:
> > > Add bindings documentation for Xilinx MIPI CSI-2 Rx Subsystem.
> > >
> > > The Xilinx MIPI CSI-2 Rx Subsystem consists of a DPHY, CSI-2 Rx, an
> > > optional I2C controller and an optional Video Format Bridge (VFB). The
> > > active lanes can be configured at run time if enabled in the IP. The
> > > DPHY register interface may also be enabled.
> > >
> > > Signed-off-by: Vishal Sagar <vishal.sagar@xilinx.com>
> > > ---
> > >  .../bindings/media/xilinx/xlnx,csi2rxss.txt        | 117
> > +++++++++++++++++++++
> > >  1 file changed, 117 insertions(+)
> > >  create mode 100644
> > Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> > b/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> > > new file mode 100644
> > > index 0000000..31ed721
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> > > @@ -0,0 +1,117 @@
> > > +
> > 
> > Extra newline.
> > 
> 
> Will remove it in next version. 
> 
> > > +Xilinx MIPI CSI2 Receiver Subsystem Device Tree Bindings
> > > +--------------------------------------------------------
> > > +
> > > +The Xilinx MIPI CSI2 Receiver Subsystem is used to capture MIPI CSI2 traffic
> > > +from compliant camera sensors and send the output as AXI4 Stream video
> > data
> > > +for image processing.
> > > +
> > > +The subsystem consists of a MIPI DPHY in slave mode which captures the
> > > +data packets. This is passed along the MIPI CSI2 Rx IP which extracts the
> > > +packet data. This data is taken in by the Video Format Bridge (VFB),
> > > +if selected, and converted into AXI4 Stream video data at selected
> > > +pixels per clock as per AXI4-Stream Video IP and System Design UG934.
> > > +
> > > +For more details, please refer to PG232 MIPI CSI-2 Receiver Subsystem.
> > >
> > +https://www.xilinx.com/support/documentation/ip_documentation/mipi_csi
> > 2_rx_subsystem/v3_0/pg232-mipi-csi2-rx.pdf
> > > +
> > > +Required properties:
> > > +
> > > +- compatible: Must contain "xlnx,mipi-csi2-rx-subsystem-2.0" or
> > > +  "xlnx,mipi-csi2-rx-subsystem-3.0"
> > > +
> > > +- reg: Physical base address and length of the registers set for the device.
> > > +
> > > +- interrupt-parent: specifies the phandle to the parent interrupt controller
> > > +
> > > +- interrupts: Property with a value describing the interrupt number.
> > > +
> > > +- xlnx,max-lanes: Maximum active lanes in the design.
> > > +
> > > +- xlnx,vc: Virtual Channel, specifies virtual channel number to be filtered.
> > > +  If this is 4 then all virtual channels are allowed.
> > 
> > This seems like something a driver should configure, based on the
> > configuration of the connected device.
> > 
> 
> The filtering of the Virtual channels is property of the hardware IP and is fixed in design. 
> This is not software controlled.

So... you have different IP blocks between which (one of) the difference(s)
is the virtual channel?

> 
> > > +
> > > +- xlnx,csi-pxl-format: This denotes the CSI Data type selected in hw design.
> > > +  Packets other than this data type (except for RAW8 and User defined data
> > > +  types) will be filtered out. Possible values are RAW6, RAW7, RAW8, RAW10,
> > > +  RAW12, RAW14, RGB444, RGB555, RGB565, RGB666, RGB888 and
> > YUV4228bit.
> > 
> > This should be configured at runtime instead through V4L2 sub-device
> > interface; it's not a property of the hardware.
> >
> 
> This too is a property of the hardware IP and is fixed to one data type
> during design to reduce gate count. So for e.g. if RGB888 is selected
> during design, then the hardware will only pass across RGB888 packet data
> to output. (RAW8 packets are also allowed to pass through for all data
> types selected) This is used in the driver to determine the media bus
> format of the connected pads.

If I understand this correctly, RAW8 and user defined data types will
always pass through, plus the other data types listed here. Is that right?

> 
> > > +
> > > +- xlnx,axis-tdata-width: AXI Stream width, This denotes the AXI Stream width.
> > > +  It depends on Data type chosen, Video Format Bridge enabled/disabled and
> > > +  pixels per clock. If VFB is disabled then its value is either 0x20 (32 bit)
> > > +  or 0x40(64 bit) width.
> > > +
> > > +- xlnx,video-format, xlnx,video-width: Video format and width, as defined in
> > > +  video.txt.
> > 
> > Ditto.
> > 
> Again these are fixed values and can't be changed at run time. 
> These are used to determine the media bus format.

What kind of values can the xlnx,video-format property have? How about
xlnx.video-width? Where can video.txt be found?

> 
> > > +
> > > +- port: Video port, using the DT bindings defined in ../video-interfaces.txt.
> > > +  The CSI 2 Rx Subsystem has a two ports, one input port for connecting to
> > > +  camera sensor and other is output port.
> > > +
> > > +- data-lanes: The number of data lanes through which CSI2 Rx Subsystem is
> > > +  connected to the camera sensor as per video-interfaces.txt
> > 
> > This is somewhat different from the documentation in video-interfaces.txt.
> > Could you align the two? I don't think there's a need to document standard
> > properties in device binding files elaborately; rather just the hardware
> > specific bits.
> > 
> 
> Agree. In this current IP there is no way to re-order the lanes which are set at design time.
> So physical and logical lanes are at same index. This could only be used to determine how many lanes are allowed to be programmed.
> For e.g. if design has set the number of lanes as 4 and xlnx,en-active-lanes is present, then the number of lanes 
> can be set from 1 to 4.

Ack.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
