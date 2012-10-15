From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 15 Oct 2012 20:56:40 +0200
Subject: [PATCH 1/4] mtd: nand: omap2: Update nerrors using ecc.strength
In-Reply-To: <1349274589-11389-2-git-send-email-avinashphilip@ti.com> (Avinash
 Philip's message of "Wed, 3 Oct 2012 19:59:46 +0530")
References: <1349274589-11389-1-git-send-email-avinashphilip@ti.com>
 <1349274589-11389-2-git-send-email-avinashphilip@ti.com>
Message-ID: <87obk3va1j.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> Philip, Avinash <avinashphilip@ti.com> writes:

 > Update number of errors using nand ecc strength.
 > Also add macro definitions BCH8_ERROR_MAX & BCH4_ERROR_MAX

 > Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
 > ---
 > :100644 100644 5b31386... af511a9... M	drivers/mtd/nand/omap2.c
 >  drivers/mtd/nand/omap2.c |   12 ++++++++----
 >  1 files changed, 8 insertions(+), 4 deletions(-)

 > diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
 > index 5b31386..af511a9 100644
 > --- a/drivers/mtd/nand/omap2.c
 > +++ b/drivers/mtd/nand/omap2.c
 > @@ -111,6 +111,9 @@
 >  #define	ECCCLEAR			0x100
 >  #define	ECC1				0x1
 
 > +#define BCH8_MAX_ERROR		8	/* upto 8 bit coorectable */
 > +#define BCH4_MAX_ERROR		4	/* upto 4 bit correctable */

First 'correctable' misspelled.

I don't personally think these defines improve readability very much
compared to to just using 4/8, though.

-- 
Bye, Peter Korsgaard
