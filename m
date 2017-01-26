From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 26 Jan 2017 07:58:09 +0200
Subject: [PATCH v2] clk: samsung: mark s3c...._clk_sleep_init() as __init
In-Reply-To: <1485380545-24815-1-git-send-email-martin@kaiser.cx>
References: <1485293599-23581-1-git-send-email-martin@kaiser.cx>
 <1485380545-24815-1-git-send-email-martin@kaiser.cx>
Message-ID: <20170126055809.fa2vgn54b7uk7wy5@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 10:42:25PM +0100, martin at kaiser.cx wrote:
> From: Martin Kaiser <martin@kaiser.cx>
> 
> These functions are referencing s3c...._clk_regs[], which are marked as
> __initdata. When compiling with CONFIG_DEBUG_SECTION_MISMATCH=y, this
> produces warnings like
> 
> WARNING: vmlinux.o(.text+0x198350):
> Section mismatch in reference from the function s3c2410_clk_sleep_init()
> to the (unknown reference) .init.data:(unknown)
> 
> Mark the s3c...._clk_sleep_init() functions as __init in
> order to fix this.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2:
> Fix the commit message, describe what the problem really is.
> (Thanks, Krzysztof)
> 
>  drivers/clk/samsung/clk-s3c2410.c |    4 ++--
>  drivers/clk/samsung/clk-s3c2412.c |    4 ++--
>  drivers/clk/samsung/clk-s3c2443.c |    4 ++--
>  drivers/clk/samsung/clk-s3c64xx.c |    4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
