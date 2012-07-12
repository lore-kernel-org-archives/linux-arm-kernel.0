From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 12 Jul 2012 09:14:49 +0800
Subject: [PATCH v6 1/7] ARM: imx6q: correct device name of usbphy and usb
 controller clock export
In-Reply-To: <20120712010332.GA6971@S2101-09.ap.freescale.net>
References: <1342006425-21008-1-git-send-email-richard.zhao@freescale.com>
 <1342006425-21008-2-git-send-email-richard.zhao@freescale.com>
 <20120712010332.GA6971@S2101-09.ap.freescale.net>
Message-ID: <20120712011449.GB21635@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 09:03:34AM +0800, Shawn Guo wrote:
> It seems that the patch subject does not match the content.
The name correct is fixed by your patch:
commit 1d818efd2949b5874eaf2531585e1f0735a7db91
Author: Shawn Guo <shawn.guo@linaro.org>
Date:   Tue Jun 5 15:16:42 2012 +0800

    ARM: imx6q: remove unneeded clkdev lookups
    
    There are a number of clkdev lookups left over from commit b0286f2
    (ARM: imx6q: prepare and enable init on clks directly instead of
    clk_get first), remove them since they are not needed now.
    
    Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

I'll correct the title.

Thanks
Richard
> 
> Regards,
> Shawn
> 
> On Wed, Jul 11, 2012 at 07:33:39PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  arch/arm/mach-imx/clk-imx6q.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> > index cabbbb7..3f5b9d6 100644
> > --- a/arch/arm/mach-imx/clk-imx6q.c
> > +++ b/arch/arm/mach-imx/clk-imx6q.c
> > @@ -398,6 +398,10 @@ int __init mx6q_clocks_init(void)
> >  	clk_register_clkdev(clk[gpmi_bch], "gpmi_bch", "112000.gpmi-nand");
> >  	clk_register_clkdev(clk[gpmi_apb], "gpmi_apb", "112000.gpmi-nand");
> >  	clk_register_clkdev(clk[gpmi_io], "gpmi_io", "112000.gpmi-nand");
> > +	clk_register_clkdev(clk[usboh3], NULL, "2184000.usb");
> > +	clk_register_clkdev(clk[usboh3], NULL, "2184200.usb");
> > +	clk_register_clkdev(clk[usboh3], NULL, "2184400.usb");
> > +	clk_register_clkdev(clk[usboh3], NULL, "2184600.usb");
> >  	clk_register_clkdev(clk[uart_serial], "per", "2020000.serial");
> >  	clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.serial");
> >  	clk_register_clkdev(clk[uart_serial], "per", "21e8000.serial");
> > -- 
> > 1.7.9.5
> > 
> > 
