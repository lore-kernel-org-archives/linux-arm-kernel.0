From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 5 Dec 2013 19:20:16 -0800
Subject: [PATCH 02/15] input: sh_keysc: Restrict non-COMPILE_TEST
 compilation
In-Reply-To: <20131128073636.GD24146@verge.net.au>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131128073636.GD24146@verge.net.au>
Message-ID: <20131206032016.GA16530@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 04:36:36PM +0900, Simon Horman wrote:
> On Wed, Nov 27, 2013 at 02:18:24AM +0100, Laurent Pinchart wrote:
> > Hardware supported by the driver is only found on SUPERH or
> > ARCH_SHMOBILE platforms. Restrict non-COMPILE_TEST compilation to them.
> > 
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: linux-input at vger.kernel.org
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>


Applied, thank you.

> 
> > ---
> >  drivers/input/keyboard/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> > index bb174c1..a673c9f 100644
> > --- a/drivers/input/keyboard/Kconfig
> > +++ b/drivers/input/keyboard/Kconfig
> > @@ -525,7 +525,7 @@ config KEYBOARD_SUNKBD
> >  
> >  config KEYBOARD_SH_KEYSC
> >  	tristate "SuperH KEYSC keypad support"
> > -	depends on SUPERH || ARM || COMPILE_TEST
> > +	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> >  	help
> >  	  Say Y here if you want to use a keypad attached to the KEYSC block
> >  	  on SuperH processors such as sh7722 and sh7343.
> > -- 
> > 1.8.3.2
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 

-- 
Dmitry
