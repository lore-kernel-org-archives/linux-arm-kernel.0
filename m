From: olof@lixom.net (Olof Johansson)
Date: Thu, 9 Feb 2012 16:17:54 -0800
Subject: [PATCH v2] arm:orion: Fix USB phy for orion5x.
In-Reply-To: <alpine.LFD.2.02.1202081502320.1656@xanadu.home>
References: <1328712767-25725-1-git-send-email-andrew@lunn.ch>
 <alpine.LFD.2.02.1202081502320.1656@xanadu.home>
Message-ID: <20120210001754.GA14805@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 03:06:19PM -0800, Nicolas Pitre wrote:
> On Wed, 8 Feb 2012, Andrew Lunn wrote:
> 
> > The patch "ARM: orion: Consolidate USB platform setup code.", commit
> > 4fcd3f374a928081d391cd9a570afe3b2c692fdc broke USB on TS-7800 and
> > other orion5x boards, because the wrong type of PHY was being passed
> > to the EHCI driver in the platform data. Orion5x needs EHCI_PHY_ORION
> > and all the others want EHCI_PHY_NA.
> > 
> > Allow the mach- code to tell the generic plat-orion code which USB PHY
> > enum to place into the platform data.
> > 
> > Versio 2: Rebase to v3.3-rc2.
> > 
> > Reported-by: Ambroz Bizjak <ambrop7@gmail.com>
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Tested-by: Ambroz Bizjak <ambrop7@gmail.com>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> This also needs a CC: stable at vger.kernel.org

Thanks, appled to arm-soc fixes branch for 3.3-rc. Since they conflict when
applied to 3.2 I'll let you handle the -stable submission separately instead of
cc:ing in the commit.

-Olof
