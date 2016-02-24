From: w@1wt.eu (Willy Tarreau)
Date: Wed, 24 Feb 2016 20:07:12 +0100
Subject: [PATCH 1/2] ARM: mvebu: change order of ethernet DT nodes on
 Armada 38x
In-Reply-To: <op.ydcptvss2s3iss@ecaz>
References: <1453907300-28283-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1453907300-28283-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160127193143.GF10826@n2100.arm.linux.org.uk>
 <20160127194512.GA16638@1wt.eu>
 <20160129114853.GQ10826@n2100.arm.linux.org.uk>
 <20160224184114.GB2292@1wt.eu> <op.ydcptvss2s3iss@ecaz>
Message-ID: <20160224190712.GA2333@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 08:02:09PM +0100, Imre Kaloz wrote:
> >>I've checked, and we believe not many people are using mainline kernels
> >>on clearfog.  I'll have to adjust my debian jessie setup to fix the
> >>resulting carnage though.  On the plus side, it means that mainline
> >>matches Marvell's kernel for interface naming.
> >
> >Well, now I'm one of these and I confirm that it's really painful to
> >have a different ordering between the DTB provided in mainline and the
> >DTB provided with the board. The worst thing is that using mainline,
> >eth0 corresponds to the switch and appears up, so you don't immediately
> >realize that it's not where your cable is connected :-/
> >
> >Thus could we please get Thomas' patch to ensure that the board boots
> >with similar interface naming with both the original and mainline kernel  
> >?
> 
> Shouldn't this change be device specific then instead of messing up the  
> dtsi?

According to what Thomas explained, it's related to the ordering of
the NICs in the SoC's datasheet, so there are little chances that
anyone would see them enumerated differently on their board.

Willy
