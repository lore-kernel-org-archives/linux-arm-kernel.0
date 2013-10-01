From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 1 Oct 2013 19:42:02 +0200
Subject: [PATCH] RFT: ARM: gemini: convert to GENERIC_CLOCKEVENTS
In-Reply-To: <CACRpkdZygLfbE=kC6E+sRDRwZsY-Oi-HOB2mf6G7LeX-=XrcgQ@mail.gmail.com>
References: <1380625040-25912-1-git-send-email-linus.walleij@linaro.org>
 <201310011328.57653.arnd@arndb.de>
 <CACRpkdZygLfbE=kC6E+sRDRwZsY-Oi-HOB2mf6G7LeX-=XrcgQ@mail.gmail.com>
Message-ID: <201310011942.02965.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 October 2013, Linus Walleij wrote:
> As with any other platform with an active community interested in
> long-term support it'd be best if someone stepped up to do
> the necessary conversion to DT and maybe also multiplatform
> (no idea if that works with the FA526 CPU though) so we can get
> the maintenance burden down for everone involved.

Regarding multiplatform, IIRC Jonas Jensen had some issues with
ARM9 and FA526 being enabled at the same time (with mach-moxart),
which is probably easy enough to fix if necessary. You should
also be able to have a combined moxart+gemini kernel once someone
looks into multiplatform gemini. The only nonobvious part I can
see required for that is NEED_MACH_GPIO_H, and even that should
be simpler than the clockevents patch you just sent.

	Arnd
