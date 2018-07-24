From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Jul 2018 10:46:17 +0200
Subject: [PATCH v3] mmc: sunxi: remove output of virtual base address
In-Reply-To: <20180723153431.8669-1-andre.przywara@arm.com>
References: <20180723153431.8669-1-andre.przywara@arm.com>
Message-ID: <20180724084617.fqgrhyuz3xx72l4g@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 04:34:31PM +0100, Andre Przywara wrote:
> Recent Linux versions refuse to print actual virtual kernel addresses,
> to not give a hint about the location of the kernel in a randomized virtual
> address space. This affects the output of the sunxi MMC controller
> driver, which now produces the rather uninformative line:
> 
> [    1.482660] sunxi-mmc 1c0f000.mmc: base:0x(____ptrval____) irq:8
> 
> Since the virtual base address is not really interesting in the first
> place, let's just drop this value. The same applies to Linux' notion of
> the interrupt number, which is independent from the GIC SPI number.
> We have the physical address as part of the DT node name, which is way
> more useful for debugging purposes.
> To keep a success message in the driver, we make this purpose explicit
> with the word "initialized", plus print some information that is not too
> obvious and that we learned while probing the device:
> the maximum request size and whether it uses the new timing mode.
> So the output turns into:
> [    1.750626] sunxi-mmc 1c0f000.mmc: initialized, max. request size: 16384 KB, uses new timings mode
> [    1.786699] sunxi-mmc 1c11000.mmc: initialized, max. request size: 2048 KB
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180724/b8580186/attachment.sig>
