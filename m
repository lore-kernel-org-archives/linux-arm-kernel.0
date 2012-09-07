From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 06 Sep 2012 20:36:41 -0600
Subject: [PATCH 07/12] ARM: move all dtb targets out of Makefile.boot
In-Reply-To: <20120907022711.GE26709@S2101-09.ap.freescale.net>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
 <1346962375-26163-8-git-send-email-robherring2@gmail.com>
 <20120907022711.GE26709@S2101-09.ap.freescale.net>
Message-ID: <50495DB9.5030008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2012 08:27 PM, Shawn Guo wrote:
> On Thu, Sep 06, 2012 at 03:12:50PM -0500, Rob Herring wrote:
>> +dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb
>> +dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
>> +dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += tegra20-harmony.dtb tegra20-paz00.dtb \
>> +	tegra20-seaboard.dtb tegra20-trimslice.dtb tegra20-ventana.dtb \
>> +	tegra20-whistler.dtb

Hmm. The existing files all have one file per line, which makes
adding/removing files have a little less impact; whole lines are
added/removed rather than needing to reflow the whole list. Should we
apply the same layout here too?

> PS. A little heads-up: if this lands on 3.7, there will be conflict
> on arch/arm/mach-mxs/Makefile.boot which gets new entries in this
> cycle.

The same is true of Tegra:

-dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-cardhu.dtb
+dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-cardhu-a02.dtb
+dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-cardhu-a04.dtb
