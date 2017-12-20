From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Dec 2017 11:19:12 -0800
Subject: [RFC PATCH v2 1/3] PCI: rockchip: Add support for pcie wake irq
In-Reply-To: <20171219004811.GA216620@google.com>
References: <20170817120431.12398-1-jeffy.chen@rock-chips.com>
 <20170817120431.12398-2-jeffy.chen@rock-chips.com>
 <20170818170107.GA119461@google.com>
 <20170818181416.GF6008@atomide.com>
 <5997486D.4040803@rock-chips.com>
 <20170822172653.GJ6008@atomide.com>
 <599CDB37.3070307@rock-chips.com>
 <20171219004811.GA216620@google.com>
Message-ID: <20171220191912.GM3875@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Brian Norris <briannorris@chromium.org> [171219 00:50]:
> On Wed, Aug 23, 2017 at 09:32:39AM +0800, Jeffy Chen wrote:
> 
> Did this problem ever get resolved? To be clear, I believe the problem
> at hand is:
> 
> (a) in suspend/resume (not runtime PM; we may not even have runtime PM
> support for most PCI devices)

It seems it should be enough to implement runtime PM in the PCI
controller. Isn't each PCI WAKE# line is wired from each PCI device
to the PCI controller?

Then the PCI controller can figure out from which PCI device the
WAKE# came from.

> Options I can think of:
> (1) implement runtime PM callbacks for all PCI devices, where we clear
> any PME status and ensure WAKE# stops asserting [1]

I don't think this is needed, it should be enough to have just
the PCI controller implement runtime PM :)

Regards,

Tony
