From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 May 2013 16:02:55 +0100
Subject: [PATCH 19/63] dmaengine: ste_dma40: Separate Logical Global
 Interrupt Mask (GIM) unmasking
In-Reply-To: <CACRpkdZexk6a7yaWEzzOkihcHNGY_UQN3hYiz45LK1cuy0ob=g@mail.gmail.com>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-20-git-send-email-lee.jones@linaro.org>
 <CACRpkdZexk6a7yaWEzzOkihcHNGY_UQN3hYiz45LK1cuy0ob=g@mail.gmail.com>
Message-ID: <20130508150255.GJ3459@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 03 May 2013, Linus Walleij wrote:

> On Fri, May 3, 2013 at 4:32 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > During the initial setup of a logical channel, it is necessary to unmask
> > the GIM in order to receive generated terminal count and error interrupts.
> > We're separating out this required code so it will be possible to move
> > the remaining code in d40_phy_cfg(), which is mostly runtime configuration
> > into the runtime_config() routine.
> >
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: Dan Williams <djbw@fb.com>
> > Cc: Per Forlin <per.forlin@stericsson.com>
> > Cc: Rabin Vincent <rabin@rab.in>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> These review comments are only partially accounted for:
> http://marc.info/?l=linux-kernel&m=136688761708399&w=2
> 
> Please supply a short changelog in the next submission
> so I know what was changed and why some things were not
> changed and if you split out other changes to other patches
> etc etc.

All of the comments are accounted for. The is_log argument is actually
removed in patch 20, as it's still used to only run the code within
the clause if the channel is physical.

... and yes, the dmatest works perfectly on patch 19.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
