From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 7 Sep 2015 09:44:22 +0530
Subject: [PATCH 01/11] ARM64 / PCI: introduce struct pci_controller for
 ACPI
In-Reply-To: <55657EA3.5000601@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
 <1432644564-24746-2-git-send-email-hanjun.guo@linaro.org>
 <20150526165844.GD2175@e106497-lin.cambridge.arm.com>
 <5564AB68.6080502@linux.intel.com> <55657EA3.5000601@linaro.org>
Message-ID: <CAFpQJXUU4mVbJSyfQJJm_VjR_uAm-xKHP7syYaM_xuC+CG7q5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

On Wed, May 27, 2015 at 1:51 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> Hi Liviu,
>
> On 2015?05?27? 01:20, Jiang Liu wrote:
>>
>> On 2015/5/27 0:58, Liviu Dudau wrote:
>>>
>>> On Tue, May 26, 2015 at 01:49:14PM +0100, Hanjun Guo wrote:
>>>>
>>>> ARM64 ACPI based PCI host bridge init needs a arch dependent
>>>> struct pci_controller to accommodate common PCI host bridge
>>>> code which is introduced later, or it will lead to compile
>>>> errors on ARM64.
>>>
>>>
>>> Hi Hanjun,
>>>
>>> Two questions: why don't you introduce this patch next to the
>>> one that is going to make use of it (or even merge it there)?
>
>
> this is because of this patch is needed by Jiang Liu's patch set
> to fix the compile error on ARM64, I'd rather do that, but It's
> better to let Jiang Liu's patch goes in, and then this one, that's
> why I prepared a single patch for the struct. (I mentioned it
> in the cover letter)
>
>>> Second, why is the whole struct pci_controller not surrounded
>>> by #ifdef CONFIG_ACPI as you are implying that this is needed
>>> only for ACPI?
>
>
> I hope it can be reused, since the NUMA node and segment (domain)
> is both needed for DT and ACPI, if it's not the case foe now, I
> can surrounded them all by #ifdef CONFIG_ACPI.
we can make use of this structure to hold pci to numa node
mapping(pcibus_to_node).
can you please pull node member out of  CONFIG_ACPI ifdef.
or you can put only acpi_device under ifdef.
>
>>>
>>> Btw, looking through the whole series I'm not (yet) convinced
>>> that this is needed at all.
>>
>> Hi Liviu,
>>         This structure is required by the requested patch set
>> at http://patchwork.ozlabs.org/patch/472249/, which consolidates
>> the common code to support PCI host bridge into ACPI core.
>
>
> Jiang, thanks for the explanation :)
>
> Thanks
> Hanjun

thanks
Ganapat
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
