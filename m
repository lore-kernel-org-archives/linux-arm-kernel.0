From: robherring2@gmail.com (Rob Herring)
Date: Sun, 15 Jul 2012 23:35:14 -0500
Subject: [PATCH v2 01/15] ARM: Add fixed PCI i/o mapping
In-Reply-To: <alpine.LFD.2.02.1207140815220.14068@xanadu.home>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <1342231451-28861-2-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1207140815220.14068@xanadu.home>
Message-ID: <50039A02.6040507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2012 07:22 AM, Nicolas Pitre wrote:
> On Fri, 13 Jul 2012, Rob Herring wrote:

>> +	vm->size = size;
>> +	vm->flags = VM_IOREMAP | VM_ARM_STATIC_MAPPING;
>> +	vm->caller = vm_reserve_area_early;
> 
> This is not providing much useful information when looking at 
> /proc/vmallocinfo anymore.  What about adding a void *caller argument to 
> this function and initializing vm->caller with it to identify the true 
> origin of the region?

What about just using __builtin_return_address(0)? Since pci_reserve_io
and devicemaps_init get inlined, ultimately it shows paging_init doing that.

> 
>> +	vm_area_add_early(vm
Rob++);
> 
> Why ++ ?

Just a cut and paste left over.

> 
> Other than that...
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 

Thanks!

Rob
