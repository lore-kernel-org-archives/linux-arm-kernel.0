From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Jun 2017 15:42:43 +0100
Subject: [PATCH v2 2/2] memory: ti-emif-sram: introduce relocatable
 suspend/resume handlers
In-Reply-To: <20170519175708.6070-3-d-gerlach@ti.com>
References: <20170519175708.6070-1-d-gerlach@ti.com>
 <20170519175708.6070-3-d-gerlach@ti.com>
Message-ID: <20170620144243.GB23750@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 12:57:08PM -0500, Dave Gerlach wrote:
> +	.arm
> +	.align 3
> +
> +ENTRY(ti_emif_sram)

Will you ever want to have any of this code as Thumb?

> +extern inline void ti_emif_offsets(void)
> +{

"extern inline" is frowned upon in the kernel - any reason this
can't be "static inline" ?

Any reason not to provide a stub for when it's not configured,
and eliminate the ifdef in arch/arm/kernel/asm-offsets.c ?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
