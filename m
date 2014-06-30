From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 30 Jun 2014 15:32:02 +0200
Subject: [PATCH 13/16] cpuidle: mvebu: Move the description of the
 cpuidle states in the platform part
In-Reply-To: <1403875377-940-14-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
 <1403875377-940-14-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140630153202.69f885e0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Fri, 27 Jun 2014 15:22:54 +0200, Gregory CLEMENT wrote:
> In order to prepare the add of new SoCs supports for this cpuidle

"the add of new SoCs supports for this cpuidle" -> "the addition of the
support for more SoCs in this cpuidle".

> driver, this patch moves the description of the state in the platform
> part. Indeed the number of the cpuidle state, and the value of the
> flag used will vary depending of the SoC.

I actually don't really agree with the reasoning here. We can perfectly
fine have several separate compatible strings, one for each SoC. We do
this for pinctrl, for clocks, and for many other drivers. Why should it
be different for the cpuidle driver? I know the function to enter idle
will most likely implemented in arch/arm/mach-mvebu/ because those
functions are generally too tightly coupled with a bunch of system
registers changes, but the description of the different idle states can
just as well be inside the cpuidle driver itself.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
