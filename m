From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Sep 2012 23:29:05 -0600
Subject: [PATCH] ARM: dtb: move all dtb targets to common Makefile
In-Reply-To: <1348203840-23559-1-git-send-email-olof@lixom.net>
References: <1348203840-23559-1-git-send-email-olof@lixom.net>
Message-ID: <505BFB21.8030503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20/2012 11:04 PM, Olof Johansson wrote:
> Since the dtb targets have moved to arch/arm/boot/dts/Makefile, sweep
> the platforms that have had new targets added recently and move them over.
> 
> While I was at it, I also made the dtb generation more generic, i.e. if
> the platform is enabled then all dtbs for that platform will be created.

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile

> +dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb

That's still in arch/arm/mach-bcm2835/Makefile.boot.

And I don't see any diffs for Tegra, which added some new files in the
dt and dt2 branches IIRC (e.g. commit
a3ee1293b1bec15e179b5a4c99fe07157de35202). Strangely, git log on arm-soc
for-next commit bc51b817c64e6c3b9865b87a7c3d6b9d6ea9afb2 doesn't show
any edits to arch/arm/mach-tegra/Makefile.boot even though that other
commit I mentioned did touch the file and is in the history??? I guess I
need sleep.
