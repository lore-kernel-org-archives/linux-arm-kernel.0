From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 6 Jan 2015 09:15:48 +0000
Subject: [PATCH 3/8] memblock: add physmem to memblock_dump_all() output
In-Reply-To: <1419275322-29811-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1419275322-29811-1-git-send-email-ard.biesheuvel@linaro.org>
 <1419275322-29811-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150106091548.GH3163@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Adding Andrew, linux-mm and lkml)

On Mon, 22 Dec, at 07:08:37PM, Ard Biesheuvel wrote:
> If CONFIG_HAVE_MEMBLOCK_PHYS_MAP is set, there is a third memblock
> map called 'physmem'. Add it to the output of memblock_dump_all().
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  mm/memblock.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 252b77bdf65e..c27353beb260 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1522,6 +1522,9 @@ void __init_memblock __memblock_dump_all(void)
>  
>  	memblock_dump(&memblock.memory, "memory");
>  	memblock_dump(&memblock.reserved, "reserved");
> +#ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
> +	memblock_dump(&memblock.physmem, "physmem");
> +#endif
>  }
>  
>  void __init memblock_allow_resize(void)
> -- 
> 1.8.3.2
> 

-- 
Matt Fleming, Intel Open Source Technology Center
