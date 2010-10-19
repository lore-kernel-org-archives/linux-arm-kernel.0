From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 19 Oct 2010 16:31:30 -0700
Subject: [PATCH 0/3] Add OMAP hardware spinlock misc driver
In-Reply-To: <1287387875-14168-1-git-send-email-ohad@wizery.com>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
Message-ID: <1287531090.9245.139.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-10-18 at 09:44 +0200, Ohad Ben-Cohen wrote:
> OMAP4 introduces a Spinlock hardware module, which provides hardware
> assistance for synchronization and mutual exclusion between heterogeneous
> processors and those not operating under a single, shared operating system
> (e.g. OMAP4 has dual Cortex-A9, dual Cortex-M3 and a C64x+ DSP).
> 
> The intention of this hardware module is to allow remote processors,
> that have no alternative mechanism to accomplish synchronization and mutual
> exclusion operations, to share resources (such as memory and/or any other
> hardware resource).
> 
> This patchset adds a new misc driver for this OMAP hwspinlock module.

Does this code interface with some hardware unit (other than the other
processors) to accomplish this locking ?

The reason I ask is because MSM has similar code, and from what I can
tell the MSM version has some structures in memory but that's all. It
just operates on the structures in memory.

It might be worth looking over the two implementation so we aren't both
remaking the wheel.

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
