From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Sep 2011 15:14:41 +0100
Subject: [PATCH 2/6] arm/imx6q: add core definitions and low-level
	debug uart
In-Reply-To: <20110912084439.GO31404@pengutronix.de>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-3-git-send-email-shawn.guo@linaro.org>
	<20110906202555.GQ28816@pengutronix.de>
	<20110907110001.GI8148@S2100-06.ap.freescale.net>
	<20110912084439.GO31404@pengutronix.de>
Message-ID: <20110912141440.GC7007@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2011 at 10:44:39AM +0200, Sascha Hauer wrote:
> I vote to skip params_phys and initrd_phys now. Every recent bootloader
> does not need them. As the i.MX6 is a new SoC, we have no reason to
> handle legacy bootloaders.

Can we stop this misunderstanding right now.

It's NOT about legacy boot loaders.  It's about the bootp code which
allows an initrd to be packaged up together with a zImage file as one
single file.

That's used to be able to boot with an initrd on platforms which can
only obtain one file from the boot media, and they specify where the
parameters are expected to be (which can be solved by updating the
code to use r2) and where to place the initrd image (which can't be
solved as it would mean encoding memory information for every platform
into the bootp code.)

An example of a current boot loader which requires this: Simtec's Able
boot loader.
