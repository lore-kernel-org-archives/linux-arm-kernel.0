From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 24 Jun 2018 15:19:18 +0200 (CEST)
Subject: [PATCH v3 0/3] fix free pmd/pte page handlings on x86
In-Reply-To: <20180516233207.1580-1-toshi.kani@hpe.com>
References: <20180516233207.1580-1-toshi.kani@hpe.com>
Message-ID: <alpine.DEB.2.21.1806241516410.8650@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 May 2018, Toshi Kani wrote:

> This series fixes two issues in the x86 ioremap free page handlings
> for pud/pmd mappings.
> 
> Patch 01 fixes BUG_ON on x86-PAE reported by Joerg.  It disables
> the free page handling on x86-PAE.
> 
> Patch 02-03 fixes a possible issue with speculation which can cause
> stale page-directory cache.
>  - Patch 02 is from Chintan's v9 01/04 patch [1], which adds a new arg
>    'addr', with my merge change to patch 01.
>  - Patch 03 adds a TLB purge (INVLPG) to purge page-structure caches
>    that may be cached by speculation.  See the patch descriptions for
>    more detal.

Toshi, Joerg, Michal!

I'm failing to find a conclusion of this discussion. Can we finally make
some progress with that?

Can someone give me a hint what to pick up urgently please?

Thanks,

	tglx
