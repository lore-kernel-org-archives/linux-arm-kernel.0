From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Apr 2015 12:40:52 +0200
Subject: [PATCH] modpost: add .text.fixup to OTHER_TEXT_SECTIONS
In-Reply-To: <5641468.B6ky8Ch4vY@wuerfel>
References: <5641468.B6ky8Ch4vY@wuerfel>
Message-ID: <2576764.pLO2LLU9HG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 April 2015 11:48:31 Arnd Bergmann wrote:
> Two correct patches for the 4.1 release clashed in a way that
> caused modpost to fail badly, with hundreds warnings like
> 
> WARNING: vmlinux.o(__ex_table+0x1014): Section mismatch in reference from the (unknown reference) (unknown) to the (unknown reference) .text.fixup:(unknown)
> 
> The fix, as suggested by the warnings, is to add the new .text.fixup
> section into the OTHER_TEXT_SECTIONS list.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 52dc0595d540 ("modpost: handle relocations mismatch in __ex_table")
> Fixes: c4a84ae39b4a ("ARM: 8322/1: keep .text and .fixup regions closer together")
> ---
> The mostpost patch has not made it into 4.1 yet, so it's probably best to
> add this fix on top of that to avoid breaking when Linus pulls it in.
> 

Nevermind this patch, I'm way behind the times apparently, and multiple
improvements of the original code have made it in since it was broken.

	Arnd
