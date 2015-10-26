From: rabin@rab.in (Rabin Vincent)
Date: Mon, 26 Oct 2015 18:17:50 +0100
Subject: [PATCH] arm: Omit fixmap calls in text patching code if
 CONFIG_MMU=n
In-Reply-To: <1445846092-1979-1-git-send-email-geert@linux-m68k.org>
References: <1445846092-1979-1-git-send-email-geert@linux-m68k.org>
Message-ID: <20151026171750.GA30888@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 08:54:52AM +0100, Geert Uytterhoeven wrote:
> Protect the calls to set_fixmap() and clear_fixmap() by #ifdef >
> CONFIG_MMU to fix this.
> 
> Fixes: commit ab0615e2d6fb0747 ("arm: use fixmap for text patching when text is RO")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Since both DEBUG_SET_MODULE_RONX and DEBUG_RODATA depend on MMU, we'll
never get to this code on !MMU so this ifdef build fix should be ok.

Acked-by: Rabin Vincent <rabin@rab.in>

Thanks.
