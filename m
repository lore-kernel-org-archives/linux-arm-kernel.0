From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Jun 2015 21:28:34 +0100
Subject: [PATCH 00/15] Kill off set_irq_flags
In-Reply-To: <1433874401-27161-1-git-send-email-robh@kernel.org>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
Message-ID: <20150609202834.GH7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 09, 2015 at 01:26:26PM -0500, Rob Herring wrote:
> This series converts all users of ARM specific set_irq_flags to use
> common genirq functions. In many cases where irqdomains are used, the
> set_irq_flags calls were redundant, so I've removed them.
> 
> This is not intended for 4.2, but if any subsystem maintainers want to
> pick up their subsystem's change that is fine. All but the last 2
> patches stand on their own. Any new drivers going into 4.2 may need a
> similar change, but I'm sure people are told not to use set_irq_flags in
> reviews. ;)

So what are you doing about the initial state of IRQs on legacy ARM where
IRQs start off being un-requestable, and need the set_irq_flags() to make
them requestable.  I think you could be introducing a massive regression
by making this change.

Unless you can prove that this isn't the case, you shouldn't be removing
this stuff, especially not from legacy platforms.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
