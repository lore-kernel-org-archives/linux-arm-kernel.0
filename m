From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 25 Mar 2014 21:20:10 +0100
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
References: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
Message-ID: <20140325212010.17711434@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Neil Greatorex,

On Tue, 25 Mar 2014 20:07:59 +0000, Neil Greatorex wrote:

> I've recently acquired a mini-PCIe Intel dual Gigabit Ethernet card
> and was hoping to add it to my Globalscale Mirabox (based on the
> Marvell Armada 370 SoC).
> 
> I have built the kernel from
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux based on
> v3.14.0-rc8, with CONFIG_PCI_MVEBU=y and CONFIG_IGB=m.
> 
> When the system boots, it doesn't detect the PCIe card. Here's the
> output of lspci:
> 
> mirabox ~ # lspci
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
> 02:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02)
> 
> Output from dmesg after boot: https://gist.github.com/ngreatorex/9769713
> Output of "lspci -vvv" after boot: https://gist.github.com/ngreatorex/9769732
> 
> Now for the strange part - if I do an "echo 1 > /sys/bus/pci/rescan"
> it detects the network card, but I get an oops. It doesn't work,
> presumably due to the oops, but it shows up in lspci:
> 
> mirabox ~ # lspci
> 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
> 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01)
> 01:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network
> Connection (rev 01)
> 01:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network
> Connection (rev 01)
> 02:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev ff)
> 03:00.0 USB controller: Fresco Logic FL1009 USB 3.0 Host Controller (rev 02)
> 
> Output from dmesg including the oops: https://gist.github.com/ngreatorex/9769438
> Output of "lspci -vvv" now: https://gist.github.com/ngreatorex/9769327
> 
> I'm afraid that I have zero knowledge of PCI so I'm not sure where to
> start with debugging this. I would appreciate it if someone could give
> me some pointers? If you want any extra debugging information then
> just ask...

Willy Tarreau has also reported issues with igb cards on Marvell
platforms using the pci-mvebu driver. I think in his case the card was
detected even at boot time, but he had similar MSI-X issues later on.
Willy gave me one of these cards last month, but I haven't had the time
to look into the problem yet.

I'll try to find some time to debug this in the near future, at which
point I'll most likely get back to you with some patches to test things.

Thanks for the report!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
