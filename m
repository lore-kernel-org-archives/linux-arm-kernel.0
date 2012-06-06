From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 5 Jun 2012 18:28:07 -0600 (MDT)
Subject: [PATCH] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
In-Reply-To: <alpine.DEB.2.00.1206051636080.30737@utopia.booyaka.com>
References: <alpine.DEB.2.00.1205251546160.25520@utopia.booyaka.com>
 <4FC4C4FA.1070403@ti.com>
 <alpine.DEB.2.00.1206051636080.30737@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1206051737000.30737@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Beno?t

On Tue, 5 Jun 2012, Paul Walmsley wrote:

> On Tue, 29 May 2012, Cousson, Benoit wrote:
> 
> > So in fact, I'm wondering if a new flag is needed. We can potentially 
> > apply that if idlemodes == (SIDLE_FORCE | SIDLE_NO).
> > 
> > We need to check which IP will have that to ensure that does not add 
> > any side-effects.
> 
> I guess that means me :-)

I looked at a few TRMs.  Based on that incomplete survey, the above 
behavior would probably work for existing chips.

But it seems perverse to assume that it is generally safe to set an IP 
block to force-idle while it's being used.  That seems really dependent on 
the IP block's integration.

So in terms of a general fix, the flag approach seems safest to me in the 
long run.

The other advantage of using a flag is that it indicates that this is a 
hardware workaround; something that it would be nice to fix in future 
chips.


- Paul
