From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 20 Nov 2014 16:03:53 +0100
Subject: [RFC PATCH] clk: mvebu: armada-xp: Support for MSYS SoC
In-Reply-To: <20141120155630.743ee6de@free-electrons.com>
References: <1416459679-30944-1-git-send-email-chris.packham@alliedtelesis.co.nz>
 <20141120155630.743ee6de@free-electrons.com>
Message-ID: <20141120150353.GG31782@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 03:56:30PM +0100, Thomas Petazzoni wrote:
> Dear Chris Packham,
> 
> On Thu, 20 Nov 2014 18:01:19 +1300, Chris Packham wrote:
> > The MSYS SoCs are a range of packet processors with integrated CPUs based
> > on armada-xp. One difference is that the TCLK frequency is fixed at 200MHz
> > as opposed to the fixed 250MHz used on armada-xp. The clock-gating options
> > are a subset of what's available on the armada-xp so this code should be
> > compatible.
> 
> Well, if you have only a subset of what's available, then I would also
> suggest to introduce a separate compatible string for the gatable
> clocks.

For the kirkwood based 98dx4122, we avoided a separate gatable
compatible string, by simply not listing devices which don't
exist. For that SoC, accessing clocks which don't exist is not a
problem. However, accesses devices which don't exist does lock the
SoC.

There is a specific pin-controller compatible string:
marvell,98dx4122-pinctrl, and i guess one is also needed here.

	Andrew
