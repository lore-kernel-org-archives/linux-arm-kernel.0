From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 7 Feb 2016 19:04:51 +0100
Subject: net: mv643xx: interface does not transmit after some time
In-Reply-To: <56B76DA8.3090500@baker-net.org.uk>
References: <E4F9E0D0-9DA8-4E33-9F89-B49E47F11CE0@schloeter.net>
 <20160206183414.GD17218@lunn.ch>
 <20160206231935.GA30734@jirafa.cyrius.com>
 <56B76DA8.3090500@baker-net.org.uk>
Message-ID: <20160207180451.GA27070@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 07, 2016 at 04:15:36PM +0000, Adam Baker wrote:
> On 06/02/16 23:19, Martin Michlmayr wrote:
> >* Andrew Lunn <andrew@lunn.ch> [2016-02-06 19:34]:
> >>Can you find an easily way to reproduce it? iperf, or scp a big file
> >>etc.
> >
> >FWIW, we had a similar bug report in Debian recently:
> >https://lists.debian.org/debian-arm/2016/01/msg00098.html
> >
> >Turning off TCP RX and TX offloading make it go away:
> >https://lists.debian.org/debian-arm/2016/01/msg00100.html
> >
> >Hopefully Thomas can do a bisect.
> >
> 
> I observed a similar issue when performing a large NFSv4 transfer
> with a kirkwood based server. Unfortunately I'd just jumped from
> 3.14 to 4.4 so I could do with a better starting point to bisect
> from.
> 
> It failed several times while transferring a 4GB file over NFS but
> is stable in normal use.

I tried iperf, 6Gbytes, both RX and TX and it worked. This is with
4.5-rc2 net-next.

I will try again with different window sizes etc, to see if i can
trigger it.

	Andrew
