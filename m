From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 Feb 2013 20:04:03 +0100
Subject: [PATCH v3] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <201302121812.11566.arnd@arndb.de>
References: <1360686546-24277-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201302121812.11566.arnd@arndb.de>
Message-ID: <20130212200403.75025c7b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Tue, 12 Feb 2013 18:12:11 +0000, Arnd Bergmann wrote:

> > In order to make progress on this, and help reducing the size of the
> > patch set, I would ask if it would be possible to merge patches 1 to
> > 17 from the series for 3.9 (only preparation work), keeping the rest
> > for 3.10. The patches in question are PCI-related, ARM-related, and
> > mvebu/orion-related.
> 
> You can add my 'Reviewed-by' tag on all paches except 5, 6, and 24.

Thanks. I would already be wonderful if I could merge many of those
preparations patches for 3.9.

> I'm fine with adding the other ones to 3.9, as well as adding
> the binding document if you split that out from patch 24. Sorry for
> making this so hard for you.

That's fine, the problem is difficult, so it's expected to be difficult
to find the right solution.

However, I'd like to get serious alternate proposals when the current
proposal isn't considered appropriate. A serious proposal needs to
provide a mechanism to dynamically assign range of addresses to the
different BARs of the different PCIe devices, and those range of
addresses must comply with the special alignment requirements of the
Marvell address decoding windows. So far, I haven't seen any alternate
proposal that has those characteristics. The only alternate proposals
were based on static assignments of addresses to each PCIe interface,
which is unacceptable.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
