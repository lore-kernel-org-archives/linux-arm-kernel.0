From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 10 Nov 2014 15:05:21 +0100
Subject: [PATCH 13/17] ARM: mvebu: make sure MMU is disabled in
 armada_370_xp_cpu_resume
In-Reply-To: <1414151970-6626-14-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-14-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5460C621.9010506@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/10/2014 13:59, Thomas Petazzoni wrote:
> The armada_370_xp_cpu_resume() until now was used only as the function
> called by the SoC when returning from a deep idle state (as used in
> cpuidle, or when the CPU is brought offline using CPU hotplug).
> 
> However, it is now also used when exiting the suspend to RAM state. In
> this case, it is the bootloader that calls back into this function,
> with the MMU left enabled by the BootROM. Having the MMU enabled when
> entering this function confuses the kerrnel because we are not using
                                      kernel


> the kernel page tables at this point, but in other mvebu functions we
> use the information on whether the MMU is enabled or not to find out
> whether we should talk to the coherency fabric using a physical
> address or a virtual address. To fix that, we simply disable the MMU
> when entering this function, so that the kernel is in an expected
> situation.
> 


Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>



> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/pmsu_ll.S | 8 ++++++++
>  1 file changed, 8 insertions(+)


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
