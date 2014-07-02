From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jul 2014 11:19:26 +0100
Subject: [PATCH v1] ARM:sa1100: Remove a redundant spin lock
In-Reply-To: <53B3CEAC.9080609@windriver.com>
References: <1404200488-7809-1-git-send-email-Wei.Yang@windriver.com>
 <53B3CEAC.9080609@windriver.com>
Message-ID: <20140702101925.GE32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 05:19:40PM +0800, Yang,Wei wrote:
> Hi Guys,
>
> What about this patch?

The only concern on the face of it is that it removes mutual exclusion
from the pci config write path, where a read-modifiy-write operation is
performed.

However, the PCI code already gives that guarantee (drivers/pci/access.c)
so this should be safe.

As this is fairly old code, it would be useful to know what the motivation
is behind this change.  Is it purely clean up, or is it something that
you've tested, or is this a change that you require for something else?

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
