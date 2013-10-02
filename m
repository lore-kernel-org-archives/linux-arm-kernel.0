From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 Oct 2013 01:58:58 +0200
Subject: [PATCH] RFT: ARM: gemini: convert to GENERIC_CLOCKEVENTS
In-Reply-To: <CACRpkdZM9k2V+VHxhp6gLtGGegU=+2nMGFg7rfHs6uwoqu=Hrg@mail.gmail.com>
References: <1380625040-25912-1-git-send-email-linus.walleij@linaro.org>
 <201310011942.02965.arnd@arndb.de>
 <CACRpkdZM9k2V+VHxhp6gLtGGegU=+2nMGFg7rfHs6uwoqu=Hrg@mail.gmail.com>
Message-ID: <201310030158.58437.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 October 2013, Linus Walleij wrote:
> On Tue, Oct 1, 2013 at 7:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> > Regarding multiplatform, IIRC Jonas Jensen had some issues with
> > ARM9 and FA526 being enabled at the same time (with mach-moxart),
> > which is probably easy enough to fix if necessary. You should
> > also be able to have a combined moxart+gemini kernel once someone
> > looks into multiplatform gemini. The only nonobvious part I can
> > see required for that is NEED_MACH_GPIO_H, and even that should
> > be simpler than the clockevents patch you just sent.
> 
> I sent a patch to delete NEED_MACH_GPIO_H as well and already
> applied it to the GPIO tree, it was a piece of cake (unless I have
> now unwittingly broken something).

Ah, cool. Upon  brief look I could not find any users for the other
header files, so I guess we can try to just go ahead and move them
all out of include/mach/ to mach-gemini/*.h or to include/debug.

On second look, we need to convert it to MULTI_IRQ_HANDLER first.

	Arnd
