From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 18 Nov 2015 14:44:10 -0500 (EST)
Subject: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <HK2PR06MB0561BAC75F605C9C51966B948A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <1447697140-4099-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511161515100.5826@knanqh.ubzr>
 <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
 <HK2PR06MB056196B2E169A504A16ED9738A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511171155240.5826@knanqh.ubzr>
 <HK2PR06MB0561B7675F17A81B54A65CA28A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511172129060.22569@knanqh.ubzr>
 <HK2PR06MB0561077CA74074E175561D7F8A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511181204240.22569@knanqh.ubzr>
 <HK2PR06MB0561BAC75F605C9C51966B948A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <alpine.LFD.2.20.1511181437030.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Nov 2015, Chris Brandt wrote:

> > Sure.  You should start by splitting the XIP stuff out to a separate
> > script so functionally it is the same (broken) end result.  And from
> > there adding incremental fixes to the XIP script.
> 
> More or less that's what I'm doing now on my system. You can diff the 2 in order to see what I've removed.
> 
> But wait...you said 'the last step' was to add a 2nd linker file and change the Makefiles to use it.
> 
> 
> Are you saying I should first submit a patch that simply adds the new file, but not hook it up to any Makefiles yet?
> Then, once it has been updated a few times and is in better shape, I submit another patch that hooks it up with the Makefiles so I can then finally remove the XIP_KERNEL parts from the current vmlinux.lds.S?

Well... I'm of the opinion now that the first patch should be the 
creation of the new script being a copy of the original with the XIP 
conditionals removed from both, plus the makefile changes. That should 
be easy to verify that nothing changed result wise, and then additional 
patches could bring XIP efinements on top without disturbing the non-XIP 
case.


Nicolas
