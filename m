From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 15 Oct 2012 20:48:30 +0200
Subject: [PATCH 3/4] ARM: OMAP2: gpmc: Add support for BCH ECC scheme
In-Reply-To: <1349274589-11389-4-git-send-email-avinashphilip@ti.com> (Avinash
 Philip's message of "Wed, 3 Oct 2012 19:59:48 +0530")
References: <1349274589-11389-1-git-send-email-avinashphilip@ti.com>
 <1349274589-11389-4-git-send-email-avinashphilip@ti.com>
Message-ID: <87vcebvaf5.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> Philip, Avinash <avinashphilip@ti.com> writes:

 > Add support for BCH ECC scheme to gpmc driver and also enabling multi
 > sector read/write. This helps in doing single shot NAND page read and
 > write.

 > ECC engine configurations
 > BCH 4 bit support
 > 1. write => ECC engine configured in wrap mode 6 and with ecc_size0 as 32.
 > 2. read  => ECC engine configured in wrap mode 1 and with ecc_size0 as
 > 13 and ecc_size1 as 1.

 > BCH 8 bit support
 > 1. write => ECC engine configured in wrap mode 6 and with ecc_size0 as 32.
 > 2. read  => ECC engine configured in wrap mode 1 and with ecc_size0 as
 > 26 and ecc_size1 as 2.

 > Note: For BCH8 ECC bytes set to 14 to make compatible with RBL.

On what device? In the am335x TRM (spruh73f.pdf) figure 26-15 (pg 4273)
the rom code is documented to not use any padding on the ECC bytes
(E.G. oob 2..53):

http://www.ti.com/litv/pdf/spruh73f

I see the driver in the u-boot-am33x tree (ti81xx_nand.c) seems to use
4x14 bytes as well though, so perhaps that's a bug in the documentation
instead?

-- 
Bye, Peter Korsgaard
