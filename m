From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 17 Dec 2013 14:08:17 +0100
Subject: [PATCHv7 1/4] pwm: Add Freescale FTM PWM driver support
In-Reply-To: <20131217130435.GV4360@n2100.arm.linux.org.uk>
References: <1386925027-16288-1-git-send-email-Li.Xiubo@freescale.com>
 <1500339.E8bGm7xZUi@flatron> <20131217130435.GV4360@n2100.arm.linux.org.uk>
Message-ID: <2074242.bGmqYDKUOT@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 of December 2013 13:04:35 Russell King - ARM Linux wrote:
> On Tue, Dec 17, 2013 at 01:54:35PM +0100, Tomasz Figa wrote:
> > On Tuesday 17 of December 2013 13:45:06 Thierry Reding wrote:
> > > I fail to see how that would eliminate the problem with the types. That
> > > said I don't actually see sparse complaining about any type mismatches.
> > > That's probably because the various macros implicitly cast to u32.
> > 
> > Well, in BE variant you would read the register using __raw_readl() into
> > a __be32 and then get an u32 from be32_to_cpu() and return it. Similarly
> > for writes
> 
> __raw_readl() returns a u32, so you'll get a warning trying to assign a
> u32 to a __be32.
> 
> We do have ioread32() and ioread32be() which do the appropriate conversion,
> as well as the write versions too.  They both include the barrier if you're
> overly concerned about that.

Nice. I wasn't aware of their existence. Thanks.

Best regards,
Tomasz
