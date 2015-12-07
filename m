From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 07 Dec 2015 12:13:55 +0100
Subject: [PATCH v5 3/4] arm64: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <56655EC8.6030905@nvidia.com>
References: <1449000658-11475-1-git-send-email-dcashman@android.com>
 <1449000658-11475-4-git-send-email-dcashman@android.com>
 <56655EC8.6030905@nvidia.com>
Message-ID: <1720878.JdEcLd8bhL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 07 December 2015 10:26:16 Jon Hunter wrote:
> 
> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index af461b935137..e59a75a308bc 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -51,7 +51,7 @@ unsigned long arch_mmap_rnd(void)
>  {
>         unsigned long rnd;
>  
> -ifdef CONFIG_COMPAT
> +#ifdef CONFIG_COMPAT
>         if (test_thread_flag(TIF_32BIT))
>                 rnd = (unsigned long)get_random_int() % (1 << mmap_rnd_compat_bits);
>         else
> 
> Cheers
> 

Ideally we'd remove the #ifdef around the mmap_rnd_compat_bits declaration
and change this code to use

	if (IS_ENABLED(CONFIG_COMPAT) && test_thread_flag(TIF_32BIT))

	Arnd
