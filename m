From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 14 Nov 2016 14:10:10 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <1479126185.15557.5@smtp.gmail.com>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <1479126185.15557.5@smtp.gmail.com>
Message-ID: <20161114131010.GC26710@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Actually SFP is connected to SGMII interface of eth1, which is
> routed through SERDES 5.

You say eth1 here. Yet lower down you say got eth0 and eth1 are
connected to the switch?

> We have our proprietary support hacked onto mvneta driver for
> disconnecting PHY on the fly. It is a bit nasty, so I suggest to
> ignore SFP in this DTS altogether and let's wait till "phylink based
> SFP module support" or something alike hits upstream, so we can base
> the SFP support on solid code;

It would be great if you could work on getting the phylink patches
into mainline. It is something i have wanted to do for a long time,
but it is too low down on my priority list to get to. The code is high
quality, so i don't think there will be too many issues. It probably
just needs splitting up into smaller batches, submitting, and working
on any comments.

> Actually eth0 and eth1 (both are RGMII) are connected to the 88E6176
> switch. The problem is that from what I have read so far the switch
> can not operate in DSA mode with two CPU ports.

Again, this is something i wanted to do, and i did have a prototype at
one point. But again, not enough time. If you have resources to work
on this, i can find my code, explain my ideas, and let you complete
it.

	Andrew
