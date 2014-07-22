From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 22 Jul 2014 20:46:53 -0300
Subject: mvebu: Can we make the orion-mdio clock a requirement?
In-Reply-To: <20140721222326.668db913@free-electrons.com>
References: <20140721190614.GB20027@arch.cereza>
 <20140721212818.2d4920c4@free-electrons.com>
 <53CD743D.9080700@gmail.com>
 <20140721222326.668db913@free-electrons.com>
Message-ID: <20140722234653.GB21545@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 Jul 10:23 PM, Thomas Petazzoni wrote:
> On Mon, 21 Jul 2014 22:12:45 +0200, Sebastian Hesselbarth wrote:
> 
> > > However, yes, I tend to agree, making the clock mandatory would
> > > probably be a good thing.
> > 
> > We can always pass TCLK on Orion5x if there is a need for a mandatory
> > clock. Anyway, IIRC clock framework should now properly return
> > -EPROPEDEFER only if there is a clock property set. If there is none,
> > the error is different and can be catched on Orion5x.
> 
> Yes, I already use tclk on Orion5x for various clock references.
> 

Since we all agree, I'll prepare a patchset changing the mvmdio devicetree
binding so the clock is required.

On the driver side, we can only print a warning if the clock is missing,
to keep compatibility.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
