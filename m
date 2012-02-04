From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 04 Feb 2012 15:09:25 -0500 (EST)
Subject: [PATCH] arm:orion: Fix USB phy for orion5x.
In-Reply-To: <1328374202-31413-1-git-send-email-andrew@lunn.ch>
References: <1328374202-31413-1-git-send-email-andrew@lunn.ch>
Message-ID: <alpine.LFD.2.02.1202041508000.2759@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 4 Feb 2012, Andrew Lunn wrote:

> The patch "ARM: orion: Consolidate USB platform setup code.", commit
> 4fcd3f374a928081d391cd9a570afe3b2c692fdc broke USB on TS-7800 and
> other orion5x boards, because the wrong type of PHY was being passed
> to the EHCI driver in the platform data. Orion5x needs EHCI_PHY_ORION
> and all the others want EHCI_PHY_NA.
> 
> Allow the mach- code to tell the generic plat-orion code which USB PHY
> enum to place into the platform data.
> 
> Reported-by: Ambroz Bizjak <ambrop7@gmail.com>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Ambroz Bizjak <ambrop7@gmail.com>

Like your other patch, none of this apply to v3.3-rc2 either.  What base 
kernel did you use?


Nicolas
