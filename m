From: Wei.Yang@windriver.com (Yang,Wei)
Date: Wed, 2 Jul 2014 19:02:12 +0800
Subject: [PATCH v1] ARM:sa1100: Remove a redundant spin lock
In-Reply-To: <20140702101925.GE32514@n2100.arm.linux.org.uk>
References: <1404200488-7809-1-git-send-email-Wei.Yang@windriver.com>
 <53B3CEAC.9080609@windriver.com>
 <20140702101925.GE32514@n2100.arm.linux.org.uk>
Message-ID: <53B3E6B4.2040907@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/2014 06:19 PM, Russell King - ARM Linux wrote:
> On Wed, Jul 02, 2014 at 05:19:40PM +0800, Yang,Wei wrote:
>> Hi Guys,
>>
>> What about this patch?
> The only concern on the face of it is that it removes mutual exclusion
> from the pci config write path, where a read-modifiy-write operation is
> performed.
>
> However, the PCI code already gives that guarantee (drivers/pci/access.c)
> so this should be safe.
>
> As this is fairly old code, it would be useful to know what the motivation
> is behind this change.  Is it purely clean up, or is it something that
> you've tested, or is this a change that you require for something else?
>
> Thanks.
>
Hmm, I fixed a bug of pci config read/write of an ARM board, but 
unfortunately, so far ML does not support it. So
I cannot send the fix, but I grepped the pci source code of ARM 
architecure, I found that the pci code of a few boards always
define a static spin lock to excluse the pci config read/write path. I 
just intended to clean up them. If you agree the change,
I want to send v2 to also remove this mutual exclusion for something 
else board which also used the mutual exclusion.

Thanks
Wei
