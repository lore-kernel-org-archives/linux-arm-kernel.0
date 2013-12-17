From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Dec 2013 13:04:35 +0000
Subject: [PATCHv7 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <1500339.E8bGm7xZUi@flatron>
References: <1386925027-16288-1-git-send-email-Li.Xiubo@freescale.com>
 <5295539.cCkPY1PpyC@flatron> <20131217124505.GB17210@ulmo.nvidia.com>
 <1500339.E8bGm7xZUi@flatron>
Message-ID: <20131217130435.GV4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 01:54:35PM +0100, Tomasz Figa wrote:
> On Tuesday 17 of December 2013 13:45:06 Thierry Reding wrote:
> > I fail to see how that would eliminate the problem with the types. That
> > said I don't actually see sparse complaining about any type mismatches.
> > That's probably because the various macros implicitly cast to u32.
> 
> Well, in BE variant you would read the register using __raw_readl() into
> a __be32 and then get an u32 from be32_to_cpu() and return it. Similarly
> for writes

__raw_readl() returns a u32, so you'll get a warning trying to assign a
u32 to a __be32.

We do have ioread32() and ioread32be() which do the appropriate conversion,
as well as the write versions too.  They both include the barrier if you're
overly concerned about that.
