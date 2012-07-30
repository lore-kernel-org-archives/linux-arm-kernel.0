From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 30 Jul 2012 11:40:07 +0300
Subject: [PATCHv4 4/8] ARM: OMAP3: add manual control for mpu / core
 pwrdm usecounting
In-Reply-To: <878ve5j8se.fsf@ti.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
 <1342189185-5306-5-git-send-email-t-kristo@ti.com>  <878ve5j8se.fsf@ti.com>
Message-ID: <1343637607.9847.13.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-07-27 at 12:36 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > mpu / core powerdomain usecounts are now statically increased
> > by 1 during MPU activity. This allows the domains to reflect
> > actual usage, and will allow the usecount to reach 0 just before
> > all CPUs are ready to idle. Proper powerdomain usecounts are
> > propageted to voltagedomain level also, and will allow vc
> > callbacks to be triggered at right point of time.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> 
> IMO, the idea is fine, but I'm not crazy about the implementation in
> powerdomain.c, which is meant for pwrdm generic code.   In particular,
> I'm not crazy about the pwrdm lookups in powerdomain.c.
> 
> Since pm<soc>.c already has references to mpu_pwrdm and core_pwrdm, why
> not just add the pwrdm_clkdm_enable/disable calls directly in pm<soc>.c

I think this was how the patch was in some earlier rev but I thought I'd
try to be more clever with this. :) I can revert the implementation back
to this.

> Also, the changelog should be a bit more specific about why CORE
> powerdomain is also handled here when most of the code only talks about
> the CPU.

Yea, I'll add some beef to this also.

-Tero
