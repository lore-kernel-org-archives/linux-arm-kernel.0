From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Mar 2018 12:59:07 +0000
Subject: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
In-Reply-To: <20180302124647.sfhnto77wgdh5sv6@katana>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
 <20180302124647.sfhnto77wgdh5sv6@katana>
Message-ID: <20180302125907.GA9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 01:46:47PM +0100, Wolfram Sang wrote:
> 
> So, maybe some words why I accepted this patch.
> 
> On Fri, Mar 02, 2018 at 11:19:31AM +0000, Russell King - ARM Linux wrote:
> > Note that there have been patches proposed to make platform_get_irq()
> > return an error rather than returning a value of zero, so changing
> > the driver in this way is not a good idea.
> 
> I'd much agree to such an approach, yet I didn't see it coming along so
> far for years(?) now.

It needs platform maintainers to be motivated to fix it, and one way to
provide that motivation is for subsystem maintainers to say no to patches
like this.  If patches like this get accepted, then the "problem" gets
solved, and there is very little motivation to fix the platform itself.

If you look back at the history of this, the times when platforms have
been fixed is when they have a problem exactly like this, and they're
told to fix their platforms IRQ numbering instead of the patch to "fix"
the driver being accepted.

Why fix the interrupt numbering if patches to "fix" drivers get
accepted?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
