From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 17 Aug 2015 09:48:59 +0200
Subject: [linux-sunxi] ARM: sunxi: Experiences NAND flash
In-Reply-To: <55CB4AA3.9050809@schinagl.nl>
References: <55C9E7B4.9090906@schinagl.nl>
	<55CB4AA3.9050809@schinagl.nl>
Message-ID: <20150817094859.7dae8c96@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oliver,

On Wed, 12 Aug 2015 15:31:15 +0200
Olliver Schinagl <oliver+list@schinagl.nl> wrote:

> Hey Yassin,
> 
> I'm affraid. The strange thing that seems very related here is that when 
> writing a file onto the flash, it fails and succeeds alternating. It 
> never fails or succeeds twice in a row! And this on any board and any 
> partition.

I don't know if you only pasted half your command sequence, but it
seems you are writing twice on the same memory region without erasing it,
and this is prohibited on NAND devices.

Try with:

# flash_erase /dev/mtd0 && nandwrite -p /dev/mtd0 u-boot-sunxi-with-spl.bin

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
