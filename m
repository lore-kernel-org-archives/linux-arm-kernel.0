From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Apr 2012 12:13:27 +0100
Subject: [PATCH 5/9] dmaengine: provide a common function for
 completing a dma descriptor
In-Reply-To: <000001cd2141$26914d60$73b3e820$%kim@samsung.com>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <E1S52yJ-0002Mx-2e@rmk-PC.arm.linux.org.uk>
 <056201cd2135$10ea5b70$32bf1250$%kim@samsung.com>
 <20120423095013.GL24211@n2100.arm.linux.org.uk>
 <1335175278.31825.108.camel@vkoul-udesk3>
 <000001cd2141$26914d60$73b3e820$%kim@samsung.com>
Message-ID: <20120423111327.GM24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 08:06:36PM +0900, Boojin Kim wrote:
> I met the DMA probing fail problem on Linux 3.4.
> It's because the return value on regulator_get() is changed
> from ENODEV to EPROBE_DEFER in case not to supply a vcore regulator.
> So, I try to change the check value about the return value of regulator_get()
> in amba_get_enable_vcore()from ENODEV to EPROBE_DEFER.
> How about it ? Do you already fix it too?

A fix has already been committed and sent upstream - about a week ago.
