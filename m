From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 May 2013 23:40:59 -0700
Subject: [GIT PULL] MCPM support for VExpress RTSM
In-Reply-To: <alpine.LFD.2.03.1305291604300.30828@syhkavp.arg>
References: <alpine.LFD.2.03.1305291604300.30828@syhkavp.arg>
Message-ID: <20130601064059.GT5189@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 04:21:49PM -0400, Nicolas Pitre wrote:
> ARnd, Olof, please pull the following:
> 
> 	git://git.linaro.org/people/nico/linux VExpress_DCSCB
> 
> This is the first MCPM backend submission for VExpress running on RTSM 
> aka Fast Models implementing the big.LITTLE system architecture.  This 
> enables SMP secondary boot as well as CPU hotplug on this platform.
> 
> A big prerequisite for this support is the CCI driver from Lorenzo 
> included in this pull request.
> 
> Also included is Rob Herring's set_auxcr/get_auxcr allowing nicer code.
> 
> This is based on RMK's current devel-stable branch as this code also 
> relies on commit b382b940f821 to work properly.

Ok, I've added a copy of devel-stable as depends/rmk-devel-stable in arm-soc
for reference.

Btw, since he had pulled in the code for smp_ops as a branch, you could
have based only on top of that branch as well.


> The diffstat follows:
> 
>  Documentation/devicetree/bindings/arm/cci.txt   | 172 ++++++
>  .../devicetree/bindings/arm/rtsm-dcscb.txt      |  19 +
>  arch/arm/include/asm/cp15.h                     |  14 +
>  arch/arm/mach-vexpress/Kconfig                  |   9 +
>  arch/arm/mach-vexpress/Makefile                 |   1 +
>  arch/arm/mach-vexpress/core.h                   |   2 +
>  arch/arm/mach-vexpress/dcscb.c                  | 253 +++++++++
>  arch/arm/mach-vexpress/dcscb_setup.S            |  38 ++
>  arch/arm/mach-vexpress/platsmp.c                |  20 +
>  arch/arm/mach-vexpress/v2m.c                    |   1 +
>  drivers/bus/Kconfig                             |   7 +
>  drivers/bus/Makefile                            |   2 +
>  drivers/bus/arm-cci.c                           | 533 ++++++++++++++++++
>  drivers/cpuidle/cpuidle-calxeda.c               |  14 -
>  include/linux/arm-cci.h                         |  61 ++
>  15 files changed, 1132 insertions(+), 14 deletions(-)


Thanks, pulled in as vexpress/dual-cluster into next/soc.


-Olof
