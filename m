From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 29 Jul 2013 14:40:33 +0200
Subject: OMAP5912 boot broken by "gpio/omap: don't create an IRQ mapping
 for every GPIO on DT"
In-Reply-To: <CACRpkdZ1E9zC_yyK=UkJSejCwb_k7sYfhNgH5NASZ8Nf-qt2KA@mail.gmail.com>
References: <alpine.DEB.2.02.1307290604310.30864@utopia.booyaka.com>
 <CACRpkdYa8Kg_-u3gB8jrB_Ws2EpLCnXBh5UGgDvi_7tQspDP7A@mail.gmail.com>
 <51F633AE.8090308@collabora.co.uk>
 <alpine.DEB.2.02.1307290943000.30864@utopia.booyaka.com>
 <D135FD6D-D4B6-4237-9866-4FFED36C03CD@collabora.co.uk>
 <CACRpkdZ1E9zC_yyK=UkJSejCwb_k7sYfhNgH5NASZ8Nf-qt2KA@mail.gmail.com>
Message-ID: <798C2D39-EE8E-4C73-A98D-63231375599C@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/2013, at 13:43, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Mon, Jul 29, 2013 at 12:19 PM, Javier Martinez Canillas
> <javier.martinez@collabora.co.uk> wrote:
> 
>> I guess the safer approach is to just revert these since they are causing
>> a regression and what the patches aims to fix as been broken since the
>> initial OMAP migration to DT anyways.
> 
> I have already reverted these and pushed to linux-next.
> 

Thanks for doing that and sorry for all the inconvenience.

Too bad this regression was not found before the patches hit mainline and they even were on linux-next for some time but shit happens :-(

> Actually input-hogs was not such a good idea either, after
> meditating on this I realized that the information about what
> GPIOs are used as interrupts is a piece of information that
> already exist in the device tree, albeit a bit distributed.
> 
> So I'm drafting an RFC to indicate how I think this should
> be solved.
> 

Great, I hope we can finally have a good solution for this long standing issue.

> Yours,
> Linus Walleij

Best regards,
Javier
