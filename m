From: darkstar6262@gmail.com (Cory Maccarrone)
Date: Mon, 6 Dec 2010 20:34:00 -0800
Subject: [PATCH] OMAP1: I2C: fix device initialization
In-Reply-To: <alpine.DEB.2.00.1012062130060.13430@utopia.booyaka.com>
References: <alpine.DEB.2.00.1012062130060.13430@utopia.booyaka.com>
Message-ID: <AANLkTimm2azv8fJ9W==dF5cV4jqx12As-WL4ffG390h=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 6, 2010 at 8:30 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Commit 4d17aeb1c5b2375769446d13012a98e6d265ec13 ("OMAP: I2C: split
> device registration and convert OMAP2+ to omap_device") broke I2C on
> OMAP1. ?The following messages appear at boot:
>
> i2c_omap i2c_omap.1: failure requesting irq 0
> i2c_omap: probe of i2c_omap.1 failed with error -22
>
> Investigation revealed that a chunk of code is missing from the
> original plat-omap/i2c.c file which configured the IRQ and base address
> for the I2C block on OMAP1. ?Upon adding this back, the OMAP1 I2C block
> seems to initialize correctly.
>
> Thanks to Cory Maccarrone <darkstar6262@gmail.com> for reporting the bug,
> and apologies for the breakage.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Cory Maccarrone <darkstar6262@gmail.com>
> Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

I tested this on my Herald.  Seems to do the job.

Tested-by: Cory Maccarrone <darkstar6262@gmail.com>

- Cory
