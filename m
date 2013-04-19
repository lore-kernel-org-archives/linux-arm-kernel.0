From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Apr 2013 14:12:54 +0200
Subject: [Suggestion] ARM64: kernel: compiling issue,
 need implement cmpxchg64 with assembler language.
In-Reply-To: <51712E5E.2020809@asianux.com>
References: <51712E5E.2020809@asianux.com>
Message-ID: <201304191412.54601.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 April 2013, Chen Gang wrote:
> in arch/arm64/include/asm, not define the function cmpxchg64
> 
>   when compiling with allmodconfig,
>     drivers/block/blockconsole.c will need this function.
> 
>   I am not quite familiar with ARM64 (neither ARM64 assembler)
> 
>   can any member helps to send related patch ?
>     if no one have time to send related patch, I should try.
>     and I am glad to try, but need additional time resources,
>     if I try, I should finish it within this month (2013-4-30).
> 
>   welcome any suggestions or completions.

cmpxchg64 is the same as cmpxchg on 64-bit platforms, can't the
driver be changed to use the latter?

	Arnd
