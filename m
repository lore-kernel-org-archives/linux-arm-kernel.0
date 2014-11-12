From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Nov 2014 09:33:08 +0900
Subject: [PATCH v2] ARM: shmobile: r8a7740 legacy: Add missing INTCA
 clock for irqpin module
In-Reply-To: <20141110004809.GB16836@verge.net.au>
References: <1415221174-29097-1-git-send-email-geert+renesas@glider.be>
 <20141110004809.GB16836@verge.net.au>
Message-ID: <20141112003307.GA30454@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 09:48:10AM +0900, Simon Horman wrote:
> On Wed, Nov 05, 2014 at 09:59:34PM +0100, Geert Uytterhoeven wrote:
> > This clock drives the irqpin controller modules.
> > Before, it was assumed enabled by the bootloader or reset state.
> > By making it available to the driver, we make sure it gets enabled when
> > needed, and allow it to be managed by system or runtime PM.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Thanks Geert,
> 
> I have queued this up after dropping the previous version.

Hi Geert,

As this appears to be a bug fix I would like to accompany this patch with
some text describing when the problem was introduced and what its effects
are. In short a rough guide to if it should be applied to -stable. To that
end I prepared the following which I would appreciate your feedback on.

* Add missing INTCA clock for irqpin module for r8a7740

  This problem appears to have been introduced when the r8a7740 started
  using the irqpin driver, a change made by 0b7d7820226016205 ("ARM:    
  shmobile: r8a7740: Migrate from INTC to GIC") in v3.9.
  It may well have existed in a different form before then.

  It is my understanding that the problem problem only manifests if either:
  * uboot does not start the clock: in practice it does      
  * The A4S pm domain is in use managed by system or runtime pm.
    I believe this may only occur since v3.18-rc2   
