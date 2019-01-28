Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD855C282CD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:17:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A622214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 11:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NbLRs6nV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QNALy56T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A622214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PH+TF7oC7KMJUZqGuwxMkvfT+JQqX60FotB5UdzzmTM=; b=NbLRs6nVCMIBGB
	/j5JrWopQ8As0tav+r+VGbL41zo4u1YMpLEdUzQUMM1YhguvEwPxqYrS9sZN5mtxA0fvyFUEd+Uln
	ba7G+TIEDeC1SDBcINGm1+cBN/G3FNpmTsVEgCSyVoNEwH0+r3F48cH1B1ywf5Bn+ak0y4ARvh4AB
	IFro2Q22TCY4NvWXV1hMqIqBVP5ohRJ0B8NavMz0p8ld9g5VTi32o3Hxr0o507Nl09+0YDgb/xJPM
	TgNEdfnH/v11yQJv0Zux075GuruAuFxzTJWzQWRWJr9SMM+0sZOAyERhxcVlhBqrNvCO/wh05Vu6B
	69uDqfQ3+WM4zvzSCH7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go4us-00015i-6i; Mon, 28 Jan 2019 11:17:26 +0000
Received: from mail-co1nam03on0615.outbound.protection.outlook.com
 ([2a01:111:f400:fe48::615]
 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go4uZ-0000qn-2I
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 11:17:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q558L/feE83xrQAW6A3OVrnOLeE/HhFH2X3FJAunfKs=;
 b=QNALy56TBRXTXDuefY0B7WQjx7z9dedd9k6JIUkNAarYrXW0DtBRmSzjNRQ55cNnHLiiPJp4K0piQLDTYSZ2s5+horG8av3W9HudeexBOkPgF289+PPX+pnD4ecF2B1NVi1hYW7XCFwQkigRgqd9Q9t+MUm73Ux2ott1bZ7BSZA=
Received: from CY4PR02MB2709.namprd02.prod.outlook.com (10.175.59.19) by
 CY4PR02MB2423.namprd02.prod.outlook.com (10.173.38.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Mon, 28 Jan 2019 11:16:55 +0000
Received: from CY4PR02MB2709.namprd02.prod.outlook.com
 ([fe80::c41a:f0ef:3b4e:6903]) by CY4PR02MB2709.namprd02.prod.outlook.com
 ([fe80::c41a:f0ef:3b4e:6903%3]) with mapi id 15.20.1558.023; Mon, 28 Jan 2019
 11:16:55 +0000
From: Vishal Sagar <vsagar@xilinx.com>
To: Hyun Kwon <hyunk@xilinx.com>, Vishal Sagar <vishal.sagar@xilinx.com>
Subject: RE: [PATCH v2 1/2] media: dt-bindings: media: xilinx: Add Xilinx MIPI
 CSI-2 Rx Subsystem
Thread-Topic: [PATCH v2 1/2] media: dt-bindings: media: xilinx: Add Xilinx
 MIPI CSI-2 Rx Subsystem
Thread-Index: AQHUtNbLyB/3OqWzKESYx7XdyxEw86XA0CIAgANy6DA=
Date: Mon, 28 Jan 2019 11:16:55 +0000
Message-ID: <CY4PR02MB2709C078D872F2C1ABF82DF2A7960@CY4PR02MB2709.namprd02.prod.outlook.com>
References: <1548438777-11203-1-git-send-email-vishal.sagar@xilinx.com>
 <1548438777-11203-2-git-send-email-vishal.sagar@xilinx.com>
 <20190126021446.GA2412@smtp.xilinx.com>
In-Reply-To: <20190126021446.GA2412@smtp.xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsagar@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; CY4PR02MB2423;
 6:VLER3dgndl04X+Op1QrOULPxdP4GR0LlX0BgP6zY6fXFbzCqiBLxhD5dVik251h+juKQTb2ps4SzFh3JcZlE63XeMPRsnw8+1sU1ymUUSZBcoOPRioc7C/QxqvvsKdewJOqrs8ND8GM9XF7ElcMGQoPKoD3VFwI5xMjnDFDUvg0P6O+TavGIzaY3AJ9WlDZeG2raiptKCTZ6v2OmZYatGfnJpTfXSM1C99dUZiXBNyRbE8LY+wQ+ycB2fe3IlJwnbeHCYNOF6oRhuCgv5FtyNWC67Z8GtngWB5/ycAn3FGVCQDoFontzqwLYpk4MX9lUxwqhWf5ZzWOgxOn5QtFF/eJCfbDEtB6oUlwxlXllfFRsOEKLipJsgrwjFlB8dCd0YnSCj+1fVyInGkkIddnIKas6bcEdSMrk7hQluznXr10m6qx/gUHBVIiJHOwFUlAECOkm6onTjcscv2l1/5kdYQ==;
 5:nmVasrKmQ9rdGQ0Sl1qsTA+EyN/2sLaECcUI4cCflGHEp0vocZCsv3THmu/n4ELP9lNCnGWHfH/KJkq/4e0ZrFIY+1fz2vUlYQyO08r0DhR5BYJXOq4TBNUF2dAmS9tmL8LCOMyLbDEnc08lLoLLGMdhoQtQcJii1J9u/05knaNW8CQc8uayZCmDW2FDINXK0kdgqjiNKJ0jFu098fhFkg==;
 7:dnNFJMHr6ilVeUxSFOoT7wbc5DdjiXM7srw1NSRNRcvrPYjrPE9MWZm7DEz90SI7I9jp9UKajJBRpfa2KBnSmNYbI4+oHq1f3i+YLCdjb/HWXuv5WNZ4yKZOjMqmz/gZpHUnj+qxM4HjTjnqvrleQg==
x-ms-office365-filtering-correlation-id: be48bb25-23c9-42ad-75e4-08d685121cda
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:CY4PR02MB2423; 
x-ms-traffictypediagnostic: CY4PR02MB2423:
x-microsoft-antispam-prvs: <CY4PR02MB242318CC91FAC1875403B985A7960@CY4PR02MB2423.namprd02.prod.outlook.com>
x-forefront-prvs: 0931CB1479
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(366004)(51914003)(13464003)(199004)(189003)(256004)(14444005)(14454004)(99286004)(66066001)(229853002)(71190400001)(71200400001)(446003)(6436002)(76176011)(476003)(7696005)(105586002)(11346002)(110136005)(54906003)(486006)(316002)(86362001)(97736004)(478600001)(81156014)(3846002)(6116002)(53936002)(55016002)(25786009)(8936002)(106356001)(4326008)(26005)(8676002)(2906002)(7416002)(6636002)(53546011)(68736007)(102836004)(6246003)(6506007)(74316002)(107886003)(33656002)(9686003)(305945005)(7736002)(81166006)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR02MB2423;
 H:CY4PR02MB2709.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fAs8qugsfXb0tj38OUhEx+yT+ZrthIf83BfMSj2QwuhBr/+o8S8paTkNje2RldXImd9PKL2dgmp/XzQkWxxYsuxKC2OT7qazX+3pUXJQYotbwxtC+05YbdFjTjalC0FXW5yV2pjWia1n2z2nGgULq8cK2LkevW6JRFc1M/NKmbBKCMMcCnDHUqD2EX7OlN4wbu9YHB78rp90cqTNVoNQ9id6IDcIuOolyBHbiOHIWTNMqcc6t7tjunwYS5DvQ7PvQg5ptvn42zDAMeH9XEVco4RmtQh8iPz2Z78AJ4H9gpzG4dsuAcBO1IIXgdIbVtQ13h28qttK9J5jvXhbo1/DxroIrHC0isOxSxcOL7PlAACjay6MXagTvsIuRbasS9OPIhEVlO+VWIHEaSVFYhYSftLB5i2Z+NcDFHWztbOW5bY=
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be48bb25-23c9-42ad-75e4-08d685121cda
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2019 11:16:55.8607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2423
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_031707_114410_C2A5708A 
X-CRM114-Status: GOOD (  24.65  )
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
 Sandip Kothari <sandipk@xilinx.com>,
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

Thanks for the review. 

> -----Original Message-----
> From: Hyun Kwon [mailto:hyun.kwon@xilinx.com]
> Sent: Saturday, January 26, 2019 7:45 AM
> To: Vishal Sagar <vishal.sagar@xilinx.com>
> Cc: Hyun Kwon <hyunk@xilinx.com>; laurent.pinchart@ideasonboard.com;
> mchehab@kernel.org; robh+dt@kernel.org; mark.rutland@arm.com; Michal
> Simek <michals@xilinx.com>; linux-media@vger.kernel.org;
> devicetree@vger.kernel.org; sakari.ailus@linux.intel.com;
> hans.verkuil@cisco.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Dinesh Kumar <dineshk@xilinx.com>; Sandip Kothari
> <sandipk@xilinx.com>
> Subject: Re: [PATCH v2 1/2] media: dt-bindings: media: xilinx: Add Xilinx MIPI
> CSI-2 Rx Subsystem
> 
> Hi Vishal,
> 
> Thanks for the patch.
> 
> On Fri, 2019-01-25 at 09:52:56 -0800, Vishal Sagar wrote:
> > Add bindings documentation for Xilinx MIPI CSI-2 Rx Subsystem.
> >
> > The Xilinx MIPI CSI-2 Rx Subsystem consists of a CSI-2 Rx controller, a
> > DPHY in Rx mode, an optional I2C controller and a Video Format Bridge.
> >
> > Signed-off-by: Vishal Sagar <vishal.sagar@xilinx.com>
> > ---
> > v2
> > - updated the compatible string to latest version supported
> > - removed DPHY related parameters
> > - added CSI v2.0 related property (including VCX for supporting upto 16
> >   virtual channels).
> > - modified csi-pxl-format from string to unsigned int type where the value
> >   is as per the CSI specification
> > - Defined port 0 and port 1 as sink and source ports.
> > - Removed max-lanes property as suggested by Rob and Sakari
> >
> >  .../bindings/media/xilinx/xlnx,csi2rxss.txt        | 105
> +++++++++++++++++++++
> >  1 file changed, 105 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> >
> > diff --git a/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> b/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> > new file mode 100644
> > index 0000000..98781cf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/xilinx/xlnx,csi2rxss.txt
> > @@ -0,0 +1,105 @@
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
> > +packet data. The Video Format Bridge (VFB) converts this data to AXI4
> Stream
> > +video data.
> > +
> > +For more details, please refer to PG232 Xilinx MIPI CSI-2 Receiver Subsystem.
> > +
> > +Required properties:
> > +--------------------
> > +- compatible: Must contain "xlnx,mipi-csi2-rx-subsystem-4.0".
> > +- reg: Physical base address and length of the registers set for the device.
> > +- interrupt-parent: specifies the phandle to the parent interrupt controller
> > +- interrupts: Property with a value describing the interrupt number.
> > +- clocks: List of phandles to AXI Lite, Video and 200 MHz DPHY clocks.
> > +- clock-names: Must contain "lite_aclk", "video_aclk" and "dphy_clk_200M"
> in
> > +  the same order as clocks listed in clocks property.
> > +- xlnx,csi-pxl-format: This denotes the CSI Data type selected in hw design.
> > +  Packets other than this data type (except for RAW8 and User defined data
> > +  types) will be filtered out. Possible values are as below -
> > +  0x1E - YUV4228B
> > +  0x1F - YUV42210B
> > +  0x20 - RGB444
> > +  0x21 - RGB555
> > +  0x22 - RGB565
> > +  0x23 - RGB666
> > +  0x24 - RGB888
> > +  0x28 - RAW6
> > +  0x29 - RAW7
> > +  0x2A - RAW8
> > +  0x2B - RAW10
> > +  0x2C - RAW12
> > +  0x2D - RAW14
> > +  0x2E - RAW16
> > +  0x2F - RAW20
> > +- xlnx,vfb: This is present when Video Format Bridge is enabled.
> 
> Isn't this optional as well?

Ok this will be updated in next revision. 
When this property is not present, the driver probe will fail as the output of the IP will not match the media bus formats.

> 
> > +
> > +Optional properties:
> > +--------------------
> > +- xlnx,en-csi-v2-0: Present if CSI v2 is enabled in IP configuration.
> > +- xlnx,en-vcx: When present, there are maximum 16 virtual channels, else
> > +  only 4. This is present only if xlnx,en-csi-v2-0 is present.
> > +- xlnx,en-active-lanes: Enable Active lanes configuration in Protocol
> > +  Configuration Register.
> > +- xlnx,cfa-pattern: This goes in the sink port to indicate bayer pattern.
> > +  Valid values are "bggr", "rggb", "gbrg" and "grbg".
> > +
> > +Ports
> > +-----
> > +The device node shall contain two 'port' child nodes as defined in
> > +Documentation/devicetree/bindings/media/video-interfaces.txt.
> > +
> > +The port@0 is sink port and shall connect to CSI2 source like camera.
> > +It must have the data-lanes property. It may have the xlnx,cfa-pattern
> > +property to indicate bayer pattern of source.
> 
> These two properties better be spelled out properly. Maybe better to mention
> the data-lanes is from video-interfaces.txt.

Ok. I will document each port with its properties under a Ports section
And send it across in the next revision. 

Regards
Vishal Sagar


> 
> Thanks,
> -hyun
> 
> > +
> > +The port@1 is source port could be connected to any video processing IP
> > +which can work with AXI4 Stream data.
> > +
> > +Both ports must have remote-endpoints.
> > +
> > +Example:
> > +
> > +	csiss_1: csiss@a0020000 {
> > +		compatible = "xlnx,mipi-csi2-rx-subsystem-4.0";
> > +		reg = <0x0 0xa0020000 0x0 0x10000>;
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <0 95 4>;
> > +		xlnx,csi-pxl-format = <0x2a>;
> > +		xlnx,vfb;
> > +		xlnx,en-active-lanes;
> > +		xlnx,en-csi-v2-0;
> > +		xlnx,en-vcx;
> > +		clock-names = "lite_aclk", "dphy_clk_200M", "video_aclk";
> > +		clocks = <&misc_clk_0>, <&misc_clk_1>, <&misc_clk_2>;
> > +
> > +		ports {
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port@0 {
> > +				/* Sink port */
> > +				reg = <0>;
> > +				xlnx,cfa-pattern = "bggr"
> > +				csiss_in: endpoint {
> > +					data-lanes = <1 2 3 4>;
> > +					/* MIPI CSI2 Camera handle */
> > +					remote-endpoint = <&camera_out>;
> > +				};
> > +			};
> > +			port@1 {
> > +				/* Source port */
> > +				reg = <1>;
> > +				csiss_out: endpoint {
> > +					remote-endpoint = <&vproc_in>;
> > +				};
> > +			};
> > +		};
> > +	};
> > --
> > 2.7.4
> >
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
