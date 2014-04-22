From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 22 Apr 2014 10:44:14 +0100
Subject: Change of TEXT_OFFSET for multi_v7_defconfig
In-Reply-To: <20140417203521.GB22411@obsidianresearch.com>
References: <534D0D91.8020406@linaro.org> <534EAD6C.3040502@codeaurora.org>
 <alpine.LFD.2.11.1404161428280.980@knanqh.ubzr>
 <534EF153.5050603@codeaurora.org>
 <alpine.LFD.2.11.1404161853530.980@knanqh.ubzr>
 <53501E87.6070307@codeaurora.org>
 <20140417203521.GB22411@obsidianresearch.com>
Message-ID: <535639EE.7040102@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/14 21:35, Jason Gunthorpe wrote:
>>> The above is useful for loading the raw uncompressed Image without 
>>> carrying the full ELF baggage.
>>
>> What exactly is the full ELF baggage? Aren't there existing mechanisms to omit
>> debugging symbols, for example, if size is of concern?
> 
> FWIW, it is a small non-intrusive change to produce ELFs with the
> proper LMA, if it is useful for specialized tooling, here is the 3.14
> version of the patch I created (I see it needs a bit of cleanup..)
> You must also force PATCH_PHYS_VIRT off.
> 
> The ELF also has the correct entry point address, so ELF tooling can
> just jump into it, after setting the proper register values according
> to the boot protocol.

That might be a useful approach for single platform kernels but I don't
think such an approach can work for multi-arch kernels since, because
the RAM can be located anywhere in the address map, the physical load
address is platform dependant.


Daniel.
