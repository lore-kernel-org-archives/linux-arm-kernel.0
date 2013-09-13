From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 13 Sep 2013 13:38:10 +0200
Subject: [PATCH v2 00/12] CPU idle for Armada XP
In-Reply-To: <5232F43D.4040404@free-electrons.com>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
 <20130913110043.GJ19363@lunn.ch>
 <5232F43D.4040404@free-electrons.com>
Message-ID: <20130913113810.GK19363@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 01:17:17PM +0200, Gregory CLEMENT wrote:
> On 13/09/2013 13:00, Andrew Lunn wrote:
> > 
> > On Fri, Sep 13, 2013 at 12:06:29PM +0200, Gregory CLEMENT wrote:
> >> Hello,
> >>
> >> This patch set adds the CPU idle support for Armada XP and prepares
> >> the support for Armada 370. This was based on the work of Nadav
> >> Haklai.
> > 
> > Hi Gregory.
> > 
> > Kirkwood has the ability to put the DDR into self refresh mode, which
> > is used as part of the second level idle mode. Does 370/XP have this?
> 
> Indeed there is a self refresh bit on a DDR related register. I thought
> this kind of feature is more likely used for suspend to ram.

The kirkwood data sheet suggests it is useful if the CPU is idle for a
few milliseconds. So it sounds like it is a slow transition, but does
seem to save a bit of power. I guess in a NO_HZ system, it would make
sense.

	Andrew
