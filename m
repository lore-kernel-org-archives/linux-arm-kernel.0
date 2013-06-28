From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 28 Jun 2013 09:54:13 +0200
Subject: [PATCH] of: Specify initrd location using 64-bit
In-Reply-To: <51CCA67C.2010803@gmail.com>
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
 <51C4171C.9050908@linutronix.de> <51C48B5A.2040404@ti.com>
 <51CCA67C.2010803@gmail.com>
Message-ID: <51CD4125.5060305@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2013 10:54 PM, Rob Herring wrote:

>> Rob,
>> Are you ok with phys_addr_t since your concern was about rest
>> of the memory specific bits of the device-tree code use u64 ?
> 
> No. I still think it should be u64 for same reasons I said originally.

The physical address space is represented by phys_addr_t and not u64
within the kernel. If you go for u64 you may waste 32bit and you need
to check if the running kernel can deal with this.
Why was u64 such a good thing?

> Rob

Sebastian
