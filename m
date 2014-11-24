From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Nov 2014 18:17:02 +0100
Subject: [PATCH] ARM: PJ4: allow building in Thumb-2 mode
In-Reply-To: <CAKv+Gu_YuHbO7+jusczcJTHF8fM4pF1z2h55BZK0mrHK702z_A@mail.gmail.com>
References: <1416830200-11114-1-git-send-email-ard.biesheuvel@linaro.org>
 <2078609.NLHB18YoOo@wuerfel>
 <CAKv+Gu_YuHbO7+jusczcJTHF8fM4pF1z2h55BZK0mrHK702z_A@mail.gmail.com>
Message-ID: <4653047.WBmUTsHC57@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 November 2014 16:34:47 Ard Biesheuvel wrote:
> On 24 November 2014 at 16:29, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 24 November 2014 12:56:40 Ard Biesheuvel wrote:
> >> Two files that get included when building the multi_v7_defconfig target
> >> fail to build when selecting THUMB2_KERNEL for this configuration.
> >>
> >> In both cases, we can just build the file as ARM code, as none of its
> >> symbols are exported to modules, so there are no interworking concerns.
> >> In the iwmmxt.S case, add ENDPROC() declarations so the symbols are
> >> annotated as functions, resulting in the linker to emit the appropriate
> >> mode switches.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > Ah, very nice. I tried this before, but my version didn't actually
> > work, presumably because I didn't know about the ENDPROC() stuff.
> >
> > Have you tested this on a machine that has IWMMXT enabled?
> >
> 
> No, I don't have access to such a machine, unfortunately.

Adding a few mvebu folks to Cc, maybe one of them can test your patch.
It's also possible that Olof or Kevin have a PJ4 machine with iwmmxt 
in their boot farms.

	Arnd
