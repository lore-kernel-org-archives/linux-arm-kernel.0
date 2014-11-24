From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Nov 2014 16:29:42 +0100
Subject: [PATCH] ARM: PJ4: allow building in Thumb-2 mode
In-Reply-To: <1416830200-11114-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1416830200-11114-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <2078609.NLHB18YoOo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 November 2014 12:56:40 Ard Biesheuvel wrote:
> Two files that get included when building the multi_v7_defconfig target
> fail to build when selecting THUMB2_KERNEL for this configuration.
> 
> In both cases, we can just build the file as ARM code, as none of its
> symbols are exported to modules, so there are no interworking concerns.
> In the iwmmxt.S case, add ENDPROC() declarations so the symbols are
> annotated as functions, resulting in the linker to emit the appropriate
> mode switches.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Ah, very nice. I tried this before, but my version didn't actually
work, presumably because I didn't know about the ENDPROC() stuff.

Have you tested this on a machine that has IWMMXT enabled?

	Arnd
