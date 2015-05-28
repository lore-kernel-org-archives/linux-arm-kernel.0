From: notasas@gmail.com (Grazvydas Ignotas)
Date: Thu, 28 May 2015 14:43:30 +0300
Subject: [RFC] Fix omap3 booting with thumb2 compiled kernel
In-Reply-To: <20150527225553.GC30984@atomide.com>
References: <20150527215545.GA30984@atomide.com>
 <7h7frtmzoh.fsf@deeprootsystems.com>
 <20150527225553.GC30984@atomide.com>
Message-ID: <CANOLnOMYBFAr_t_tOs8ifo=ngtCrpyogtf_7hBDc4rmbC_-BQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 1:55 AM, Tony Lindgren <tony@atomide.com> wrote:
> 8 <----------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 27 May 2015 15:33:57 -0700
> Subject: [PATCH] ARM: OMAP3: Fix booting with thumb2 kernel
>
> We get a NULL pointer dereference on omap3 for thumb2 compiled kernels:
>
> Internal error: Oops: 80000005 [#1] SMP THUMB2
> ...
> [<c046497b>] (_raw_spin_unlock_irqrestore) from [<c0024375>]
> (omap3_enter_idle_bm+0xc5/0x178)
> [<c0024375>] (omap3_enter_idle_bm) from [<c0374e63>]
> (cpuidle_enter_state+0x77/0x27c)
> [<c0374e63>] (cpuidle_enter_state) from [<c00627f1>]
> (cpu_startup_entry+0x155/0x23c)
> [<c00627f1>] (cpu_startup_entry) from [<c06b9a47>]
> (start_kernel+0x32f/0x338)
> [<c06b9a47>] (start_kernel) from [<8000807f>] (0x8000807f)
>
> The power management related assembly on moaps needs to interact with

moaps -> omaps


Gra?vydas
