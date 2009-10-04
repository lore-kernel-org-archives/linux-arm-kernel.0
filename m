From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Sun, 4 Oct 2009 19:03:14 -0400
Subject: [PATCH v1.0 2/4] TS72XX: Allow to override machine ID
In-Reply-To: <20091004011424.12578.79467.stgit@localhost.localdomain>
References: <20091004011413.12578.89897.stgit@localhost.localdomain>
	<20091004011424.12578.79467.stgit@localhost.localdomain>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901DB75AB@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, October 03, 2009 6:14 PM, Christian Gagneraud wrote:
> From: Matthieu Crapet <mcrapet@gmail.com>
> 
> In early days Technologic Systems fixed the 0x163 value in redboot
> instead of 0x2a1, this patch allow to overwrite it.
> 
> Signed-off-by: Matthieu Crapet <mcrapet@gmail.com>
> Signed-off-by: Christian Gagneraud <cgagneraud@techworks.ie>

As others have already pointed out, this is a pure hack and not
suitable for mainline.

The bootloader for systems that needs this really should be updated.
Machine ID 0x163 (355) is ARCH_CX861XX which isn't an ep93xx based
system and doesn't even have a platform init in mainline.

NAK.

Regards,
Hartley
