From: miquel.raynal@free-electrons.com (Miquel Raynal)
Date: Wed, 24 Jan 2018 23:59:36 +0100
Subject: [PATCH] mtd: nand: sunxi: Fix ECC strength choice
In-Reply-To: <20180124224931.14392-1-miquel.raynal@free-electrons.com>
References: <20180124224931.14392-1-miquel.raynal@free-electrons.com>
Message-ID: <20180124235936.4b49b094@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 24 Jan 2018 23:49:31 +0100
Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> When the requested ECC strength does not exactly match the strengths
> supported by the ECC engine, the driver is selecting the closest
> strength meeting the 'selected_strength > requested_strength'
> constraint. Fix the fact that, in this particular case, ecc->strength
> value was not updated to match the 'selected_strength'.
> 
> For instance, one can encounter this issue when no ECC requirement is
> filled in the device tree while the NAND chip minimum requirement is not
> a strength/step_size combo natively supported by the ECC engine.
> 

I forgot to add the Fixes/CC tags, but it seems that this problem
has always been out there...

Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller
support")
CC: stable at vger.kernel.org

> Suggested-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

I will wait a review before sending a v2.

Thanks,
Miqu?l
