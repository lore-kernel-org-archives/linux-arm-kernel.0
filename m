From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Oct 2018 18:32:42 +0100
Subject: [PATCH 2/2] perf tests: Add a test for the ARM 32-bit [vectors]
 page
In-Reply-To: <175fd725-a97a-c282-5aa1-952014ff9023@gmail.com>
References: <20181025000905.6095-1-f.fainelli@gmail.com>
 <20181025000905.6095-3-f.fainelli@gmail.com>
 <20181025021013.GA30116@lunn.ch>
 <175fd725-a97a-c282-5aa1-952014ff9023@gmail.com>
Message-ID: <20181025173242.GC30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 10:19:54AM -0700, Florian Fainelli wrote:
> On 10/24/18 7:10 PM, Andrew Lunn wrote:
> > On Wed, Oct 24, 2018 at 05:09:05PM -0700, Florian Fainelli wrote:
> >> perf on ARM requires CONFIG_KUSER_HELPERS to be turned on to allow some
> >> independance with respect to the ARM CPU being used. Add a test which
> >> tries to locate the [vectors] page, created when CONFIG_KUSER_HELPERS is
> >> turned on to help asses the system's health.
> > 
> > Hi Florian
> > 
> > I've suffered the pain from missing CONFIG_KUSER_HELPERS. The
> > segfaults give little clue as to what is going wrong,and gdb is not
> > much use either.
> 
> If you have a working backtrace, you can typically see the virtual
> address being in 0xffff_xxxx which gives a bit of a clue, but yes, this
> is not particularly helpful.
> 
> > 
> > What i don't see here is any clue to CONFIG_KUSER_HELPERS. If the test
> > fails, could you print a message suggesting CONFIG_KUSER_HELPERS on
> > ARM?
> 
> Sure, sounds reasonable, thanks for taking a look.

An alternative would be rather than adding this to user programs, to
have the kernel detect it and print a warning itself.

BTW, I note that the help text for CONFIG_KUSER_HELPERS needs to be
updated.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
