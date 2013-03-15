From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 15 Mar 2013 10:48:57 +0530
Subject: [PATCH 0/8] ARM: OMAP3+: Switch to use DT based cpu0-cpufreq
 driver
In-Reply-To: <1363294695-658-1-git-send-email-nm@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com>
Message-ID: <5142AF41.7070003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013 02:28 AM, Nishanth Menon wrote:
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
Thanks for looking into it.

> Note: Somewhere in the future, when we have regulators driven off CCF and OMAP
> converted to CCF, we could remove the DT regulator requirements there as well.
> 
> Key benefit of the series is to allow all relevant TI platforms now to use a single
> cpufreq driver and equivalent frameworks in addition be part of the transition to
> DT. As a result of this series, CPUFreq feature will not be available for non-DT
> boot systems.
> 
As commented by Jon on internal thread, I am also against the idea of dropping
non-DT support now. Till we migrate to 100 % DT, it is best to keep support
alive. Especial OMAP3 based devices.

Why don't you take phased approach and have both supported for time being.
Then once we move to DT only, we just drop the non-DT support as we plan
to do for many more stuff.

BTW, we are using only CPUFreq driver before this series as well. I guess you
mean the common CPUFReq drivers used by other ARM SOCs.

Regards,
Santosh
