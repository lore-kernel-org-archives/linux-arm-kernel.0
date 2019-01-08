Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F3C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:05:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750732087E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kfG0MEwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750732087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BgFtcngq9W4F0C9UopgnntX6FKx0kQQK+XBSS3uduO8=; b=kfG0MEwE/oh/Vb
	xjcu0jb7j8Fqa5giIZaywby13QlwDZrP/eRJLDh6+0GQ7FEeqdTEJMHDx1tjrFAVehe4czdfzKWQR
	VHcg7j51CPusLeyZ1GGQO1kMRL80X3WDMLqsHi7/Ynm5m4Uj3DaX285YOH6SlrJCTL+MPz9zS1WAm
	XPa1B+d1x1yG+a5SWt2u/qHkyq/vWG11amvHjkMs3mIooSPOpyAXbbs+haoELmgJwKPi+DWRXH6eT
	HIcPsrae/OksxU6F+QBLILDxPtBbzTysSUX3hSXsRfm84KizfZ1mUu/W/jR/HWCjaXSprErrkeQZa
	A/pTne56CrAXsuQEZPpg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggr4F-00052g-4I; Tue, 08 Jan 2019 13:05:15 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggr45-0003nb-Ex
 for linux-arm-kernel@lists.infradead.org; Tue, 08 Jan 2019 13:05:12 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Jan 2019 05:05:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,454,1539673200"; d="scan'208";a="132646411"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
 by fmsmga002.fm.intel.com with ESMTP; 08 Jan 2019 05:04:58 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
 id C377F20948; Tue,  8 Jan 2019 15:04:57 +0200 (EET)
Date: Tue, 8 Jan 2019 15:04:57 +0200
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Vishal Sagar <vishal.sagar@xilinx.com>
Subject: Re: [PATCH 1/2] media: dt-bindings: media: xilinx: Add Xilinx MIPI
 CSI-2 Rx Subsystem
Message-ID: <20190108130457.syjuq7u7vep3km3h@paasikivi.fi.intel.com>
References: <1527620084-94864-1-git-send-email-vishal.sagar@xilinx.com>
 <1527620084-94864-2-git-send-email-vishal.sagar@xilinx.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1527620084-94864-2-git-send-email-vishal.sagar@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_050505_612378_DC807DA6 
X-CRM114-Status: GOOD (  26.82  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, dineshk@xilinx.com,
 hyun.kwon@xilinx.com, michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com,
 mchehab@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Vishal,

The patchset hard escaped me somehow earlier and your reply to Rob made me
notice it again. Thanks. :-)

On Wed, May 30, 2018 at 12:24:43AM +0530, Vishal Sagar wrote:
> Add bindings documentation for Xilinx MIPI CSI-2 Rx Subsystem.
> 
> The Xilinx MIPI CSI-2 Rx Subsystem consists of a DPHY, CSI-2 Rx, an
> optional I2C controller and an optional Video Format Bridge (VFB). The
> active lanes can be configured at run time if enabled in the IP. The
> DPHY register interface may also be enabled.
> 
> Signed-off-by: Vishal Sagar <vishal.sagar@xilinx.com>
> ---
>  .../bindings/media/xilinx/xlnx,csi2rxss.txt        | 117 +++++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt b/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> new file mode 100644
> index 0000000..31ed721
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> @@ -0,0 +1,117 @@
> +

Extra newline.

> +Xilinx MIPI CSI2 Receiver Subsystem Device Tree Bindings
> +--------------------------------------------------------
> +
> +The Xilinx MIPI CSI2 Receiver Subsystem is used to capture MIPI CSI2 traffic
> +from compliant camera sensors and send the output as AXI4 Stream video data
> +for image processing.
> +
> +The subsystem consists of a MIPI DPHY in slave mode which captures the
> +data packets. This is passed along the MIPI CSI2 Rx IP which extracts the
> +packet data. This data is taken in by the Video Format Bridge (VFB),
> +if selected, and converted into AXI4 Stream video data at selected
> +pixels per clock as per AXI4-Stream Video IP and System Design UG934.
> +
> +For more details, please refer to PG232 MIPI CSI-2 Receiver Subsystem.
> +https://www.xilinx.com/support/documentation/ip_documentation/mipi_csi2_rx_subsystem/v3_0/pg232-mipi-csi2-rx.pdf
> +
> +Required properties:
> +
> +- compatible: Must contain "xlnx,mipi-csi2-rx-subsystem-2.0" or
> +  "xlnx,mipi-csi2-rx-subsystem-3.0"
> +
> +- reg: Physical base address and length of the registers set for the device.
> +
> +- interrupt-parent: specifies the phandle to the parent interrupt controller
> +
> +- interrupts: Property with a value describing the interrupt number.
> +
> +- xlnx,max-lanes: Maximum active lanes in the design.
> +
> +- xlnx,vc: Virtual Channel, specifies virtual channel number to be filtered.
> +  If this is 4 then all virtual channels are allowed.

