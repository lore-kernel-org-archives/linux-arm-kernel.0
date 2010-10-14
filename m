From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 14 Oct 2010 17:39:22 +0900
Subject: [rfc v3 1/2] ARM: Add zboot support for SuperH Mobile ARM
In-Reply-To: <20101014080600.320072951@vergenet.net>
References: <20101014080317.211725411@vergenet.net>
	<20101014080600.320072951@vergenet.net>
Message-ID: <AANLkTinaJjCuZznz83tNxznE1DN8=ZQGnOUf7OSE47Oa@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 14, 2010 at 5:03 PM, Simon Horman <horms@horms.net> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> When CONFIG_ZBOOT_ROM is selected, the resulting zImage file will be small
> boot loader and may be burned to rom or flash.
>
> This is the non-board-specific framework portion of this patch-set.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
>
> ---
> v2:
> * As suggested by Magnus Damm; Implemented by Simon Horman
> ?- Initialise atags in framework and pass atags to kernel

[only keeping reworked atags]

> +__atags:@ tag #1
> + ? ? ? .long ? 12 ? ? ? ? ? ? ? ? ? ? ?@ tag->hdr.size = tag_size(tag_core);
> + ? ? ? .long ? 0x54410001 ? ? ? ? ? ? ?@ tag->hdr.tag = ATAG_CORE;
> + ? ? ? .long ? 0 ? ? ? ? ? ? ? ? ? ? ? @ tag->u.core.flags = 0;
> + ? ? ? .long ? 0 ? ? ? ? ? ? ? ? ? ? ? @ tag->u.core.pagesize = 0;
> + ? ? ? .long ? 0 ? ? ? ? ? ? ? ? ? ? ? @ tag->u.core.rootdev = 0;
> + ? ? ? @ tag #2
> + ? ? ? .long ? 8 ? ? ? ? ? ? ? ? ? ? ? @ tag->hdr.size = tag_size(tag_mem32);
> + ? ? ? .long ? 0x54410002 ? ? ? ? ? ? ?@ tag->hdr.tag = ATAG_MEM;
> + ? ? ? .long ? CONFIG_MEMORY_SIZE ? ? ?@ tag->u.mem.size = CONFIG_MEMORY_SIZE;
> + ? ? ? .long ? CONFIG_MEMORY_START ? ? @ @ tag->u.mem.start = CONFIG_MEMORY_START;
> + ? ? ? @ tag #3
> + ? ? ? .long ? 0 ? ? ? ? ? ? ? ? ? ? ? @ tag->hdr.size = 0
> + ? ? ? .long ? 0 ? ? ? ? ? ? ? ? ? ? ? @ tag->hdr.tag = ATAG_NONE;

Yes, this looks much better. Thank you!

/ magnus
