From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 19:52:13 +0000
Subject: [PATCH v3 26/31] arm64: Miscellaneous library functions
In-Reply-To: <1347035226-18649-27-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-27-git-send-email-catalin.marinas@arm.com>
Message-ID: <201209071952.14309.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Catalin Marinas wrote:

> +/*
> + * Use compiler builtins for simple inline operations.
> + */
> +static inline unsigned long __ffs(unsigned long word)
> +{
> +	return __builtin_ffsl(word) - 1;
> +}
> +
> +static inline int ffs(int x)
> +{
> +	return __builtin_ffs(x);
> +}
> +
> +static inline unsigned long __fls(unsigned long word)
> +{
> +	return BITS_PER_LONG - 1 - __builtin_clzl(word);
> +}
> +
> +static inline int fls(int x)
> +{
> +	return x ? sizeof(x) * BITS_PER_BYTE - __builtin_clz(x) : 0;
> +}

Still waiting for the generic version of these.

	Arnd
