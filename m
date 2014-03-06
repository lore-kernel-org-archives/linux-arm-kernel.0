From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 6 Mar 2014 16:17:47 -0300
Subject: [PATCH] ARM: mvebu: add Device Tree for the Armada 385 RD board
In-Reply-To: <20140306172339.GP4780@lunn.ch>
References: <1394107868-26094-1-git-send-email-gregory.clement@free-electrons.com>
 <20140306131429.GJ4780@lunn.ch>
 <5318779C.8030901@free-electrons.com>
 <20140306142117.GL4780@lunn.ch>
 <531886B4.2070002@free-electrons.com>
 <20140306144600.GM4780@lunn.ch>
 <53188B73.4000109@free-electrons.com>
 <53189892.5090502@free-electrons.com>
 <20140306160213.GA4327@arch.cereza> <20140306172339.GP4780@lunn.ch>
Message-ID: <20140306191747.GA32655@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mar 06, Andrew Lunn wrote:
> > Can't we fix this so the probe order doesn't affect the name?
> > 
> > Is that sane?
> 
> You are not supposed to trust the device name, since probing can
> happen in parallel, on different buses. udev should have rules to name
> the interfaces based on the MAC address. On my Debian system i have:
> 
> /etc/udev/rules.d/70-persistent-net.rules
> 
> So what is important is that the MAC addresses are assigned correctly
> to the device. And DT does that based on MMIO address, so should be
> reliable, independent of probe order.
> 

Right, makes perfect sense!

So we can just keep the nodes address-ordered, without caring about the name?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
