From: tony@atomide.com (Tony Lindgren)
Date: Thu, 6 Sep 2012 14:17:26 -0700
Subject: [PATCH 5/5] omap-serial: Request pins using pinctrl framework
In-Reply-To: <20120906195605.GA32145@arwen.pp.htv.fi>
References: <20120906185615.1172.23588.stgit@muffinssi.local>
 <20120906185832.1172.31013.stgit@muffinssi.local>
 <20120906195605.GA32145@arwen.pp.htv.fi>
Message-ID: <20120906211725.GQ1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [120906 13:01]:
> Hi,
> 
> On Thu, Sep 06, 2012 at 11:58:32AM -0700, Tony Lindgren wrote:
> > Request pins using pinctrl framework. Only show a warning
> > on error as some boards set the pins in the bootloader
> > even if CONFIG_PINCTRL is enabled.
> > 
> > Cc: linux-serial at vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/plat-omap/include/plat/omap-serial.h |    1 +
> >  drivers/tty/serial/omap-serial.c              |   10 ++++++++++
> >  2 files changed, 11 insertions(+)
> > 
> > diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
> > index 1a52725..0f4de14 100644
> > --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> > +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> > @@ -106,6 +106,7 @@ struct uart_omap_port {
> >  	struct uart_port	port;
> >  	struct uart_omap_dma	uart_dma;
> >  	struct platform_device	*pdev;
> > +	struct pinctrl		*pins;
> 
> this won't apply to Greg's tty-next as I moved this structure to the C
> file :-s

Hmm the tty-next fails to build right now for omaps:

drivers/tty/serial/omap-serial.c: In function ?serial_omap_set_mctrl?:
drivers/tty/serial/omap-serial.c:514: error: ?struct uart_omap_port? has no member named ?DTR_gpio?

Maybe check how you want to fix that first? I can then update
my patch for tty-next.

Regards,

Tony
