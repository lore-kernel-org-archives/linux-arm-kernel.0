From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Apr 2015 18:08:35 +0100
Subject: [PATCH 1/3] mfd: ucb1x00: add irq field to the platform data
In-Reply-To: <CALT56yM-JSN=8KR3EUFAa+k4ZZkqXY9zgwzT2PhRn23dMUc3rQ@mail.gmail.com>
References: <1427989307-1805-1-git-send-email-dbaryshkov@gmail.com>
 <20150402160252.GO24899@n2100.arm.linux.org.uk>
 <CALT56yM-JSN=8KR3EUFAa+k4ZZkqXY9zgwzT2PhRn23dMUc3rQ@mail.gmail.com>
Message-ID: <20150402170835.GW24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 07:27:24PM +0300, Dmitry Eremin-Solenikov wrote:
> Not only "because we can", but "because we should". In my humble
> opinion.
> 
> It looks like the whole story of me touching sa1100 is like fighting with
> 'it was done so for ages' windmills. Yes, I have different opinions sometimes.

Right, and what you're forgetting is that others may have different
opinions.  Like me - and as I'm the sa1100 and ucb1x00 maintainer,
if you have a different opinion, you need to convince me that your
solution is the right thing to do.

Had I thought that passing an IRQ through platform data would be a
good thing, then I would've done it from the outset.

On principle, I don't like the idea of passing driver resources
through platform data, I find it abhorrent.  However, there isn't
really any good solution here other than platform data or
auto-detecting it, and auto-detecting it is, in my opinion, the
lesser of the evils.

> I would like for sa1100 to converge to other platforms. PXA, especially.
> Why? Because I like several small devices sitting on my table. PXA
> is now slowly moving towards dts, cleaner drivers and cleaner interfaces.

Right, so when the UCB1x00 gets a node in DT, the driver can parse
the interrupt from DT, without needing it in platform data - and
if it finds that it's in DT, then there's no need to auto-probe it.

I don't see the point of adding it to platform data only to later
have to change it /again/ when SA11x0 moves to DT.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
