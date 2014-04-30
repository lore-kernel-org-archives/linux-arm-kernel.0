From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 Apr 2014 10:19:35 +0100
Subject: [RFC 43/47] mtd: nand: stm_nand_bch: read and write functions
 (BCH)
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EAB5CC7@DBDE04.ent.ti.com>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
 <1395735604-26706-44-git-send-email-lee.jones@linaro.org>
 <20980858CB6D3A4BAE95CA194937D5E73EAB5CC7@DBDE04.ent.ti.com>
Message-ID: <20140430091935.GI29462@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >From: Lee Jones [mailto:lee.jones at linaro.org]
> >
> >Helper function for bch_mtd_read() and bch_mtd_write() to handle
> >multi-page or non-aligned reads and writes respectively.
> >
> >Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >---
> 
> I think below code is duplicate of nand_do_read_ops() and nand_do_write_ops()
> in nand_base.c. If you could just populate chip->ecc.read_page and
> chip->ecc.write_page much of this could be avoided.

chip->ecc.read_page and chip->ecc.write_page now populated.

> Also, you need to break your bch_read_page() into given generic NAND
> driver interfaces chip->ecc.calculate(), chip->ecc.correct() ...

Our h/w calculates and corrects automatically.  No need for
intervention.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
