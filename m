From: bp@alien8.de (Borislav Petkov)
Date: Tue, 15 May 2018 11:23:33 +0200
Subject: [PATCH] edac: altera: Fix ARM64 warning
In-Reply-To: <1526317441-4996-1-git-send-email-thor.thayer@linux.intel.com>
References: <1526317441-4996-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <20180515092333.GA11928@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 12:04:01PM -0500, thor.thayer at linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> The kbuild test robot reported the following warning on altera_edac.c:
> 
> drivers//edac/altera_edac.c: In function 'ocram_free_mem':
> drivers//edac/altera_edac.c:1410:42: warning: cast from pointer to integer
>       of different size [-Wpointer-to-int-cast]
>   gen_pool_free((struct gen_pool *)other, (u32)p, size);
>                                            ^^^
> After adding support for ARM64 architectures, the unsigned long parameter
> is 64bits and causes a build warning with arm64-allyesconfig
> Fix by casting to the correct size (unsigned long) instead of u32.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>  drivers/edac/altera_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
