From: jcm@redhat.com (Jon Masters)
Date: Mon, 15 Sep 2014 12:32:05 -0400
Subject: "dma-coherent" property inheritance (arm vs arm64)
In-Reply-To: <20140915155216.GG5415@arm.com>
References: <5414FF8F.5040409@redhat.com> <20140915155216.GG5415@arm.com>
Message-ID: <54171485.5010803@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2014 11:52 AM, Catalin Marinas wrote:
> Hi Jon,
> 
> On Sun, Sep 14, 2014 at 03:38:07AM +0100, Jon Masters wrote:
>> commit 6ecba8eb51b7d23fda66388a5420be7d8688b186
>> Author: Catalin Marinas <catalin.marinas@arm.com>
>> Date:   Fri Apr 25 15:31:45 2014 +0100
>>
>>     arm64: Use bus notifiers to set per-device coherent DMA ops
>>
>> Thus at this point, on 32-bit systems, we have defined this function:
>>
>> 	set_arch_dma_coherent_ops
> 
> It was a timing issue that they are not in sync. I would have used
> set_arch_dma_coherent_ops() but it wasn't very clear when it gets merged
> and changing the default on arm64 broke some other assumptions, so a
> temporary fix.

Ok. So arm64 will automatically switch over to set_arch_dma_coherent_ops
(once it's there, it will be called automatically anyway because it's in
the callchain anyway already).

For the moment, on our internal PCI trees, we'll add a notifier and wait
for upstream to get PCI support and figure this out as part of that
activity. In the case of ACPI, I'm still pushing for _CCA methods to be
added by default because it makes sense to be verbose in describing
platform hardware devices, even in spite of default.

Jon.
