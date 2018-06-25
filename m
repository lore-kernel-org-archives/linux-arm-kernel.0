From: toshi.kani@hpe.com (Kani, Toshi)
Date: Mon, 25 Jun 2018 14:56:26 +0000
Subject: [PATCH v3 0/3] fix free pmd/pte page handlings on x86
In-Reply-To: <alpine.DEB.2.21.1806241516410.8650@nanos.tec.linutronix.de>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
 <alpine.DEB.2.21.1806241516410.8650@nanos.tec.linutronix.de>
Message-ID: <1529938470.14039.134.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2018-06-24 at 15:19 +0200, Thomas Gleixner wrote:
> On Wed, 16 May 2018, Toshi Kani wrote:
> 
> > This series fixes two issues in the x86 ioremap free page handlings
> > for pud/pmd mappings.
> > 
> > Patch 01 fixes BUG_ON on x86-PAE reported by Joerg.  It disables
> > the free page handling on x86-PAE.
> > 
> > Patch 02-03 fixes a possible issue with speculation which can cause
> > stale page-directory cache.
> >  - Patch 02 is from Chintan's v9 01/04 patch [1], which adds a new arg
> >    'addr', with my merge change to patch 01.
> >  - Patch 03 adds a TLB purge (INVLPG) to purge page-structure caches
> >    that may be cached by speculation.  See the patch descriptions for
> >    more detal.
> 
> Toshi, Joerg, Michal!

Hi Thomas,

Thanks for checking. I was about to ping as well.

> I'm failing to find a conclusion of this discussion. Can we finally make
> some progress with that?

I have not heard from Joerg since I last replied to his comments to
Patch 3/3 -- I did my best to explain that there was no issue in the
single page allocation in pud_free_pmd_page().  From my perspective, the
 v3 series is good to go.

> Can someone give me a hint what to pick up urgently please?

I've confirmed that the v3 series still applies clearly to 4.18-r2
linus.git.

Patch 1/3, v3 
https://patchwork.kernel.org/patch/10405071/

Patch 2/3, v3-UPDATE
https://patchwork.kernel.org/patch/10407065/

nit: sorry, please fix my email address below.
- [toshi at hpe.com: merge changes, rewrite patch description]
+ [toshi.kani at hpe.com: merge changes, rewrite patch description]

Patch 3/3, v3
https://patchwork.kernel.org/patch/10405073/

Thanks,
-Toshi
