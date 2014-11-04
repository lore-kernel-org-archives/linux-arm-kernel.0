From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 04 Nov 2014 11:09:16 +0100
Subject: [PATCH 11/17] ARM: mvebu: reserve the first 10 KB of each memory
 bank for suspend/resume
In-Reply-To: <1414151970-6626-12-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-12-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5458A5CC.8090409@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 24/10/2014 13:59, Thomas Petazzoni wrote:
> When going out of suspend to RAM, the Marvell EBU platforms go through
> the bootloader, which re-configures the DRAM controller. To achieve
> this, the bootloader executes a piece of code called the "DDR3
> training code". It does some reads/writes to the memory to find out
> the optimal timings for the memory chip being used.
> 
> This has the nasty side effect that the first 10 KB of each DRAM
> chip-select are overwritten by the bootloader when exiting the suspend
> to RAM state.
> 
> Therefore, this commit implements the ->reserve() hook for the 'struct
> machine_desc' used on Armada XP, to reserve the 10 KB of each DRAM
> chip-select using the memblock API.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/board-v7.c | 51 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

It is unfortunate to put these "holes" in the memory but it is a design constraint.
However, your solution is nice and very well contained however.

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
