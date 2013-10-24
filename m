From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 24 Oct 2013 17:25:21 -0400
Subject: [PATCH RFC v2 0/4] MDIO bus timeout issues on Dreamplug
In-Reply-To: <cover.1382637156.git.leigh@solinno.co.uk>
References: <cover.1382199042.git.leigh@solinno.co.uk>
 <cover.1382637156.git.leigh@solinno.co.uk>
Message-ID: <20131024212521.GM24520@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leigh,

Thanks for getting the bottom of this!

On Thu, Oct 24, 2013 at 07:09:30PM +0100, Leigh Brown wrote:
> Thanks to the comment from Sebastian I did some more investigation and
> discovered that almost everything about my analysis was wrong (woops).
> The patch itself wasn't too bad though.
> 
> In terms of timings, I don't believe the timeout was due to the SMI bus
> taking too long to respond because when I have repeated my testing
> (this time disabling interrupts whilst waiting), I have found that the
> maximum time that my Dreamplug takes to respond was about 95us (and
> 43us on the Mirabox, which polls).  So I think the root cause of the 
> problem was that interrupt handler was interfering with the polling in 
> some way.
> 
> I have therefore amended the first patch to use usleep_range to sleep
> instead of busy wait as suggested by Sebastian, and set the timeout to
> 1ms.  I've tested this on both the Dreamplug and Mirabox and have seen
> no timeouts at all.
> 
> The second, third and fourth patches are pretty much the same as before.


> 
> If I receive no comments who do I submit this to for inclusion?

You can can use scripts/get_maintainer.pl for this.  In this case, it
spits out:

"David S. Miller" <davem@davemloft.net> (commit_signer:63/70=90%)
Thomas Petazzoni <thomas.petazzoni@free-electrons.com> (commit_signer:15/70=21%)
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> (commit_signer:10/70=14%)
Florian Fainelli <florian@openwrt.org> (commit_signer:8/70=11%)
Stephen Hemminger <stephen@networkplumber.org> (commit_signer:6/70=9%)
netdev at vger.kernel.org (open list:NETWORKING DRIVERS)
linux-kernel at vger.kernel.org (open list)

thx,

Jason.
