From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 14 Jun 2013 14:12:37 -0400
Subject: [PATCH] ARM: OMAP5: Fix omap5 standalone build break
In-Reply-To: <1371201107-20929-1-git-send-email-rnayak@ti.com>
References: <1371201107-20929-1-git-send-email-rnayak@ti.com>
Message-ID: <51BB5D15.8030306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 June 2013 05:11 AM, Rajendra Nayak wrote:
> Building omap5 standalone results in the below errors..
> 
> arch/arm/mach-omap2/built-in.o: In function `scu_gp_set':
> arch/arm/mach-omap2/sleep44xx.S:132: undefined reference to `scu_power_mode'
> arch/arm/mach-omap2/built-in.o: In function `scu_gp_clear':
> arch/arm/mach-omap2/sleep44xx.S:229: undefined reference to `scu_power_mode'
> arch/arm/mach-omap2/built-in.o: In function `omap4_smp_prepare_cpus':
> arch/arm/mach-omap2/omap-smp.c:211: undefined reference to `scu_enable'
> arch/arm/mach-omap2/built-in.o: In function `omap4_smp_init_cpus':
> arch/arm/mach-omap2/omap-smp.c:185: undefined reference to `scu_get_core_count'
> 
> Fix this by adding the missing select for HAVE_ARM_SCU for SOC_OMAP5
> 
> Reported-by: Pekon Gupta <pekon@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
NAK. Similar patch [1] was posted by Vincent a while back.
The right fix to remove the scu related dependency with OMAP5
code.

Regards,
Santosh

[1] https://patchwork.kernel.org/patch/2568091/
