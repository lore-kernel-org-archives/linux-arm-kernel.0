From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 15:10:36 +0100
Subject: [PATCH v2 01/14] ARM: tegra: annotate IO_*_VIRT pointers
In-Reply-To: <1318224484-2090-2-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
	<1318224484-2090-1-git-send-email-olof@lixom.net>
	<1318224484-2090-2-git-send-email-olof@lixom.net>
Message-ID: <20111013141036.GX21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 09, 2011 at 10:27:51PM -0700, Olof Johansson wrote:
> +#ifdef __ASSEMBLY__
> +#define __IOVADDR(x)	(x)
> +#else
> +#define __IOVADDR(x)	((void __force __iomem *)(x))

Please call this IOMEM() - see:

grep '#define *IOMEM' arch/arm/*/include/mach -r

for its establishment across several implementations.
