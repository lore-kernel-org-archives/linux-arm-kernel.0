From: sjg@chromium.org (Simon Glass)
Date: Mon, 4 Apr 2011 22:46:58 -0700
Subject: [PATCH] ARM: BUG() dies silently
In-Reply-To: <BANLkTimhk_G0fapzHAf0Gc-XhqT0qu+VbQ@mail.gmail.com>
References: <1301602523-9906-1-git-send-email-omar.ramirez@ti.com>
	<BANLkTimtAcPLmcFKoHkCtWcJipy+rSSP+A@mail.gmail.com>
	<4D959058.7010606@codeaurora.org>
	<BANLkTim8GhUAZ7L-MiJiqi6xM=P_Q8kqfg@mail.gmail.com>
	<4D981EAB.8070209@codeaurora.org>
	<BANLkTimhk_G0fapzHAf0Gc-XhqT0qu+VbQ@mail.gmail.com>
Message-ID: <BANLkTinvbd9hmcsxhWQtM70uBzgv7sESTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 4, 2011 at 7:29 PM, Ramirez Luna, Omar <omar.ramirez@ti.com> wrote:
...
> I am using CONFIG_BUG=y, however I don't have CONFIG_DEBUG_BUGVERBOSE
> and hence I fall into the part which doesn't print the file and the
> line where the BUG was found.
>
> With Simon's patch if my .config had:
>
> CONFIG_BUG=y
> CONFIG_GENERIC_BUG is not set

In this case the patch is like a nop.

> CONFIG_DEBUG_BUGVERBOSE is not set
>
> I would fall into the same BUG definition that is causing issues:
>
> #define BUG() ? ? ? ? ? do { *(int *)0 = 0; } while (1)
>
> OTOH, is not like "Use generic BUG() handler" gives the choice of
> removing GENERIC_BUG given that it is not prompted in menuconfig and
> auto selected, if this is the intention is there any reason to keep
> the #else part of /* not CONFIG_GENERIC_BUG */? there is no way we can
> use it with this patch, right?

Well, er, the intention is that you use the patch. I kept the old code
around since people can then simply change the Kconfig option and be
back where they were, as indeed you have. I would be happy to remove
the old behavior, but I was concerned about a possible roasting in
this forum. Changing long-established behavior is sometimes tricky.

Regards,
Simon

>
> Regards,
>
> Omar
>
