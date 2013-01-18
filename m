From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Jan 2013 19:54:08 +0200
Subject: [[PATCH v2]] OMAP: omap4-panda: add WiLink shared transport
 power functions
In-Reply-To: <20130118173635.GE15361@atomide.com>
References: <50F7CA82.4050509@ti.com> <20130117100510.GI10814@arwen.pp.htv.fi>
 <20130117100919.GJ10814@arwen.pp.htv.fi>
 <1358418917.6252.31.camel@cumari.coelho.fi>
 <50F7D535.6030205@ti.com> <20130117173131.GL14149@atomide.com>
 <1358445456.6252.64.camel@cumari.coelho.fi>
 <20130117231608.GP14149@atomide.com>
 <1358499533.6252.80.camel@cumari.coelho.fi>
 <20130118173635.GE15361@atomide.com>
Message-ID: <20130118175408.GC1035@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 18, 2013 at 09:36:35AM -0800, Tony Lindgren wrote:
> * Luciano Coelho <coelho@ti.com> [130118 01:03]:
> > On Thu, 2013-01-17 at 15:16 -0800, Tony Lindgren wrote:
> > > * Luciano Coelho <coelho@ti.com> [130117 10:04]:
> > > > But this patch is pretty small and simple, so why not include it to at
> > > > least fix the breakage in 3.7 and 3.8? Whether you take it or not now
> > > > won't make any difference in the 5k LOC in these kernel versions.
> > > 
> > > Well we are planning to drop the non-DT support for omap4 as soon as it's
> > > usable with DT. For omap4 we are only carrying SDP and panda support to
> > > make this transition easier. The only bindings missing AFAIK are wl12xx and
> > > USB.
> > 
> > In my view this is a regression and it should be fixed with as simple a
> > patch as possible.  The alternative to my solution is to revert the
> > patch that removed the enable/disable from the ti-st driver *and* fix
> > u-boot, because if it doesn't mux the UART2 pins properly (and it
> > doesn't) the shared transport still won't work.
> 
> Fixing the muxing here makes sense naturally as we cannot do that in the driver
> until we've flipped things over to use DT.
> 
> But I don't think we should fix the driver regression by adding more platform
> callbacks as we are getting rid of them anyways.

it's not adding more callbacks, solely implementing them as it should
have been done on Pavan's original patch.

> > > What's your estimate of having minimal wl12xx WLAN DT binding available?
> > 
> > To tell you the truth, I haven't even started looking into DT for wl12xx
> > myself.  So I have no idea when it will be ready.  Benoit has been
> > looking into it, but I don't know how far he is.
> 
> If it's going to take long we should just init the platform data for
> it temporarily even in the DT boot case until the binding is available.

which will boil down to having those platform_data callbacks to have it
at least functional. How will Luca test DT conversion if ti-st isn't
even functional ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130118/5dbd12a2/attachment-0001.sig>
