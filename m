From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Nov 2011 22:47:56 +0000
Subject: [PATCH 1/2 v4] atmel/spi: fix missing probe
In-Reply-To: <1320343060-18710-1-git-send-email-plagnioj@jcrosoft.com>
References: <1320342082-18573-1-git-send-email-plagnioj@jcrosoft.com>
	<1320343060-18710-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20111103224756.GT12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 01:57:40AM +0800, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Commit 940ab889 "drivercore: Add helper macro for platform_driver boilerplate"
> converted this driver to use module_platform_driver, but due to the use
> of platform_driver_probe(), this resulted in the call to atmel_spi_probe being
> lost. Place the call to this function into the driver structure.

Let me say again, this should not be the first patch in the series.
If you're trying to fix a bug don't introduce a new bug by fixing
another bug.

If you did this with, say, the VM or FS subsystem, you'll have this
patch reverted.

Moreover, it's bad practice to do "fixes" in this way, especially when
it's trivial to do it _right_ as I've already mentioned several times.

I still maintain that it should be _one_ patch fixing these issues, not
two.
