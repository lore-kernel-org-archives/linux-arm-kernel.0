From: jonmason@broadcom.com (Jon Mason)
Date: Wed, 14 Oct 2015 11:44:10 -0400
Subject: [RFC 4/5] clk: iproc: define Broadcom NS2 iProc clock binding
In-Reply-To: <561D84B4.4000002@broadcom.com>
References: <1444771347-11382-1-git-send-email-jonmason@broadcom.com>
 <1444771347-11382-5-git-send-email-jonmason@broadcom.com>
 <561D84B4.4000002@broadcom.com>
Message-ID: <20151014154410.GF15160@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 03:24:52PM -0700, Ray Jui wrote:
> Same as this patch. I thought device tree binding document should go
> with the clock driver changes.
> 
> Strictly speaking, device tree binding document should always go before
> the driver changes. In the binding document the DT interface is defined,
> then changes are implemented in the driver.

I split them off this way due to the clk maintainer not wanting to
pull in any device tree changes.  Since the documentation is for the
device tree enties, it makes logical sense to me that they be in the
same device tree series.  If Stephen will pull these in with the clk
changes, I am more than happy to have it done by him :)

Thanks,
Jon

> 
> Ray
> 
> On 10/13/2015 2:22 PM, Jon Mason wrote:
> > Document the device tree bindings for Broadcom Northstar 2 architecture
> > based clock controller
> > 
> > Signed-off-by: Jon Mason <jonmason@broadcom.com>
> > ---
> >  .../bindings/clock/brcm,iproc-clocks.txt           | 48 ++++++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
> > index b3c3e9d..ede65a5 100644
> > --- a/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
> > +++ b/Documentation/devicetree/bindings/clock/brcm,iproc-clocks.txt
> > @@ -160,3 +160,51 @@ Northstar Plus.  These clock IDs are defined in:
> >      pcie_phy	lcpll0		1	BCM_NSP_LCPLL0_PCIE_PHY_REF_CLK
> >      sdio	lcpll0		2	BCM_NSP_LCPLL0_SDIO_CLK
> >      ddr_phy	lcpll0		3	BCM_NSP_LCPLL0_DDR_PHY_CLK
> > +
> > +Northstar 2
> > +-----------
> > +PLL and leaf clock compatible strings for Northstar 2 are:
> > +    "brcm,ns2-genpll-scr"
> > +    "brcm,ns2-genpll-sw"
> > +    "brcm,ns2-lcpll-ddr"
> > +    "brcm,ns2-lcpll-ports"
> > +
> > +The following table defines the set of PLL/clock index and ID for Northstar 2.
> > +These clock IDs are defined in:
> > +    "include/dt-bindings/clock/bcm-ns2.h"
> > +
> > +    Clock	Source		Index	ID
> > +    ---		-----		-----	---------
> > +    crystal	N/A		N/A	N/A
> > +
> > +    genpll_scr	crystal		0	BCM_NS2_GENPLL_SCR
> > +    scr		genpll_scr	1	BCM_NS2_GENPLL_SCR_SCR_CLK
> > +    fs		genpll_scr	2	BCM_NS2_GENPLL_SCR_FS_CLK
> > +    audio_ref	genpll_scr	3	BCM_NS2_GENPLL_SCR_AUDIO_CLK
> > +    ch3_unused	genpll_scr	4	BCM_NS2_GENPLL_SCR_CH3_UNUSED
> > +    ch4_unused	genpll_scr	5	BCM_NS2_GENPLL_SCR_CH4_UNUSED
> > +    ch5_unused	genpll_scr	6	BCM_NS2_GENPLL_SCR_CH5_UNUSED
> > +
> > +    genpll_sw	crystal		0	BCM_NS2_GENPLL_SW
> > +    rpe		genpll_sw	1	BCM_NS2_GENPLL_SW_RPE_CLK
> > +    250		genpll_sw	2	BCM_NS2_GENPLL_SW_250_CLK
> > +    nic		genpll_sw	3	BCM_NS2_GENPLL_SW_NIC_CLK
> > +    chimp	genpll_sw	4	BCM_NS2_GENPLL_SW_CHIMP_CLK
> > +    port	genpll_sw	5	BCM_NS2_GENPLL_SW_PORT_CLK
> > +    sdio	genpll_sw	6	BCM_NS2_GENPLL_SW_SDIO_CLK
> > +
> > +    lcpll_ddr	crystal		0	BCM_NS2_LCPLL_DDR
> > +    pcie_sata_usb lcpll_ddr	1	BCM_NS2_LCPLL_DDR_PCIE_SATA_USB_CLK
> > +    ddr		lcpll_ddr	2	BCM_NS2_LCPLL_DDR_DDR_CLK
> > +    ch2_unused	lcpll_ddr	3	BCM_NS2_LCPLL_DDR_CH2_UNUSED
> > +    ch3_unused	lcpll_ddr	4	BCM_NS2_LCPLL_DDR_CH3_UNUSED
> > +    ch4_unused	lcpll_ddr	5	BCM_NS2_LCPLL_DDR_CH4_UNUSED
> > +    ch5_unused	lcpll_ddr	6	BCM_NS2_LCPLL_DDR_CH5_UNUSED
> > +
> > +    lcpll_ports	crystal		0	BCM_NS2_LCPLL_PORTS
> > +    wan		lcpll_ports	1	BCM_NS2_LCPLL_PORTS_WAN_CLK
> > +    rgmii	lcpll_ports	2	BCM_NS2_LCPLL_PORTS_RGMII_CLK
> > +    ch2_unused	lcpll_ports	3	BCM_NS2_LCPLL_PORTS_CH2_UNUSED
> > +    ch3_unused	lcpll_ports	4	BCM_NS2_LCPLL_PORTS_CH3_UNUSED
> > +    ch4_unused	lcpll_ports	5	BCM_NS2_LCPLL_PORTS_CH4_UNUSED
> > +    ch5_unused	lcpll_ports	6	BCM_NS2_LCPLL_PORTS_CH5_UNUSED
> > 
