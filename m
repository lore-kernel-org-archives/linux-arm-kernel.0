From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Feb 2014 14:30:08 -0500
Subject: Stuck getting DTS working for a new kirkwood board
In-Reply-To: <5308F3B4.6010409@sigpipe.me>
References: <5306721B.7020403@sigpipe.me>
 <20140221013407.GX7862@titan.lakedaemon.net>
 <5307029C.20006@sigpipe.me>
 <20140221151530.GZ7862@titan.lakedaemon.net>
 <5307A727.9080508@sigpipe.me>
 <20140221200855.GM7862@titan.lakedaemon.net>
 <5308F3B4.6010409@sigpipe.me>
Message-ID: <20140222193008.GB7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 22, 2014 at 08:00:04PM +0100, Dashie wrote:
> Hi,
> 
> On 02/21/2014 09:08 PM, Jason Cooper wrote:
> >> Well, with kirkwood_defconfig it doesn't find the SATA PHY and panic.
> >> So i've used my debian config, make oldconfig, built and ... the toy is
> >> booting.
> > Yes, this is a known issue.  You worked around it by enabling generic
> > phy support (it's most likely in the other configs).
> Well, i've done some more tests and found that i've commented the
> sata at 80000 {} part of the DTS, but does not remember if that was after
> trying "debian config".
> 
> If i uncomment it, i got the kernel panic with "sata_mv f1080000.sata:
> unable to find phy".
> 
> About generic phy, is it CONFIG_GENERIC_PHY ? I't already to =y in my
> .config actually.
> I have CONFIG_PHY_MVEBU_SATA=y and CONFIG_SATA_MV=y too.

Ok.  Don't worry about that for the moment.  There's a fix making it's
way to mainline for this issue.  Once we get everything else sorted for
your board, we'll have you try Linus' current master to confirm sata
works on your board.

thx,

Jason.
