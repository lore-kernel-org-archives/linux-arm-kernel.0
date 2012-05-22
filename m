From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 22 May 2012 13:01:06 +0800
Subject: [PATCH v2 11/12] ARM: mxs: clk_register_clkdev mx28 usb clocks
In-Reply-To: <20120522044846.GL8140@S2101-09.ap.freescale.net>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-12-git-send-email-richard.zhao@freescale.com>
 <20120522044846.GL8140@S2101-09.ap.freescale.net>
Message-ID: <20120522050105.GO6206@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 12:48:48PM +0800, Shawn Guo wrote:
> On Mon, May 21, 2012 at 05:23:56PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  drivers/clk/mxs/clk-imx28.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
> > index 2826a26..5330b27 100644
> > --- a/drivers/clk/mxs/clk-imx28.c
> > +++ b/drivers/clk/mxs/clk-imx28.c
> > @@ -328,6 +328,10 @@ int __init mx28_clocks_init(void)
> >  	clk_register_clkdevs(clks[fec], fec_lookups, ARRAY_SIZE(fec_lookups));
> >  	clk_register_clkdevs(clks[can0], can0_lookups, ARRAY_SIZE(can0_lookups));
> >  	clk_register_clkdevs(clks[can1], can1_lookups, ARRAY_SIZE(can1_lookups));
> > +	clk_register_clkdev(clks[usb0_pwr], NULL, "8007c000.usbphy");
> > +	clk_register_clkdev(clks[usb1_pwr], NULL, "8007e000.usbphy");
> > +	clk_register_clkdev(clks[usb0], NULL, "80080000.usbctrl");
> > +	clk_register_clkdev(clks[usb1], NULL, "80090000.usbctrl");
> >  
> You changed usb node name from "usbctrl" to "usb".  The clk lookup
> needs to be updated correspondingly.
Yes, I just noticed it too.

Thanks
Richard
> 
> -- 
> Regards,
> Shawn
> 
