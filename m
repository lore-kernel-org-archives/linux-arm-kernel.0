From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 19 Feb 2015 13:41:58 -0800
Subject: [PATCH 13/13] mfd: Add support for the MediaTek MT6397 PMIC
In-Reply-To: <20150219121304.GH12212@x1>
References: <1423478845-2835-1-git-send-email-s.hauer@pengutronix.de>
 <1423478845-2835-14-git-send-email-s.hauer@pengutronix.de>
 <20150216095645.GA2037@x1> <20150218181904.421.59675@quantum>
 <20150219082655.GV12209@pengutronix.de> <20150219084349.GA12212@x1>
 <20150219120409.GW12209@pengutronix.de> <20150219121304.GH12212@x1>
Message-ID: <20150219214158.421.17521@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Lee Jones (2015-02-19 04:13:04)
> On Thu, 19 Feb 2015, Sascha Hauer wrote:
> 
> > On Thu, Feb 19, 2015 at 08:43:49AM +0000, Lee Jones wrote:
> > > On Thu, 19 Feb 2015, Sascha Hauer wrote:
> > > 
> > > > > > Looks okay to me now.
> > > > > > 
> > > > > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > > > > 
> > > > > > What's the merge plan for this set?
> > > > > 
> > > > > Patches 1-9 are clock related an several of them have review comments
> > > > > that need to be addressed. I wonder if a V2 series can break out the
> > > > > various subsystems bits from each other?
> > > > 
> > > > I'll send a new series later this day. These used to be two series, but
> > > > the PMIC wrapper patches depend on the clock and reset controllers, also
> > > > the device nodes depend on the clock/reset defines from the clock
> > > > support patches. What do you suggest? In the early days of a SoC
> > > > everything seems to depend on everything.
> > > 
> > > Only build dependencies count.  So long as the Kconfigs are setup
> > > correct, there shouldn't be any issue in taking patches in one
> > > subsystem at a time.
> > 
> > The dts snippets need the files in include/dt-bindings, so indeed this
> > is a build dependency. However, this comes only in with the dts changes.
> > 
> > So here's the plan:
> > 
> > - Mike takes the clk patches
> > - Matthias takes the pmic wrapper driver (in drivers/soc/mediatek/)
> > - You take the MT6397 core driver.
> 
> Sounds reasonable.  Just ensure that each set is orthogonal and builds
> (or doesn't attempt to) and we'll be in a good place.

Agreed.

Regards,
Mike

> 
> > I'll queue up the dts changes locally and ask Arnd to take these after
> > next -rc1 so that all dependencies are in. Unfortunately this means that
> > the patches can't be tested until everything is together after next
> > -rc1.
> 
> I'm sure you will be diligent enough to test the interoperability of
> the sets combined.  Failing that we can deal with any unavoidable
> fall-out during the -rcs.
> 
> -- 
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
