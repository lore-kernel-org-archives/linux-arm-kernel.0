From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 9 Nov 2010 23:38:03 +0100
Subject: [PATCH] ARM: add support for uncompressed uImage kernel
In-Reply-To: <20101109140455.GA6680@n2100.arm.linux.org.uk>
References: <1289310656-29502-1-git-send-email-alexander.stein@systec-electronic.com>
	<20101109140455.GA6680@n2100.arm.linux.org.uk>
Message-ID: <20101109223803.GA8950@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 02:04:55PM +0000, Russell King - ARM Linux wrote:
> Is it really faster to copy an uncompressed image than it is to
> decompress using LZMA with caches on?
> 

At least on an i.MX35 I can read a bigger image from NAND faster than I
can read + uncompress a smaller image. ZBOOT_ROM is no option for NAND.
Reading from NAND is done with mmu/dcache on in this case.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
