From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Jan 2010 09:32:33 +0000
Subject: Problems with device compilation by subsystem config
In-Reply-To: <20100128070518.GS10014@trinity.fluff.org>
References: <20100128070518.GS10014@trinity.fluff.org>
Message-ID: <20100128093233.GA7339@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 07:05:18AM +0000, Ben Dooks wrote:

> My first response is that this forces the user to rebuild the kernel
> every time they decide to change the subsytems included, which if just
> building things as modules isn't nice. However this wasn't a strong enough
> objection at the time to reject the patches.

> People might say that building everything is a waste of kernel space, but
> we cluttering mach-xxx.c with #ifdefs is also not pleasant, and if we have
> as currently for many of the other devices CONFIG to build the devices
> selected by the machine then we are reasonably efficient.

I tend to agree that the space savings being pointless on a system like
S3C64xx - on S3C24xx RAM is likely to be much more precious but if
the processor is something like the S3C64xx the resource used by the
device definitions is unlikely to be meaningful.  I only included the
conditional build for the audio device because the existing code for I2C,
SDHCI and so on was doing the same.

> To fix thsi I propose changing the SPI and Audio support to have their
> own 'config S3C_DEV_xxx' entries which are selected by the boards that
> use them (this removes the need for #ifdef in the board file) and these
> entries should not be dependant on the subsytem defines.

To be honest I'd be inclined to just unconditionally include them.  I
suspect if they're genuinely unused the linker ought to be able to
discard them anyway.
