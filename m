From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 10:38:06 +0100
Subject: [GIT PULL] ARM: BCM5301X: DT changes for v3.19
In-Reply-To: <546299BC.4060704@hauke-m.de>
References: <546299BC.4060704@hauke-m.de>
Message-ID: <201411201038.07191.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 November 2014, Hauke Mehrtens wrote:
> ARM: BCM5301X: Add some more devices to device tree
> 
> The most important part is adding the axi bus to the SoC dtsi file,
> this is the main bus on the SoC.
> 
> These patches were all send to the arm list and I haven't got any
> negative responses.
> 
> ----------------------------------------------------------------
> Hauke Mehrtens (1):
>       ARM: BCM5301X: activate early printk for Netgear R6250
> 
> Rafa? Mi?ecki (2):
>       ARM: BCM5301X: Add Broadcom's bus-axi to the DTS file
>       ARM: BCM5301X: Add LEDs for Netgear R6250 V1
> 

Same comments as for the SoC changes. Note that in general, enabling
'earlyprintk' in the dts is a bad idea because it breaks booting a
kernel that has an incompatible debug_ll setting enabled, I'd rather
see you drop that patch.

Starting with 3.19, the shiny new 'earlycon' support should work, so
I'd prefer you to set the 'stdout-path' property in the /chosen
node. Unfortunately enabling earlycon at the command line is still
broken on 3.18-rc because the fixmap patches are only in Russell's
'ronx-next' branch. We could think about pulling that into arm-soc
if we want to start enabling earlycon drivers.

	Arnd
