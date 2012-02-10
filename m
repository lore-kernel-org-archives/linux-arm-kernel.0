From: olof@lixom.net (Olof Johansson)
Date: Thu, 9 Feb 2012 16:18:08 -0800
Subject: [PATCHv3] [ARM][Orion] Fix Orion5x GPIO regression from MPP
 cleanup
In-Reply-To: <alpine.LFD.2.02.1202081508040.1656@xanadu.home>
References: <1328712727-25679-1-git-send-email-andrew@lunn.ch>
 <alpine.LFD.2.02.1202081508040.1656@xanadu.home>
Message-ID: <20120210001808.GB14805@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 03:09:05PM -0800, Nicolas Pitre wrote:
> On Wed, 8 Feb 2012, Andrew Lunn wrote:
> 
> > Patchset "ARM: orion: Refactor the MPP code common in the orion
> > platform" broke at least Orion5x based platforms. These platforms have
> > pins configured as GPIO when the selector is not 0x0. However the
> > common code assumes the selector is always 0x0 for a GPIO lines. It
> > then ignores the GPIO bits in the MPP definitions, resulting in that
> > Orion5x machines cannot correctly configure there GPIO lines.
> > 
> > The Fix removes the assumption that the selector is always 0x0.
> > In order that none GPIO configurations are correctly blocked,
> > Kirkwood and mv78xx0 MPP definitions are corrected to only set the
> > GPIO bits for GPIO configurations.
> > 
> > This third version, which does not contain any whitespace changes,
> > and is rebased on v3.3-rc2.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> This needs a CC: stable at vger.kernel.org

Thanks, appled to arm-soc fixes branch for 3.3-rc. Since they conflict when
applied to 3.2 I'll let you handle the -stable submission separately instead of
cc:ing in the commit.

-Olof
