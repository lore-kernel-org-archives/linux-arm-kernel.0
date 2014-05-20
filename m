From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 May 2014 10:04:13 +0200
Subject: [PATCH v2 1/3] ARM: shmobile: r8a7791: add internal PCI bridge
 nodes
In-Reply-To: <201405200152.06575.sergei.shtylyov@cogentembedded.com>
References: <201405200148.28683.sergei.shtylyov@cogentembedded.com>
 <201405200152.06575.sergei.shtylyov@cogentembedded.com>
Message-ID: <5095898.2pUCzGkcW7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 May 2014 01:52:05 Sergei Shtylyov wrote:
> +               interrupt-map-mask = <0xff00 0 0 0x7>;
> +               interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
> +                                0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
> +                                0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;

Are there only internal devices on this PCI host?

If there are slots, the map should normally list all four interrupts
per slot in some way.

	Arnd
