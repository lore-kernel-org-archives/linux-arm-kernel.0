From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Wed, 5 Mar 2014 07:04:21 +0000
Subject: [PATCH v5] can: xilinx CAN controller support.
In-Reply-To: <5316CB29.7040200@hartkopp.net>
References: <5254bfec-c6fd-4681-a34d-706d51e60fbb@VA3EHSMHS004.ehs.local>
 <1b9f22ac-4dde-4ecc-885a-3d8081157081@AM1EHSMHS012.ehs.local>
 <5316CB29.7040200@hartkopp.net>
Message-ID: <c6cf1c12-8e7b-4f5e-a495-0f23c04ddc5d@TX2EHSMHS013.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oliver,

> -----Original Message-----
> From: Oliver Hartkopp [mailto:socketcan at hartkopp.net]
> Sent: Wednesday, March 05, 2014 12:29 PM
> To: Appana Durga Kedareswara Rao
> Cc: Soren Brinkmann; wg at grandegger.com; mkl at pengutronix.de; Michal
> Simek; grant.likely at linaro.org; robh+dt at kernel.org; linux-
> can at vger.kernel.org; netdev at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; Appana Durga Kedareswara Rao
> Subject: Re: [PATCH v5] can: xilinx CAN controller support.
>
>
>
> On 05.03.2014 00:51, S?ren Brinkmann wrote:
> > Hi Kedar,
> >
> > On Tue, 2014-03-04 at 06:50PM +0530, Kedareswara rao Appana wrote:
> >> This patch adds xilinx CAN controller support.
> >> This driver supports both ZYNQ CANPS and Soft IP AXI CAN controller.
> >>
> > [...]
> >> diff --git a/Documentation/devicetree/bindings/net/can/xilinx_can.txt
> >> b/Documentation/devicetree/bindings/net/can/xilinx_can.txt
> >> new file mode 100644
> >> index 0000000..0e57103
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/net/can/xilinx_can.txt
> >> @@ -0,0 +1,45 @@
> >> +Xilinx Axi CAN/Zynq CANPS controller Device Tree Bindings
> >> +---------------------------------------------------------
> >> +
> >> +Required properties:
> >> +- compatible              : Should be "xlnx,zynq-can-1.00.a" for Zynq
> CAN
> >> +                    controllers and "xlnx,axi-can-1.00.a" for Axi CAN
> >> +                    controllers.
> >> +- reg                     : Physical base address and size of the Axi
> CAN/Zynq
> >> +                    CANPS registers map.
> >> +- interrupts              : Property with a value describing the interrupt
> >> +                    number.
> >> +- interrupt-parent        : Must be core interrupt controller
> >> +- clock-names             : List of input clock names - "ref_clk",
> "aper_clk"
> >
> > Let's reconsider these names. These are rather Zynq specific names.
> > Does the IP documentation use these as well? The names should match
> > the naming used for the IP, rather than the SOC. Is this the correct data
> sheet:
> >
> http://www.xilinx.com/support/documentation/ip_documentation/axi_can
> /v
> > 1_03_a/ds791_axi_can.pdf ? According to that the names should rather
> > be 's_axi_aclk' and 'can_clk', IMHO.
> >
> >     S?ren
> >
>
> And when renaming stuff anyway:
>
> +
> +#define DRIVER_NAME  "XILINX_CAN"
> +
>
> should be changed to

Ok Will do

Regards,
Kedar.

>
> +
> +#define DRIVER_NAME  "xilinx_can"
> +
>
> Regards,
> Oliver
>



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
