From: horms@verge.net.au (Simon Horman)
Date: Thu, 14 Feb 2013 12:34:04 +0900
Subject: [PATCH 00/06] ARM: shmobile: SMP Cortex-A9 SCU rework
In-Reply-To: <20130213134628.12153.47120.sendpatchset@w520>
References: <20130213134628.12153.47120.sendpatchset@w520>
Message-ID: <20130214033403.GR15879@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 10:46:28PM +0900, Magnus Damm wrote:
> ARM: shmobile: SMP Cortex-A9 SCU rework
> 
> [PATCH 01/06] ARM: shmobile: Kill off sh73a0 scu_base_addr() function
> [PATCH 02/06] ARM: shmobile: Kill off r8a7779 scu_base_addr() function
> [PATCH 03/06] ARM: shmobile: Rework EMEV2 scu_base variable
> [PATCH 04/06] ARM: shmobile: Move headsmp-sh73a0.S to headsmp-scu.S
> [PATCH 05/06] ARM: shmobile: Common shmobile_scu_base in headsmp-scu.S
> [PATCH 06/06] ARM: shmobile: Update EMEV2 to use scu_power_mode()
> 
> Rework the EMEV2 SMP code to make use of common scu_power_mode()
> code together with a shared shmobile_scu_base and early SCU
> setup code in headsmp-scu.S.
> 
> The patches are known to build for sh73a0, r8a7779 and EMEV2.
>
> Note that the code has only been tested on the KZM9D/EMEV2 board,
> and because of that changes to other boards have been kept at
> a minimum. Next target after this is to update the r8a7779 SMP/SCU
> code to make use of scu_base_addr(), but that requires hardware
> access for testing.

I have tested this on the kzm9g/sh73a0, marzen/r8a7779 and kzm9d/emev2.

I have applied the entire series to the soc5 branch thus queued up
for v3.10. It is also in the next branch and thus should appear
in linux-next in the not to distant future.
