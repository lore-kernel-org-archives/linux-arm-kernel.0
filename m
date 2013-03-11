From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Mar 2013 14:48:18 -0600
Subject: Regulator API ignored return values
In-Reply-To: <201303112043.53334.arnd@arndb.de>
References: <201303112043.53334.arnd@arndb.de>
Message-ID: <513E4312.5060804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2013 02:43 PM, Arnd Bergmann wrote:
> Hi all,
> 
> Mark Brown has added a patch to Linux-next that warns about certain regulator
> API functions being called without checking the results, which seems to have
> uncovered a number of bugs.
> 
> I've added a few people to Cc that might be interested in the reports and
> in fixing these bugs. Below you can find a list of all instances I found
> building the ARM defconfigs.

> ==> build/tegra_defconfig/faillog <==
> /git/arm-soc/arch/arm/mach-tegra/board-harmony-pcie.c: In function 'harmony_pcie_init':
> /git/arm-soc/arch/arm/mach-tegra/board-harmony-pcie.c:65:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]

This one should be fixed by 84b808d "ARM: tegra: fix ignored return
value of regulator_enable" the next time next is rebuilt.
