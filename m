From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Wed, 23 Aug 2017 12:46:28 -0500
Subject: [PATCH v2] ARM: vdso: Define vdso_{start,end} as array
In-Reply-To: <20170823142419.1811665-1-arnd@arndb.de>
References: <20170823142419.1811665-1-arnd@arndb.de>
Message-ID: <87tw0ytbwr.fsf@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> gcc-8 correctly points out that reading four bytes from a pointer to a
> 'char' variable is wrong
>
> arch/arm/kernel/vdso.c: In function 'vdso_init':
> arch/arm/kernel/vdso.c:200:6: error: '__builtin_memcmp_eq' reading 4 bytes from a region of size 1 [-Werror=stringop-overflow=]
>
> However, in this case the variable just stands for the beginning of the
> vdso and is not actually a 'char', so the code is doing what it is meant
> to do.
>
> This uses the same approach as arm64 and x86, declaring the addresses
> as char arrays.
>
> See also: dbbb08f500d6 ("arm64, vdso: Define vdso_{start,end} as array")
>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nathan Lynch <nathan_lynch@mentor.com>

Thanks!
