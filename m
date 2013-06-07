From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Jun 2013 19:43:18 +0200
Subject: [PATCH 6/6] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
In-Reply-To: <20130607162050.GA31895@obsidianresearch.com>
References: <00c001ce277b$92b26ab0$b8174010$%han@samsung.com>
 <1880458.2ksb8qtzHh@wuerfel> <20130607162050.GA31895@obsidianresearch.com>
Message-ID: <201306071943.18407.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013, Jason Gunthorpe wrote:
> Sounds fair to me.
> 
> But when we talk about multiple domains we don't mean a disjoint range
> bus bus numbers, as your other email shows:
> 
> 00:00.0 PCI bridge: Samsung Electronics Co Ltd Device a549 (rev 01) (prog-if 00 [Normal decode])
> 10:00.0 PCI bridge: Samsung Electronics Co Ltd Device a549 (rev 01) (prog-if 00 [Normal decode])
> 
> We mean multiple domains, it should look like this:
> 
> 0000:00:00.0 PCI bridge: Samsung Electronics Co Ltd Device a549 (rev 01) (prog-if 00 [Normal decode])
> 0001:00:00.0 PCI bridge: Samsung Electronics Co Ltd Device a549 (rev 01) (prog-if 00 [Normal decode])
> 
> ie lspci -D.
> 
> Each domain gets a unique bus number range, config space, io range,
> etc. This is much clearer to everyone than trying to pretend there is
> only one domain when the HW is actually multi-domain.

Yes, absolutely. This means we also don't need a bus-range property in DT, since each
domain will allow all 255 buses.

	Arnd
