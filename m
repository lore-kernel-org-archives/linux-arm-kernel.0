From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 16 Jul 2016 22:53:04 +0200
Subject: [PATCH v0 00/10] Convert Netgear WNR854T to devicetree
In-Reply-To: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
Message-ID: <20160716205304.GA5075@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> There's one major flaw; unicast traffic is never received on any port.
> Broadcast traffic is received however, and on the correct port. Thus
> an external machine can make an ARP request and get a response, for
> example. With a manually-entered ARP entry, the router can send pings
> out to a remote machine which responds, and the response is lost in the
> DSA switch. "ethtool -S" reports pings received on "in_unicast" but
> nothing makes it through the switch. This thread[0] seems very similar.
> I've run out of ideas here and can't find any switch datasheets to give
> me pointers so any suggestions greatly appreciated.

Hi Jamie

So it is 6131? So part of the 6185 family. 

I see you have NET_TAG_DSA, but not NET_TAG_EDSA in your
configuration. Try swapping to EDSA. I even removed support for
TAG_DSA in one of the recent patches.

Please also can you get https://github.com/vivien/linux.git commit
323321875671dfe95b6b91ce051a74d415c7158c which will give you some
extra debug files /sys/kernel/debug/mv88e6xxx. 

The reg, stats, and atu would be interesting.

    Andrew
