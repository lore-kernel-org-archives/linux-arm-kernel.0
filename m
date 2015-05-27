From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 27 May 2015 16:21:55 +0800
Subject: [PATCH 01/11] ARM64 / PCI: introduce struct pci_controller for
 ACPI
In-Reply-To: <5564AB68.6080502@linux.intel.com>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
 <1432644564-24746-2-git-send-email-hanjun.guo@linaro.org>
 <20150526165844.GD2175@e106497-lin.cambridge.arm.com>
 <5564AB68.6080502@linux.intel.com>
Message-ID: <55657EA3.5000601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

On 2015?05?27? 01:20, Jiang Liu wrote:
> On 2015/5/27 0:58, Liviu Dudau wrote:
>> On Tue, May 26, 2015 at 01:49:14PM +0100, Hanjun Guo wrote:
>>> ARM64 ACPI based PCI host bridge init needs a arch dependent
>>> struct pci_controller to accommodate common PCI host bridge
>>> code which is introduced later, or it will lead to compile
>>> errors on ARM64.
>>
>> Hi Hanjun,
>>
>> Two questions: why don't you introduce this patch next to the
>> one that is going to make use of it (or even merge it there)?

this is because of this patch is needed by Jiang Liu's patch set
to fix the compile error on ARM64, I'd rather do that, but It's
better to let Jiang Liu's patch goes in, and then this one, that's
why I prepared a single patch for the struct. (I mentioned it
in the cover letter)

>> Second, why is the whole struct pci_controller not surrounded
>> by #ifdef CONFIG_ACPI as you are implying that this is needed
>> only for ACPI?

I hope it can be reused, since the NUMA node and segment (domain)
is both needed for DT and ACPI, if it's not the case foe now, I
can surrounded them all by #ifdef CONFIG_ACPI.

>>
>> Btw, looking through the whole series I'm not (yet) convinced
>> that this is needed at all.
> Hi Liviu,
> 	This structure is required by the requested patch set
> at http://patchwork.ozlabs.org/patch/472249/, which consolidates
> the common code to support PCI host bridge into ACPI core.

Jiang, thanks for the explanation :)

Thanks
Hanjun
