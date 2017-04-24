From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 24 Apr 2017 11:43:38 +0200
Subject: [PATCH V2] clk: hi6220: Add the hi655x's pmic clock
In-Reply-To: <20170424093154.ffo7zsr66a2yjy74@dell>
References: <1491683412-12237-1-git-send-email-daniel.lezcano@linaro.org>
 <20170424093154.ffo7zsr66a2yjy74@dell>
Message-ID: <20170424094338.GC2137@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 10:31:54AM +0100, Lee Jones wrote:
> On Sat, 08 Apr 2017, Daniel Lezcano wrote:
> 
> > The hi655x multi function device is a PMIC providing regulators.
> > 
> > The PMIC also provides a clock for the WiFi and the Bluetooth, let's implement
> > this clock in order to add it in the hi655x MFD and allow proper wireless
> > initialization.
> > 
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> > 
> > Changelog:
> > 
> >  V2:
> >     - Added COMPILE_TEST option, compiled on x86
> >     - Removed useless parenthesis
> >     - Used of_clk_hw_simple_get() instead of deref dance
> >     - Do bailout if the clock-names is not specified
> >     - Rollback on error
> >     - Folded mfd line change and binding
> >     - Added #clock-cells binding documentation
> >     - Added #clock-cells in the DT
> > 
> >  V1: initial post
> > ---
> 
> ??
> 
> > ---
> 
> I'm unsure if this as been mentioned before, but bundling;
> driver & architecture changes and documentation into a single patch is
> very seldom a good idea.  In this case, you should split this into at
> least 3, perhaps 4 patches.
> 
> >  .../devicetree/bindings/mfd/hisilicon,hi655x.txt   |   6 +
> 
> Patch 1
> 
> >  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts     |   1 +
> 
> Patch 2
> 
> >  drivers/clk/Kconfig                                |   8 ++
> >  drivers/clk/Makefile                               |   1 +
> >  drivers/clk/clk-hi655x.c                           | 140 +++++++++++++++++++++
> 
> Patch 3
> 
> >  drivers/mfd/hi655x-pmic.c                          |   3 +-
> 
> Patch 4
> 
> [...]

Yep. Will do that next time.

Thanks.

  -- Daniel
