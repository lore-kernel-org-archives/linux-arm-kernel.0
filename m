From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 19 Aug 2013 16:38:21 +0300
Subject: [PATCH] mtd: atmel_nand: pmecc: fix bug fail to correct bit
 error in 1024-bytes sector
In-Reply-To: <1376906744-4711-1-git-send-email-josh.wu@atmel.com>
References: <1376906744-4711-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1376919501.2089.465.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-08-19 at 18:05 +0800, Josh Wu wrote:
> The PMECC use BCH algorithm to correct error. In BCH algorithm, the primitive
> polynomial value is GF(2^13) for 512-bytes sector size. And it is GF(2^14) for
> 1024-bytes sector size.
> 
> This patch will choose correct degree of the remainders(13 or 14) for
> different sector size.
> Tested in AT91SAM9X5-EK with MLC nand flash.
> 
> More detail can be refered to section 5.4.1 of:
>   AT91SAM ARM-based Embedded MPU Application Note
>   <http://www.atmel.com/Images/doc11127.pdf>
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Pushed to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
