From: dinguyen@altera.com (Dinh Nguyen)
Date: Thu, 3 Oct 2013 10:12:01 -0500
Subject: [PATCH 0/4] SoCFPGA: dts cleanups and SoCkit support
In-Reply-To: <1380699333-558-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1380699333-558-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1380813121.7464.18.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-10-02 at 09:35 +0200, Steffen Trumtrar wrote:
> Hi!
> 
> This series includes some minor cleanups (indentation and clock labels) and
> reorders the socfpga dts hierarchy from
> 	socfpga.dtsi
> 	-> socfpga_$board.dts
> 	-> socfpga_$otherboard.dts
> to
> 	socfpga.dtsi
> 	-> socfpga_cyclone5.dtsi
> 	--> socfpga_cyclone5_$board.dts
> 	--> socfpga_cyclone5_$otherboard.dts
> 
> The Socfpga is a SoC with an FPGA on board. This FPGA does not have to be a
> Cyclone5.
> The current socfpga_cyclone5.dts is however not specific to a SoC with this
> combination, but describes one specific board: the Altera Cyclone5 Development Kit.
> Therefore, I propose moving the common stuff to socfpga_cyclone5.dtsi as long as
> it is as easy as now.
> 
> Finally, the series adds minimal support for the terasic SoCkit.
> 
> BTW: It seems there is no official maintainer(tree) for the socfpga dt stuff.
> So, I rebased onto next-20130927.

I've pretty much Acked this whole series, with the minor comment of a
baudrate change.

I think Rob had mentioned in a another patch(that since the patch
doesn't involve a binding change, it may not get too many comments), and
since this patch series is not making a binding change at all, comments
may not come, but we still need an Ack from a DTS binding maintainer
before the arm-soc maintainer(s) will take it.

Thanks,
Dinh
> Regards,
> Steffen
> 
> 
> Steffen Trumtrar (4):
>   ARM: socfpga: dts: Move common nodes to cyclone5 dtsi
>   ARM: socfpga: dts: Add support for terasic SoCkit
>   ARM: socfpga: dts: cleanup indentation
>   ARM: socfpga: dts: fix s2f_* clock name
> 
>  arch/arm/boot/dts/Makefile                         |   3 +-
>  arch/arm/boot/dts/socfpga.dtsi                     | 296 ++++++++++-----------
>  ...{socfpga_cyclone5.dts => socfpga_cyclone5.dtsi} |  20 --
>  arch/arm/boot/dts/socfpga_cyclone5_socdk.dts       |  40 +++
>  arch/arm/boot/dts/socfpga_cyclone5_sockit.dts      |  37 +++
>  5 files changed, 227 insertions(+), 169 deletions(-)
>  rename arch/arm/boot/dts/{socfpga_cyclone5.dts => socfpga_cyclone5.dtsi} (78%)
>  create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
>  create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
> 
