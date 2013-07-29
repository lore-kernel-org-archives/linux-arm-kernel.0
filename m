From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Jul 2013 13:43:09 +0200
Subject: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping
 for every GPIO on DT"
In-Reply-To: <D135FD6D-D4B6-4237-9866-4FFED36C03CD@collabora.co.uk>
References: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com>
 <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com>
 <51F633AE.8090308@collabora.co.uk>
 <alpine.DEB.2.02.1307290943000.30864@utopia.booyaka.com>
 <D135FD6D-D4B6-4237-9866-4FFED36C03CD@collabora.co.uk>
Message-ID: <CACRpkdZ1E9zC_yyK=UkJSejCwb_k7sYfhNgH5NASZ8Nf-qt2KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 12:19 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:

> I guess the safer approach is to just revert these since they are causing
> a regression and what the patches aims to fix as been broken since the
> initial OMAP migration to DT anyways.

I have already reverted these and pushed to linux-next.

Actually input-hogs was not such a good idea either, after
meditating on this I realized that the information about what
GPIOs are used as interrupts is a piece of information that
already exist in the device tree, albeit a bit distributed.

So I'm drafting an RFC to indicate how I think this should
be solved.

Yours,
Linus Walleij
