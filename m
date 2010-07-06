From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Jul 2010 08:27:53 +0900
Subject: [PATCH] ARM: S5PV210: Fix on SECTION_SIZE_BITS on	S5PV210/S5PC110.
In-Reply-To: <20100706071245.GA5058@n2100.arm.linux.org.uk>
References: <1278391007-11144-1-git-send-email-kgene.kim@samsung.com>
	<20100706071245.GA5058@n2100.arm.linux.org.uk>
Message-ID: <013001cb1d62$de72ff30$9b58fd90$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> 
Hi Russell :-)

> On Tue, Jul 06, 2010 at 01:36:47PM +0900, Kukjin Kim wrote:
> > This patch fixes on SECTION_SIZE_BITS for Sparsemem on S5PV210/S5PC110.
> > Because smallest size of a bank on S5PV210/S5PC110 is aligned by 16MB.
> > So each section's maximum size should be 16MB.
> 
> What is the spacing of chunks of memory, and minimum alignment of those
> chunks in physical address space?

Some S5PC110(MCP D-type) has only available 80MiB in a bank.
So the space accounts for 432MiB in a DMC0, but larger memory(256MiB +
128MiB) exists in a DMC1.

As you know, the size of a section should be a power of 2 and a physical
address space of a section should be contiguous.
If a section size is greater than 16MiB, a section have a hole. So the
SECTION_SIZE_BITS should be 16MiB.

> 
> Also, what is the maximum physical address which memory can be located?

Following is memory map of S5PV210/S5PC110.

0x80000000  -------------------
            |          |
0x70000000  |          |
            |          |
0x60000000  |  DMC 1  |  up to 1GiB
            |          |
0x50000000  |          |
            |          |
0x40000000  ----------------- 
            |          |
0x30000000  |  DMC 0  |  up to 512MiB
            |          |
0x20000000  -------------------


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
