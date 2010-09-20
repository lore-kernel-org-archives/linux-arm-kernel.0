From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Sep 2010 11:13:34 +0200
Subject: [PATCH 0/3] [ARM] tegra: PCI Express support
In-Reply-To: <4C9709F4.9040308@compulab.co.il>
References: <cover.1284655723.git.mike@compulab.co.il>
	<20100919160103.GF9098@n2100.arm.linux.org.uk>
	<4C9709F4.9040308@compulab.co.il>
Message-ID: <201009201113.34760.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 September 2010, Mike Rapoport wrote:
> static struct resource pcie_res[] = {
>         [0] = {
>                 .name   = "PCIe IO",
>                 .start  = 0x1000,
>                 .end    = 0x1000 + IO_SIZE - 1,
>                 .flags  = IORESOURCE_IO,
>         },

The end should be 'IO_SIZE - 1' or IO_SPACE_LIMIT (should be the same anyway),
not '0x1000 + IO_SIZE - 1'. The reason for the 0x1000 is that the first 4096
ports are reserved for legacy ISA devices by setting PCIBIOS_MIN_IO.

The rest looks fine AFAICT.

	Arnd
