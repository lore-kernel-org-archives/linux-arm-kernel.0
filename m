From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 7 Oct 2013 12:09:22 +0200
Subject: [PATCH 3/5] DRM: Armada: Add support for ARGB 32x64 or 64x32
 hardware cursors
In-Reply-To: <20131007094008.GH12758@n2100.arm.linux.org.uk>
References: <20131006220728.GG12758@n2100.arm.linux.org.uk>
 <E1VSwWS-0000i7-4f@rmk-PC.arm.linux.org.uk>
 <20131007110141.27f1ac25@armhf>
 <20131007094008.GH12758@n2100.arm.linux.org.uk>
Message-ID: <20131007120922.47df03b6@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Oct 2013 10:40:08 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> > > This patch adds ARGB hardware cursor support to the DRM driver for the
> > > Marvell Armada SoCs.  ARGB cursors are supported at either 32x64 or
> > > 64x32 resolutions.  
> > 	[snip]
> > 
> > I don't see the interest of such cursors. Actually, most often, the
> > cursors are 64x64 and 'A' is either 0 or 0xff. As the Armada 510
> > supports 64x64 cursors with transparency, it would be more useful to
> > implement these ones...  
> 
> Sorry, you're completely wrong there.  Xorg uses an alphablended cursor.
> This patch is a result of trialling each of the Armada's cursor options
> and this is the only one which results in a reasonable looking cursor.

Strange. I am using the 64x64 cursor with transparency of the 510 for
many months and I never saw any problem.

If you absolutely want to have all transparency shades, you should
accept 64x64 cursors and test if they may be rendered as 64x32 or 32x64,
i.e. test that there is only pure transparency in the non-rendered
rectangles...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
