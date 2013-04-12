From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 12 Apr 2013 11:30:39 +0800
Subject: [PATCH v2] ARM: imx: Select GENERIC_ALLOCATOR
In-Reply-To: <1365718803-28274-1-git-send-email-festevam@gmail.com>
References: <1365718803-28274-1-git-send-email-festevam@gmail.com>
Message-ID: <20130412033037.GH16970@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 07:20:03PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit 391630c5bf11 (media: coda: use genalloc API) the following build
> error happens with imx_v4_v5_defconfig:
> 
> drivers/built-in.o: In function 'coda_remove':
> clk-composite.c:(.text+0x112180): undefined reference to 'gen_pool_free'
> drivers/built-in.o: In function 'coda_probe':
> clk-composite.c:(.text+0x112310): undefined reference to 'of_get_named_gen_pool'
> clk-composite.c:(.text+0x1123f4): undefined reference to 'gen_pool_alloc'
> clk-composite.c:(.text+0x11240c): undefined reference to 'gen_pool_virt_to_phys'
> clk-composite.c:(.text+0x112458): undefined reference to 'dev_get_gen_pool'
> 
> Select GENERIC_ALLOCATOR and get rid of the custom IRAM_ALLOC.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Queued for 3.10-rc, thanks.
