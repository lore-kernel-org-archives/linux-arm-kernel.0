From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 27 Oct 2011 13:48:55 +0530
Subject: [PATCH v4] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <1318907324-17046-1-git-send-email-Barry.Song@csr.com>
References: <1318907324-17046-1-git-send-email-Barry.Song@csr.com>
Message-ID: <1319703535.20054.30.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-10-17 at 20:08 -0700, Barry Song wrote:
> From: Rongjun Ying <Rongjun.Ying@csr.com>
> 
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  -v4:
>  add error handler in probe;
>  free resource in remove;
>  add necessary comments in source codes;
>  fix the mismatch of license between file head and MODULE_LINCENSE;
>  define MACRO to replace magic number for xlen/dma_width boundary.
Barry,

You should _always_ run checkpatch before sending patches. It should
have 0 errors.

ERROR: trailing whitespace
#773: FILE: drivers/dma/sirf-dma.c:649:
+^I$


Also there are bunch of 80char warning, see if you can reduce/eliminate
them without sacrificing the code readability, and looking at them it
seems possible

Also, Please ensure you send patches which compile with ZERO warnings:
drivers/dma/sirf-dma.c: In function 'sirfsoc_dma_probe':
drivers/dma/sirf-dma.c:616: warning: assignment from incompatible pointer type
drivers/dma/sirf-dma.c:617: warning: assignment from incompatible pointer type
which comes from the fact that your prep_interleaved_dma does not have
last argument of flags.
On the second one you have not rebased to patch from Jassi which I
applied after converting direction stuff.

-- 
~Vinod
