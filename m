From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 19 Apr 2017 11:29:22 +0200
Subject: [PATCH 1/2] arm64: Fix power-of-ten vs. power-of-two prefixes in
 user-visible messages
In-Reply-To: <1492085867.20068.4.camel@infradead.org>
References: <20170328064831.15894-1-takahiro.akashi@linaro.org>
 <20170328065130.16019-2-takahiro.akashi@linaro.org>
 <1491207492.6020.8.camel@infradead.org>
 <20170404054144.GG16309@linaro.org>
 <e275e8c8b8d81d97b6a28b860820a27c.squirrel@twosheds.infradead.org>
 <20170404073504.GI16309@linaro.org> <1491291844.6218.25.camel@infradead.org>
 <20170404092604.GB14898@arm.com> <1492085867.20068.4.camel@infradead.org>
Message-ID: <CAMuHMdWHTZ6prRD+3FWBMV+d0huNuEA6DoGagS82DbucBSMjsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Thu, Apr 13, 2017 at 2:17 PM, David Woodhouse <dwmw2@infradead.org> wrote:
> The IEC binary prefixes (Ki, Mi, Gi, etc.) were published over twenty
> years ago. We should use them consistently, especially in user-visible
> messages.
>
> Sure, it doesn't often matter, just as *most* typos and spelling or
> grammar mistakes don't often matter. But sometimes, such misuse really
> do actually introduce ambiguity, and we should avoid that.
>
> Conversely, there is absolutely no good reason *not* to be using the
> binary prefixes. Some people once claimed to find them "ugly", or that
> they would cause confusion. But those are purely down to unfamiliarity.
>
> The perceived ugliness, and the alleged confusion, will pass with use.
>
> The correctness, and the lack of ambiguity, will not.
>
> ARM64 in particular, as a new platform, has no excuse for not using the
> IEC prefixes which predate its existence by a decade and a half.
>
> What's worse is that some people are pointing at the existing errors and
> actually claiming that they want their *new* code to be deliberately
> wrong in order to be "consistent" with what's there.
>
> So let's fix the user-visible messages in all of arch/arm64 and nip
> *that* particular stupidity in the bud...
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

For correctness:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

For the policy:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

You're gonna need a new sweep for soon to be added occurrences, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