This seems like something a driver should configure, based on the
configuration of the connected device.

> +
> +- xlnx,csi-pxl-format: This denotes the CSI Data type selected in hw design.
> +  Packets other than this data type (except for RAW8 and User defined data
> +  types) will be filtered out. Possible values are RAW6, RAW7, RAW8, RAW10,
> +  RAW12, RAW14, RGB444, RGB555, RGB565, RGB666, RGB888 and YUV4228bit.

This should be configured at runtime instead through V4L2 sub-device
interface; it's not a property of the hardware.

> +
> +- xlnx,axis-tdata-width: AXI Stream width, This denotes the AXI Stream width.
> +  It depends on Data type chosen, Video Format Bridge enabled/disabled and
> +  pixels per clock. If VFB is disabled then its value is either 0x20 (32 bit)
> +  or 0x40(64 bit) width.
> +
> +- xlnx,video-format, xlnx,video-width: Video format and width, as defined in
> +  video.txt.

Ditto.

> +
> +- port: Video port, using the DT bindings defined in ../video-interfaces.txt.
> +  The CSI 2 Rx Subsystem has a two ports, one input port for connecting to
> +  camera sensor and other is output port.
> +
> +- data-lanes: The number of data lanes through which CSI2 Rx Subsystem is
> +  connected to the camera sensor as per video-interfaces.txt

This is somewhat different from the documentation in video-interfaces.txt.
Could you align the two? I don't think there's a need to document standard
properties in device binding files elaborately; rather just the hardware
specific bits.

> +
> +Optional properties:
> +
> +- xlnx,en-active-lanes: Enable Active lanes configuration in Protocol
> +  Configuration Register.
> +
> +- xlnx,dphy-present: This is equivalent to whether DPHY register interface is
> +  enabled or not.
> +
> +- xlnx,iic-present: This shows whether subsystem's IIC is present or not. This
> +  affects the base address of the DPHY.
> +
> +- xlnx,vfb: Video Format Bridge, Denotes if Video Format Bridge is selected
> +  so that output is as per AXI stream documented in UG934.
> +
> +- xlnx,ppc: Pixels per clock, Number of pixels to be transferred per pixel
> +  clock. This is valid only if xlnx,vfb property is present.
> +
> +Example:
> +
> +       csiss_1: csiss@a0020000 {
> +               compatible = "xlnx,mipi-csi2-rx-subsystem-3.0";
> +               reg = <0x0 0xa0020000 0x0 0x20000>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 95 4>;
> +
> +               xlnx,max-lanes = <0x4>;
> +               xlnx,en-active-lanes;
> +               xlnx,dphy-present;
> +               xlnx,iic-present;
> +               xlnx,vc = <0x4>;
> +               xlnx,csi-pxl-format = "RAW8";
> +               xlnx,vfb;
> +               xlnx,ppc = <0x4>;
> +               xlnx,axis-tdata-width = <0x20>;
> +
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 {
> +                               reg = <0>;
> +
> +                               xlnx,video-format = <XVIP_VF_YUV_422>;
> +                               xlnx,video-width = <8>;
> +                               csiss_out: endpoint {
> +                                       remote-endpoint = <&vcap_csiss_in>;
> +                               };
> +                       };
> +                       port@1 {
> +                               reg = <1>;
> +
> +                               xlnx,video-format = <XVIP_VF_YUV_422>;
> +                               xlnx,video-width = <8>;
> +
> +                               csiss_in: endpoint {
> +                                       data-lanes = <1 2 3 4>;
> +                                       /* MIPI CSI2 Camera handle */
> +                                       remote-endpoint = <&vs2016_out>;
> +                               };
> +
> +                       };
> +
> +               };
> +       };
> --
> 2.7.4
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

Could you drop this from v2?

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
