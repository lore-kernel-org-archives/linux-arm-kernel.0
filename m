From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 16 Nov 2015 19:48:56 -0500 (EST)
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <HK2PR06MB056142FFDA4E99A764DF9ECB8A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511161515100.5826@knanqh.ubzr>
 <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
 <HK2PR06MB056142FFDA4E99A764DF9ECB8A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <alpine.LFD.2.20.1511161730030.5826@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Nov 2015, Chris Brandt wrote:

> > New sections (lots of them) were added as well since the introduction
> > of XIP kernel with no consideration for XIP usage.
> 
> So I've noticed. As far as I can tell, the XIP kernel stuff broke years
> ago.

That, of course, brings the question about keeping XIP around.

> > I think the only way to fix it properly is to have a separate linker
> > script for XIP usage with proper (and obvious) section placement.
> 
> I guess then the parts of the kernel that refer to section locations
> need to be looked at again. As you can see from my other patches,
> there's a bit of miss-match that I was trying to align.

I don't think that's a big issue. Those section locations are obtained 
from symbols that the linker script creates explicitly.

> So at this point...I'm assume all my XIP 'hacks' are being rejected.

Pretty much.  Everything can be fixed at once with a new linker script.

> As for making a new XIP-only linker script, note that I really only
> work with the ARMv7. I know the M4 and M5 guys do XIP_KERNEL builds,
> but I've got no way of testing their XIP_KERNEL builds or knowing
> what will break.

Things can hardly be worse than they are right now.


Nicolas
