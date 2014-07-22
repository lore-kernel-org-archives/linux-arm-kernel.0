From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 21 Jul 2014 19:56:03 -0700
Subject: [PATCH v2] mtd: atmel_nand: make ecc parameters same as definition
In-Reply-To: <1402559925-20910-1-git-send-email-voice.shen@atmel.com>
References: <1402559925-20910-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20140722025603.GC7537@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 03:58:45PM +0800, Bo Shen wrote:
> If the ecc parameter is not the same as definition, when the
> mtd core check these parameters, it will give the error result.
> 
> Take the following as an example:
> 
> Calculate how many bits can be corrected in one page.
> According to the ecc parameters definition,
> 
> one page correct bits = (mtd->writesize * ecc->strength) / ecc->size
> 
> take the following use case as an example:
> mtd->writesize = 2048 bytes
> ecc->strength = 4 bytes (for 512 bytes)
> 
> before this patch, the ecc->size = 2048, so the result is 4 bytes.
> after this patch, the ecc->size = 512, so the result is 16 bytes.
> 
> So, align the ecc parameters the same as definition to correct
> this kind of error.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> Acked-by: Josh Wu <josh.wu@atmel.com>
> ---
> Changes in v2:
>   - Enhancement the commit message.

Pushed to l2-mtd.git. Thanks!

Brian
