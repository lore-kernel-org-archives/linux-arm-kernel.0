From: simon.kagstrom@netinsight.net (Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?=)
Date: Thu, 20 Mar 2014 12:05:00 +0100
Subject: [PATCH RESEND v2 1/2] ARM: ixp4xx: Make dma_set_coherent_mask
 common, correct implementation
In-Reply-To: <201403201202.37065.arnd@arndb.de>
References: <20140317144016.0508cc4d@marrow.netinsight.se>
 <20140320090330.49a1d372@marrow.netinsight.se>
 <m31txxjjrj.fsf@t19.piap.pl> <201403201202.37065.arnd@arndb.de>
Message-ID: <20140320120500.77948552@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 20 Mar 2014 12:02:36 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday 20 March 2014, Krzysztof Ha?asa wrote:
> > Simon K?gstr?m <simon.kagstrom@netinsight.net> writes:
> > 
> > > Thanks. However, Krzysztof thinks that this implementation is
> > > incorrect. It certainly fixes my ixp4xx issues, but might not be good
> > > for everyone.
> > 
> > It because you don't have PCI devices setting coherent mask to 32-bits
> > (and that's what normal PCI devices do).
> > 
> > BTW PCI (and other) devices requesting 32-bit coherent allocs don't care
> > if they're given 26-bit memory. 26 bits fit perfectly in 32 bits. It's
> > the streaming mapping which is (may be) constrained by hardware.
> 
> Should I revert the patch then until we have a better fix?

Yes, I think that would be good. Thanks to all for looking into it!

// Simon
