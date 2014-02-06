From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 06 Feb 2014 12:28:20 +0100
Subject: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
In-Reply-To: <20140206110016.GI26035@mudshark.cambridge.arm.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <20140206105442.GB4993@e106497-lin.cambridge.arm.com>
 <20140206110016.GI26035@mudshark.cambridge.arm.com>
Message-ID: <2047274.53Y3xD1lQ0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 February 2014 11:00:16 Will Deacon wrote:
> On Thu, Feb 06, 2014 at 10:54:42AM +0000, Liviu Dudau wrote:
> > On Thu, Feb 06, 2014 at 08:54:03AM +0000, Anup Patel wrote:
> > > On Tue, Feb 4, 2014 at 10:23 PM, Will Deacon <will.deacon@arm.com> wrote:
> > 
> > This is another reason why I prefer the reg property for specifying the configuration
> > space address range. I don't see a straight way of making the distinction you
> > need using the ranges property.
> 
> Well if we need to distinguish cam vs ecam, then adding ioport to the mix
> should be (conceptually) easy and I don't think it would involve the "reg"
> property.
> 
> However, I'm not planning to add ioport support myself.

Maybe it's better to have separate compatible strings for these cases,
can call it "pci-ecam-generic" or "pci-cam-generic" to have an easy
distinction. Or we just use the "reg-names" property so the device
can have a "cam" register or an "ecam" register or both.

I don't think we can make the driver generic enough for
x86 as Anup suggests though, since x86 has its own set of quirks to
deal with the various PCI config space access methods.

	Arnd
