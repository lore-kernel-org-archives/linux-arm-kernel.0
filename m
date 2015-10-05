From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Oct 2015 09:02:25 -0700
Subject: [RFC/PATCH 03/11] arm: omap2: timer: remove __omap_gptimer_init()
In-Reply-To: <20151005152454.GC18784@saruman.tx.rr.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <1443559446-26969-4-git-send-email-balbi@ti.com>
 <20151005110144.GW23801@atomide.com>
 <20151005152454.GC18784@saruman.tx.rr.com>
Message-ID: <20151005160224.GC23801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [151005 08:29]:
> On Mon, Oct 05, 2015 at 04:01:45AM -0700, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [150929 13:48]:
> > > since now we can reuse __omap_sync32k_timer_init()
> > > for OMAP3-like devices, we can safely remove
> > > __omap_gptimer_init().
> > 
> > There are tons of boards out there that need to use the
> > high frequency ocillator source with gptimer because of the
> > beagleboard B4 and earlier issue #7. So we need to provide
> > both options for the boards. Using the high frequency
> > oscillator source blocks deeper idle states in hardware
> > so those devices are usable.
> 
> have a closer look, that hasn't changed

Oh right, you added the argument in the previous patch.
Maybe update the description a bit to make that clear?
I understood that we can only use the sync32k source now..

The __omap_sync32k_timer_init should not be called
"sync32k" as that's TRM name for the always-on counter :)

Regards,

Tony
