From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 06 Nov 2009 16:58:39 +0900
Subject: About allocate the memory with non-secure attribute
Message-ID: <000b01ca5eb6$f3e01c10$dba05430$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

In default case, the ARM CPU is in the secure state until secure state
attribute is changed.

We are developing the system MMU device driver which makes multimedia device
can use virtual address instead of physical address.

Our system MMU operates as follows;

1. The device driver requests the virtually continuous memory to the OS.
2. When OS returns the page table as a result, the system MMU receives the
pointer of page table.
3. When HW Device generates the virtual addressing transaction, system MMU
translate it into the physical address by referring page table.
4. If the secure attribute of device's transaction is not matched with the
attribute of its page table, system MMU generate the fault interrupt, and
returns bus decode error to the HW Device.

The problem is "the HW device generates the non-secure transaction, while
page table has secure attribute."

And, we don't want to make HW device generates the secure transaction.

Is there any solution to allocate the memory with non-secure attribute?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
System LSI Division, SAMSUNG ELECTRONICS CO., LTD.
