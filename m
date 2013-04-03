From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 03 Apr 2013 11:16:37 +0900
Subject: [PATCH 0/2] These two patches to s3c_pm_arch_prepare_irqs() were
 part of the work
In-Reply-To: <24b401ce300f$5a767b40$0f6371c0$%kim@samsung.com>
References: <1363711900-25560-1-git-send-email-dianders@chromium.org>
 <24b401ce300f$5a767b40$0f6371c0$%kim@samsung.com>
Message-ID: <24b501ce3011$454d3c70$cfe7b550$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Doug Anderson wrote:
> >
> > to make suspend/resume reliable on the ARM Chromebook
> > (exynos5250-snow).
> >
> > A few more details:
> > - The first patch is not strictly needed but was a nice cleanup.  Our
> >   understanding was that EINT0 was originally turned on for exynos
> >   evt0 silicon and not needed for evt1.
> 
> Looks good to me, applied, thanks.
> 
> > - The second patch is more important and (also) more obvious.  The
> >   function was modifying the S5P_WAKEUP_MASK register and then
> >   clobbering its own modifications.
> >
> Applied with 1st one, BTW, do you want to send this for stable tree?
> 
One more note, just now I discussed Jaecheol Lee about the bit,
ENABLE_WAKEUP_SW, as the patch fixed, it should be cleared but used to be
set s3c_irqwake_intmask. Let me check again, then if any updates I'll let
you know.

Thanks.

- Kukjin
