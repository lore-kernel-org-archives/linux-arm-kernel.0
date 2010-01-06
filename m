From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 06 Jan 2010 13:31:33 +0000
Subject: [PATCH 2/2] Remove now-defunct ts7250 nand driver
In-Reply-To: <201001051459.58621.hartleys@visionengravers.com>
References: <201001051459.58621.hartleys@visionengravers.com>
Message-ID: <1262784693.3181.8034.camel@macbook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-01-05 at 14:59 -0700, H Hartley Sweeten wrote:
> The ts72xx platform has been updated to use the generic platform nand
> driver (plat_nand.c).  This removes the now-defunct ts7250.c nand driver.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Matthieu Crapet <mcrapet@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Jesse Off <joff@embeddedARM.com>

	Applying: mtd: Remove now-defunct ts7250 nand driver
	error: patch failed: drivers/mtd/nand/ts7250.c:1
	error: drivers/mtd/nand/ts7250.c: patch does not apply
	Patch failed at 0001 mtd: Remove now-defunct ts7250 nand driver

It looks like your patch has legacy garbage in it:

> - *   Copyright (C) 2004 Marius Gr<F6>ger (mag at sysgo.de)

It fails to apply because the ? (correctly represented as 0xc3 0xb6) has
been converted into a single byte 0xf6 in some legacy character set.

When applying patches, git-am does look at the Content-Type: header and
convert legacy crap into UTF-8 for the changelog, but it leaves the
patch itself alone.

Care to join us in the 21st century?

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
