From: avinashphilip@ti.com (Philip, Avinash)
Date: Wed, 6 Feb 2013 11:38:57 +0000
Subject: [PATCH 1/4] arch: arm: gpmc: gpmc migration support
In-Reply-To: <20130201220510.GY22517@atomide.com>
References: <1358933176-12409-1-git-send-email-avinashphilip@ti.com>
 <1358933176-12409-2-git-send-email-avinashphilip@ti.com>
 <20130201220510.GY22517@atomide.com>
Message-ID: <518397C60809E147AF5323E0420B992E3EA6E6A3@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 02, 2013 at 03:35:10, Tony Lindgren wrote:
> * Philip Avinash <avinashphilip@ti.com> [130123 01:28]:
> > With recent GPMC driver conversion, usage of gpmc_save/restore_context
> > can done from gpmc driver itself. Hence removes the usage from pm34xx.c.
> > Also removes the conditional compilation primitives ARCH_OMAP3 for
> > gpmc_save/restore_context.
> 
> Hmm I think this will break GPMC for deeper idle modes. Note that we
> need to save and restore the context every time hitting off-idle, not
> just for suspend and resume. Or am I missing something here?

I understand dependency on idle modes. So I will send a second version
with this patch eliminated so that user initiated suspend/resume work
for am335x platforms.

Thanks
Avinash

> 
> Regards,
> 
> Tony
> 
