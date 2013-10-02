From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Oct 2013 09:52:42 +0200
Subject: [PATCH] RFT: ARM: gemini: convert to GENERIC_CLOCKEVENTS
In-Reply-To: <201310011942.02965.arnd@arndb.de>
References: <1380625040-25912-1-git-send-email-linus.walleij@linaro.org>
 <201310011328.57653.arnd@arndb.de>
 <CACRpkdZygLfbE=kC6E+sRDRwZsY-Oi-HOB2mf6G7LeX-=XrcgQ@mail.gmail.com>
 <201310011942.02965.arnd@arndb.de>
Message-ID: <CACRpkdZM9k2V+VHxhp6gLtGGegU=+2nMGFg7rfHs6uwoqu=Hrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 1, 2013 at 7:42 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 01 October 2013, Linus Walleij wrote:
>> As with any other platform with an active community interested in
>> long-term support it'd be best if someone stepped up to do
>> the necessary conversion to DT and maybe also multiplatform
>> (no idea if that works with the FA526 CPU though) so we can get
>> the maintenance burden down for everone involved.
>
> Regarding multiplatform, IIRC Jonas Jensen had some issues with
> ARM9 and FA526 being enabled at the same time (with mach-moxart),
> which is probably easy enough to fix if necessary. You should
> also be able to have a combined moxart+gemini kernel once someone
> looks into multiplatform gemini. The only nonobvious part I can
> see required for that is NEED_MACH_GPIO_H, and even that should
> be simpler than the clockevents patch you just sent.

I sent a patch to delete NEED_MACH_GPIO_H as well and already
applied it to the GPIO tree, it was a piece of cake (unless I have
now unwittingly broken something).

Yours,
Linus Walleij
