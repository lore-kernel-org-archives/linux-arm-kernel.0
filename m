From: ijc@hellion.org.uk (Ian Campbell)
Date: Sun, 22 Sep 2013 15:44:05 +0100
Subject: [linux-sunxi] [PATCH V3: Add Smp support for Allwinner A20.
 1/3] Add smp support for Allwinner A20(sunxi 7i).
In-Reply-To: <1379852488-32147-2-git-send-email-cinifr@gmail.com>
References: <1379852488-32147-1-git-send-email-cinifr@gmail.com>
 <1379852488-32147-2-git-send-email-cinifr@gmail.com>
Message-ID: <1379861045.30708.22.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-09-22 at 20:21 +0800, Fan Rong wrote:

> +	/* Set boot addr */
> +	paddr = virt_to_phys(sun7i_secondary_startup);
> +	writel(paddr, sunxi7i_cc_base + SUN7I_CPUCFG_BOOTADDR);

This means that the secondary cores will miss out on any setup which the
bootloader might have done for the primary CPU, e.g. switching to NS HYP
mode, setting the CNTFRQ etc.

Wouldn't it be better to do all this stuff in the bootloader and either
implement PSCI or have the bootloader do the traditional holding pen and
mbox address thing?
