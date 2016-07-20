From: horms@verge.net.au (Simon Horman)
Date: Thu, 21 Jul 2016 08:15:24 +0900
Subject: [PATCH] ARM: shmobile: don't call platform_can_secondary_boot on
 UP
In-Reply-To: <CAMuHMdWJOVs_pzDHWVHN8=mguUPETbq2m8LAG_N6mUFk+UA_og@mail.gmail.com>
References: <20160630122529.4031024-1-arnd@arndb.de>
 <CAMuHMdWJOVs_pzDHWVHN8=mguUPETbq2m8LAG_N6mUFk+UA_og@mail.gmail.com>
Message-ID: <20160720231523.GD9599@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 03:09:46PM +0200, Geert Uytterhoeven wrote:
> Hi Arnd,
> 
> On Thu, Jun 30, 2016 at 2:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > For rcar-gen2, we build the SMP files even for UP configurations,
> > and that just broke:
> >
> > arch/arm/mach-shmobile/built-in.o: In function `shmobile_smp_init_fallback_ops':
> > pm-rcar-gen2.c:(.init.text+0x40c): undefined reference to `platform_can_secondary_boot'
> >
> > This adds an compile-time check before the call to platform_can_secondary_boot,
> > turning the function into an empty stub for UP configurations.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Fixes: c21af444eace ("ARM: shmobile: smp: Add function to prioritize DT SMP")
> 
> Crap, I think I took the shortcut of only compile-testing
> arch/arm/mach-shmobile,
> not link-testing the whole kernel, with CONFIG_SMP=n...
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Sorry for missing this until now.
I have queued it up as a fix for v4.7.
