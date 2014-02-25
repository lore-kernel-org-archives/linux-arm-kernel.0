From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 16:44:01 +0100
Subject: DMABOUNCE in pci-rcar
In-Reply-To: <CANqRtoSsra-NQF_4dz1iBjzEvdaUco9o3gbPi_6rEgswV=maCw@mail.gmail.com>
References: <201402241200.21944.arnd@arndb.de>
 <20140225001748.GS21483@n2100.arm.linux.org.uk>
 <CANqRtoSsra-NQF_4dz1iBjzEvdaUco9o3gbPi_6rEgswV=maCw@mail.gmail.com>
Message-ID: <201402251644.01463.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 February 2014, Magnus Damm wrote:
> And the DMABOUNCE code does not support HIGHMEM, so because of that
> the block layer BOUNCE is also used.

Ah, I misunderstood this part previously. I understand better what's
going on now, but this also enforces the impression that both BOUNCE
and DMABOUNCE are not what you should be doing here.

On a related note, I've had some more discussions with Santosh on IRC,
and I think he's in the exact same position on mach-keystone, so we
should make sure that whatever solution either of you comes up with
also works for the other one.

The situation on keystone may be a little worse even, because all their
DMA masters have a 2GB limit, but it's also possible that the same
is true for you. Which categories of DMA masters do you have on R-Car?

a) less than 32-bit mask, with IOMMU
b) less than 32-bit mask, without IOMMU
c) 32-bit mask
d) 64-bit mask

	Arnd
