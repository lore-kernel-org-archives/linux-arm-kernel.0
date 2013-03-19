From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 19 Mar 2013 08:19:29 -0300
Subject: [PATCH v3 0/9] refactoring for mask_cache
In-Reply-To: <20130319110620.GO13280@titan.lakedaemon.net>
References: <1363277430-21325-1-git-send-email-holger.brunck@keymile.com>
 <1363615255-18200-1-git-send-email-gerlando.falauto@keymile.com>
 <20130319100352.GB2419@localhost>
 <20130319110620.GO13280@titan.lakedaemon.net>
Message-ID: <20130319111928.GB3137@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Tue, Mar 19, 2013 at 07:06:20AM -0400, Jason Cooper wrote:
> On Tue, Mar 19, 2013 at 07:03:53AM -0300, Ezequiel Garcia wrote:
> > On Mon, Mar 18, 2013 at 03:00:46PM +0100, Gerlando Falauto wrote:
> > > here is a patchset to address the issue found with Orion, in incremental
> > > stages as Thomas suggested.
> > > a) we introduce the new fields and pointer (though only the shared one is used)
> > > b) we convert all drivers to use it 
> > > c) we rename the field so to force the use of the per-ct pointer
> > > d) we add per-ct mask cache, provided the new flag 
> > >    IRQ_GC_SEPARATE_MASK_REGISTERS is enabled
> > > e) we enable the flag for orion-gpio and mvebu drivers
> > > 
> > > So even though I'm also providing changes for mvebu, I only
> > > tested the patch on a 3.0.40 kernel with the plat-orion/gpio.c driver.
> > 
> > Great job! Since this is a really old bug you're fixing I believe that the
> > patchset applies for stable as well as mainline.
> > 
> > According to Documentation/stable_kernel_rules.txt all you need to do
> > is add a 'Cc: stable at vger.kernel.org' tag in your sign-off area.
> > 
> > Stable people will take care of picking the patch when it hits
> > mainline. You should receive a mail notification about patches
> > being included in stable kernels.
> 
> Yes, and if you have an idea of when the regression was introduced,
> perhaps even which commit, that would be *extremely* helpful.
> Otherwise, the stable folks have to expend a lot of time tracking it
> down.
> 

Gerlando explains the problematic commit in the changelog of patch 8/9
of this series:

  enable handling of separate mask registers for Orion SoC GPIOs,
  fixing indeed the regression introduced by e59347a
  "arm: orion: Use generic irq chip".

@Gerlando, perhaps you should add this comment to the cover-letter?
After all, this fix is the whole point of the patchset.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
