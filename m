From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 15 Sep 2013 20:03:13 +0200
Subject: [PATCH v4 1/4] ARM: bcm4760: Add platform infrastructure
In-Reply-To: <20130914152123.491631670@gmail.com>
References: <20130914152032.401907974@gmail.com>
 <20130914152123.491631670@gmail.com>
Message-ID: <201309152003.13780.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 September 2013, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> Platform infrastructure for the Broadcom BCM4760 based ARM11 SoCs.
> 
> v4:
> * added low-level debug PL01X parameters
> * added clocks to the VICs DT stanzas
> 
> v3:
> * dropped the idea of unconditionally build mach-bcm
> 
> v2:
> * clocks are now configured via DT
> * uart DT nodes have been renamed and hooked to the proper clock nodes
> * dropped unneeded config options
> * dropped misused initialization of system_rev
> * dropped unneeded early io mapping 
> * build rule of mach-bcm is moved to separated patch
> 
> v1:
> * initial release
> 
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Acked-by: Jason Cooper <jason@lakedaemon.net>
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>

Note that normally we put the patch revision history below the '---' line, so it 
doesn't get included in the git history.

> +
> +static void __init bcm4760_init(void)
> +{
> +	of_clk_init(NULL);
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}

With the series that Sebastian Hesselbarth prepared to automatically do
of_clk_init(NULL), this entire function should go away as well, but I think
the cleanest way is to handle that in the arm-soc tree during the merge
of your patches with Sebastian's patches.

	Arnd
