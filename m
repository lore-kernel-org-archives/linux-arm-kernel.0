From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 28 Apr 2012 07:30:01 +0200
Subject: [PATCH 02/17] ARM: at91: use machine specific hook for late init
In-Reply-To: <20120428023008.GA9924@S2101-09.ap.freescale.net>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <1335454725-13089-3-git-send-email-shawn.guo@linaro.org>
 <20120426152906.GP9142@game.jcrosoft.org>
 <20120427140746.GD2234@S2101-09.ap.freescale.net>
 <20120427142601.GU9142@game.jcrosoft.org>
 <20120428023008.GA9924@S2101-09.ap.freescale.net>
Message-ID: <20120428053001.GY9142@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:30 Sat 28 Apr     , Shawn Guo wrote:
> On Fri, Apr 27, 2012 at 04:26:01PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > we discuss with Arnd we came back with 2 ideas one is to use a machine
> > specific initcall or compatible specifc initcall
> 
> Do you mean an initcall with machine/compatible detection inside?  The
> whole point of the hooks in struct machine_desc  is to save the
> machine/compatible detection.  You already use .init_machine as
> an arch_initcall time hook, and what .init_late provides you is just
> a late_initcall time hook.  If you want to detect machine/compatible
> in your late_initcall rather than using this hook, you should not
> use .init_machine for the same reason.
on DT we just do this

so the hook start to make not too much sense
at machine level

as this is for nearly all of them purely soc

> 
> > or the second one is to
> > resurect Marc patch series to introduce soc_desc
> > 
> This is the approach I can agree on, but isn't the patch moving one
> step close to that, turning the late_initcall into a function which
> can be hooked into soc specific call?
no you touch too much file and make code expertoed where this no need of this

> 
> > and on at91 Ill not touch it as the old style board can NOT be compiled with
> > other soc (only one at91 soc at a time).
> > 
> > And I'll not fix it as we move to the DT which I fix to be able to be compiled
> > in the multiarch kernel.
> > 
> It's something on your plate.  Just tell me to drop the patch from
> the series, if you do not want it in.
no I want it clean an ALL arch and do not duplicated code 

Best Regards,
J.
