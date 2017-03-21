From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Mar 2017 16:53:50 +0000
Subject: [PATCH 05/20] ARM: implement pci_remap_cfgspace() interface
In-Reply-To: <20170321152636.GA4799@red-moon>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-6-lorenzo.pieralisi@arm.com>
 <20170320164354.GQ21222@n2100.armlinux.org.uk>
 <20170321152636.GA4799@red-moon>
Message-ID: <20170321165349.GB21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 03:26:36PM +0000, Lorenzo Pieralisi wrote:
> I assumed that in plain terms, the difference between MT_DEVICE and
> MT_UNCACHED is write posting (aka bufferable) behaviour (across CPU
> architecture versions) and that does not affect write ordering rules.

Having looked it up in the ARM ARM, I think we're fine.  Device and
strongly ordered accesses are both ordered as one group, so can be
thought of as the same.  The only difference is that Device can
complete from the CPU's perspective before it hits the peripheral,
whereas strongly ordered only completes once it's hit the peripheral.

So this looks like exactly the right thing to do here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
