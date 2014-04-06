From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 7 Apr 2014 00:16:02 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <alpine.DEB.2.10.1404062253500.16719@vroombuntu>
References: <20140325222404.GC14718@obsidianresearch.com>
 <20140325223510.GD14718@obsidianresearch.com>
 <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140406185833.GI29787@1wt.eu>
 <alpine.DEB.2.10.1404062253500.16719@vroombuntu>
Message-ID: <20140407001602.5b3aa425@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Neil Greatorex,

On Sun, 6 Apr 2014 22:57:40 +0100 (BST), Neil Greatorex wrote:

> Second port:
> [ 1809.459445] igb 0000:01:00.1: enabling bus mastering
> [ 1809.459563] igb 0000:01:00.1 (unregistered net_device): hw_addr is
> f1100000, start=e0100000, len=80000, flags=40200
> [ 1809.459573] igb 0000:01:00.1 (unregistered net_device): About to read
> from offset 18
> [ 1809.459581] Unhandled fault: external abort on non-linefetch (0x1008) 
> at 0xf1100018

This address is a virtual address, so there's not much we can do with
it, as it is.

> The physical addresses match those given in the lspci -vvv output (see 
> https://gist.github.com/ngreatorex/9772195). I don't know enough about 
> PCIe, the SoC *or* the Intel card to know if these addresses look correct 
> or even sane! I did wonder if there was some issue due to the fact that 
> the resources for 01:00.0 and 01:00.1 overlap, but I would guess(!?) that 
> it's common in hardware that presents multiple devices.
> 
> It is perhaps noteworthy that this is the first access to the hardware for 
> the 2nd port - i.e. there are no successful accesses, other than to enable 
> the hardware, which AFAICT is simply accessing registers on the PCIe 
> controller.

It really looks like the MBus window has not been sized correctly, or
there is a missing MBus window. Probably a deficiency in the PCI bridge
emulation layer in pci-mvebu.

Tomorrow, I have a bit of work on AHCI on Armada 38x, but I'm hoping to
get to this after that.

Thanks again for all the investigation. All your research is clearly
going to make the debugging a *lot* easier.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
