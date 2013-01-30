From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 30 Jan 2013 12:37:17 +0100
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130130113245.GH23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130130113245.GH23505@n2100.arm.linux.org.uk>
Message-ID: <20130130123717.410d13ff@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Wed, 30 Jan 2013 11:32:46 +0000, Russell King - ARM Linux wrote:

> You do realise that this will result in all PCI I/O BARs being rounded
> up to 64K.

Hum, yes, correct.

> I've just been digging through the PCI code and have come across a
> function - pcibios_window_alignment() - which the PCI code allows to be
> overriden which allows you to increase the alignment requirement of
> bridge windows.  It takes the PCI bus and window type as arguments.
> 
> I'd suggest using that, and checking whether the bus which is passed
> corresponds with a bus which gives you problems, so that you don't
> impose the 64K requirement on downstream bridges.

Seems interesting indeed, I'll look into this idea! Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
