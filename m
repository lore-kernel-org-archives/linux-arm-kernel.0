From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Apr 2015 13:12:13 +0100
Subject: Reading twd_base at run-time
In-Reply-To: <551BDF69.4020205@free.fr>
References: <55158261.9010108@free.fr> <551586E6.3020200@arm.com>
 <5515BEA5.6040307@free.fr>
 <20150327205301.GD4019@n2100.arm.linux.org.uk>
 <551BDF69.4020205@free.fr>
Message-ID: <20150401121213.GC24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 02:07:05PM +0200, Mason wrote:
> On 27/03/2015 21:53, Russell King - ARM Linux wrote:
> 
> >That's one scenario.  Here's the scenario Mark is describing - one which
> >has real-world examples:
> >
> >Hardware engineer picks address A for rev A and sets CP15 to address A.
> >Everything works.  Hardware engineer then picks address B for rev B, but
> >forgets to update CP15.  It breaks.
> 
> The hardware engineer told me that whatever arbitrary value is chosen
> for PERIPH_BASE is automatically exported through CP15 (which is how
> I thought this worked). So there is no "forgetting to update CP15"
> (for this platform, at least).

I'm sorry, it's not that I don't believe you, it's that ARM Ltd
employees already have evidence to the contary, and they should know
what's possible, they (as a company) designed the hardware and they're
the ones who have to deal with queries from _all_ the silicon vendors.
They get to know what the entire ARM ecosystem is doing, what vendors
get wrong, etc.  They're in a far better position than just one silicon
vendor to know what's possible and what isn't.

So when Mark says something has been seen, I believe him, and that
trumps what hardware engineers at individual silicon vendors claim.

> >If it's in DT, it can be fixed.  It should be there anyway as part of
> >the hardware description.  DT is a description of the hardware.
> 
> I thought DT was supposed to describe hardware that /cannot/ be probed
> or discovered at run-time?

And what about the cases where it is possible to probe the hardware on
some platforms but doing so crashes the kernel on others?  I guess you
don't care about anything but your own platform - that's the kind of
message you're putting out...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
