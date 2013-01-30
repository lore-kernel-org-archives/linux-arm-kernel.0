From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 30 Jan 2013 14:07:30 +0100
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130130113245.GH23505@n2100.arm.linux.org.uk>
 <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
Message-ID: <20130130140730.240b18c1@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thierry Reding,

On Wed, 30 Jan 2013 13:03:44 +0100, Thierry Reding wrote:

> That approach isn't going to work very well with multi-platform,
> though, since the function can only be overridden on a
> per-architecture basis.

I can do like is done for pcibios_align_resource(): put a single
implementation of the function in arch/arm/kernel/bios32.c, and make it
call a hook registered in the hw_pci structure, or even directly use a
numerical value in hw_pci, as Russell suggested earlier.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
