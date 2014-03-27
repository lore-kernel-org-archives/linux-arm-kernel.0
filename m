From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 27 Mar 2014 11:41:45 +0000
Subject: [PATCH] arm64: Fix memory layout typo
In-Reply-To: <1395800601-17088-1-git-send-email-zhangwm@marvell.com>
References: <1395800601-17088-1-git-send-email-zhangwm@marvell.com>
Message-ID: <20140327114144.GB20298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 26, 2014 at 02:23:21AM +0000, Neil Zhang wrote:
> Signed-off-by: Neil Zhang <zhangwm@marvell.com>
> ---
>  Documentation/arm64/memory.txt |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/arm64/memory.txt b/Documentation/arm64/memory.txt
> index 5e054bf..c2765e2 100644
> --- a/Documentation/arm64/memory.txt
> +++ b/Documentation/arm64/memory.txt
> @@ -39,7 +39,7 @@ ffffffbffbc00000	ffffffbffbdfffff	   2MB		earlyprintk device
>  
>  ffffffbffbe00000	ffffffbffbe0ffff	  64KB		PCI I/O space
>  
> -ffffffbffbe10000	ffffffbcffffffff	  ~2MB		[guard]
> +ffffffbffbe10000	ffffffbffbffffff	  ~2MB		[guard]
>  
>  ffffffbffc000000	ffffffbfffffffff	  64MB		modules

I fixed this in linux-next already as part of 22bd1c91fe1 (arm64: Extend
the PCI I/O space to 16MB).

Thanks.

-- 
Catalin
