From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 04 Feb 2012 15:00:14 -0500 (EST)
Subject: [PATCHv2] [ARM][Orion] Fix Orion5x GPIO regression
In-Reply-To: <1328362326-10832-1-git-send-email-andrew@lunn.ch>
References: <1328362326-10832-1-git-send-email-andrew@lunn.ch>
Message-ID: <alpine.LFD.2.02.1202041456550.2759@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 4 Feb 2012, Andrew Lunn wrote:

> Patchset "ARM: orion: Refactor the MPP code common in the orion
> platform" broke at least Orion5x based platforms. These platforms have
> pins configured as GPIO when the selector is not 0x0. However the
> common code assumes the selector is always 0x0 for a GPIO lines. It
> then ignores the GPIO bits in the MPP definitions, resulting in that
> Orion5x machines cannot correctly configure there GPIO lines.
> 
> The Fix removes the assumption that the selector is always 0x0.
> In order that none GPIO configurations are correctly blocked,
> Kirkwood and mv78xx0 MPP definitions are corrected to only set the
> GPIO bits for GPIO configurations.
> 
> This second version does not contain any whitespace changes.

The patch doesn't apply to v3.3-rc2.  Changes to  
arch/arm/mach-kirkwood/mpp.h are rejected, meaning the whole 160 lines.  
Could you have a look please?


Nicolas
