From: horms@verge.net.au (Simon Horman)
Date: Tue, 23 Apr 2013 11:36:37 +0900
Subject: [PATCH] ARM: shmobile: lager: Add GPIO LEDs
In-Reply-To: <20130423011752.GF12017@verge.net.au>
References: <1366599990-31751-1-git-send-email-horms+renesas@verge.net.au>
 <51752C9A.2040508@cogentembedded.com>
 <20130423011752.GF12017@verge.net.au>
Message-ID: <20130423023636.GR12017@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 10:17:52AM +0900, Simon Horman wrote:
> On Mon, Apr 22, 2013 at 04:27:06PM +0400, Sergei Shtylyov wrote:
> > Hello.
> > 
> > On 22-04-2013 7:06, Simon Horman wrote:
> > 
> > >The board has 3 LEDs connected to GPIOs. Add a led-gpio device to
> > >support them.
> > 
> > >Based on "ARM: shmobile: marzen: Add GPIO LEDs" by Laurent Pinchart.
> > 
> > >Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > >---
> > >  arch/arm/mach-shmobile/board-lager.c | 37 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > 
> > >Tested on lager board.
> > >Based on the tag renesas-next-20130419 of my renesas tree.
> > 
> > >diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> > >index 6114edd..a8aa04f 100644
> > >--- a/arch/arm/mach-shmobile/board-lager.c
> > >+++ b/arch/arm/mach-shmobile/board-lager.c
> > [...]
> > >@@ -46,6 +82,7 @@ static void __init lager_add_standard_devices(void)
> > >  	r8a7790_pinmux_init();
> > >
> > >  	r8a7790_add_standard_devices();
> > >+	platform_add_devices(lager_devices, ARRAY_SIZE(lager_devices));
> > 
> >    I thought we shouldn't use platform_add_devices() anymore, being
> > close relative to platform_device_register()?
> 
> Thanks, as there is only one device I think this
> can be changed to use platform_device_register_resndata().
> I'll see about making it so.

On closer examination platform_device_register_data() seems more
appropriate.
