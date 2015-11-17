From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 17 Nov 2015 12:24:15 -0500 (EST)
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <HK2PR06MB056175E6E4356DD8C3566D758A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511161515100.5826@knanqh.ubzr>
 <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
 <HK2PR06MB056142FFDA4E99A764DF9ECB8A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161730030.5826@knanqh.ubzr>
 <HK2PR06MB05614D47A9C35ECB4CA72D3F8A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511162127180.5826@knanqh.ubzr>
 <HK2PR06MB056175E6E4356DD8C3566D758A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <alpine.LFD.2.20.1511171200400.5826@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, Chris Brandt wrote:

> > Absolutely.  I'll be glad to review your patches.
> 
> What do you think about this submission?
> I think it still holds true regardless of the incorrect sectioning.
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/384354.html

This patch is correct.

> >> Of course, there are still some other XIP patches needed (like you
> >> can't use text areas as a temporary stack on boot), but the sections
> >> are a pretty logical place to start.
> >
> > Maybe this can be prevented automatically by the linker with some
> > read-only memory regions or the like.
> 
> I think this one is more of a coding issue.
> These were the attempts to fix the temporary stack issue:
> 
> My first patch:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/357106.html

I think this ought to be fixed regardless of the XIP issue.

> Magnus's try:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/383394.html

This one is wrong as it clobbers r11.


Nicolas
