From: gadiyar@ti.com (Anand Gadiyar)
Date: Fri, 12 Nov 2010 14:19:01 +0530
Subject: ARM: fix compile warning in mm/init.c
In-Reply-To: <20101112083602.GB28735@n2100.arm.linux.org.uk>
References: <1289542753-30185-1-git-send-email-gadiyar@ti.com>
	<20101112083602.GB28735@n2100.arm.linux.org.uk>
Message-ID: <4CDCFF7D.5080807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2010 2:06 PM, Russell King - ARM Linux wrote:
> On Fri, Nov 12, 2010 at 11:49:13AM +0530, Anand Gadiyar wrote:
>> Commit 7c63984b86 (ARM: do not define VMALLOC_END relative to PAGE_OFFSET)
>> changed VMALLOC_END to be an explicit value. Before this, it was
>> relative to PAGE_OFFSET and therefore automatically upgraded to
>> unsigned long as PAGE_OFFSET was an unsigned long. This introduced
>> the following build warning. Fix this.
> 
> Please fix your definition of VMALLOC_END.

Will do. Should I also fix up the other mach-* that were touched by this patch?

- Anand
