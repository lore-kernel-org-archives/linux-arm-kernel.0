From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 2 Jan 2018 09:39:47 +0800
Subject: [RFC] does ioremap() cause memory leak?
In-Reply-To: <5A3DEA6A.9080709@huawei.com>
References: <5A3B76EE.8020001@huawei.com> <5A3DEA6A.9080709@huawei.com>
Message-ID: <e25b1da2-14fb-eeec-1a76-1756011535bb@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/12/23 13:32, Xishi Qiu wrote:
> On 2017/12/21 16:55, Xishi Qiu wrote:
> 
>> When we use iounmap() to free the mapping, it calls unmap_vmap_area() to clear page table,
>> but do not free the memory of page table, right?
>>
>> So when use ioremap() to mapping another area(incluce the area before), it may use
>> large mapping(e.g. ioremap_pmd_enabled()), so the original page table memory(e.g. pte memory)
>> will be lost, it cause memory leak, right?
> 
>  
> 
> So I have two questions for this scene.
> 
> 1. When the same virtual address allocated from ioremap, first is 4K size, second is 2M size, if Kernel would leak memory.
> 
> 2. Kernel modifies the old invalid 4K pagetable to 2M, but doesn`t follow the ARM break-before-make flow, CPU maybe get the old invalid 4K pagetable information, then Kernel would panic.

I sent a RFC patch for this one [1].

[1]: https://patchwork.kernel.org/patch/10134581/

Thanks
Hanjun
