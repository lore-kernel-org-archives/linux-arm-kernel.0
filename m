From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 14 Mar 2013 16:42:20 -0500
Subject: [PATCH 0/8] ARM: OMAP3+: Switch to use DT based cpu0-cpufreq
 driver
In-Reply-To: <1363294695-658-1-git-send-email-nm@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com>
Message-ID: <5142443C.506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 03/14/2013 03:58 PM, Nishanth Menon wrote:
> The following series arose from trying to use BeagleBoard-XM (OMAP3 variant)
> for doing CPU DVFS using cpufreq-cpu0. This series will eventually result in
> migrating the cpufreq support only through device tree (part of the effort
> to migrate away from non-DT configurations for OMAP). Unfortunately, as already
> known, we have a bunch of legacy code and mutually dependent device tree
> conversion that is pending.
> Key features pending:
> A) clock framework transition to DT - this should happen soon, so this series hacks
> the clock node for the time being as suggested in review of original series
> B) on processors that use voltage controller, voltage processor (VC/VP hardware
> loop using I2C_SR path) - we have started work on transitioning them to regulator
> framework driven by DT.
> C) Adaptive Body Bias and SmartReflex AVS conversion to DT.
> 
> As a result of these pending features:
> - OMAP4 TWL6030 and TPS62361 which set voltage ONLY over I2C_SR have no regulators
> associated at the moment - fortunately, we boot at highest voltage, so things still
> work.
> - Missing ABB and AVS implies that for few of the SoCs (3630, OMAP4), I have not added
> those OPPs in DT yet - this also needs alignment with iMX, AM series like pending work,
> where certain OPPs need enabling based on efuse programmed bit sequences - since it
> is an add-on work, it is not addressed here.
> 
> Note: Somewhere in the future, when we have regulators driven off CCF and OMAP
> converted to CCF, we could remove the DT regulator requirements there as well.

OMAP has been converted to the common clock framework (CCF). Are you
referring to clock framework transition to DT or something else?

Jon
