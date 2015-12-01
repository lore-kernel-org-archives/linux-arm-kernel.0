From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 1 Dec 2015 10:28:41 +0100
Subject: [PATCH v3 08/10] arm64: Promote KERNEL_START/KERNEL_END
 definitions to a header file
In-Reply-To: <1448559168-8363-9-git-send-email-james.morse@arm.com>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-9-git-send-email-james.morse@arm.com>
Message-ID: <20151201092841.GC21222@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2015-11-26 17:32:46, James Morse wrote:
> KERNEL_START and KERNEL_END are useful outside head.S, move them to a
> header file.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Pavel	 Machek <pavel@ucw.cz>

> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 853953cd1f08..5773a6629f10 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -70,6 +70,9 @@
>  
>  #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 4))
>  
> +#define KERNEL_START      _text
> +#define KERNEL_END        _end
> +
>  /*
>   * Physical vs virtual RAM address space conversion.  These are
>   * private definitions which should NOT be used outside memory.h
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 7cec62a76f50..c58ede3398db 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -48,9 +48,6 @@
>  #error TEXT_OFFSET must be less than 2MB
>  #endif
>  
> -#define KERNEL_START	_text
> -#define KERNEL_END	_end
> -
>  /*
>   * Kernel startup entry point.
>   * ---------------------------

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
