From: manningc2@actrix.gen.nz (Charles Manning)
Date: Mon, 20 Dec 2010 10:45:53 +1300
Subject: [PATCH v6 0/7] nand prefetch-irq support and ecc layout chanage
In-Reply-To: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
References: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
Message-ID: <201012201045.53688.manningc2@actrix.gen.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 27 November 2010 04:34:30 Sukumar Ghorai wrote:
> The following set of patches applies on linux-2.6.
>
> The main motivations behind this patch series are -
>         1. support NAND I/O in irq mode.
>         2. support of different ECC schema.
>         3. also to make ecc layout as like in romcode ecc layout

Why change the ECC layout?

Be very careful when you change ECC layouts. This can break production 
systems.

For example if people are running something earlier and then want to deliver a 
new kernel with 2.6.37 then their existing NAND file systems will no longer 
be readable.

Changes to ECC should only be done for very good reasons and should be 
controlled with a Kconfig with the default being the existing ECC layout.

-- Charles
