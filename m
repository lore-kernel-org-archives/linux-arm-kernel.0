From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 3 Feb 2017 15:49:23 +0000
Subject: [PATCH v8 00/15] ACPI platform MSI support and its example mbigen
In-Reply-To: <45d4de34-cfd2-06af-93c2-e721bd80ab43@codeaurora.org>
References: <1484744105-53140-1-git-send-email-guohanjun@huawei.com>
 <a2eb29e2-0f46-0be0-dc43-b3a086556965@codeaurora.org>
 <fd106be9-836d-8d91-e57c-183ca56b4a49@arm.com>
 <45d4de34-cfd2-06af-93c2-e721bd80ab43@codeaurora.org>
Message-ID: <8687cb39-bffe-8f4a-76aa-a4d4ed61d30e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/17 15:35, Sinan Kaya wrote:
> On 2/3/2017 10:11 AM, Marc Zyngier wrote:
>> On 03/02/17 14:50, Sinan Kaya wrote:
>>> On 1/18/2017 7:54 AM, Hanjun Guo wrote:
>>>> From: Hanjun Guo <hanjun.guo@linaro.org>
>>>>
>>>> With platform msi support landed in the kernel, and the introduction
>>>> of IORT for GICv3 ITS (PCI MSI) and SMMU, the framework for platform msi
>>>> is ready, this patch set add few patches to enable the ACPI platform
>>>> msi support.
>>>>
>>>> For platform device connecting to ITS on arm platform, we have IORT
>>>> table with the named componant node to describe the mappings of paltform
>>>> device and ITS, so we can retrieve the dev id and find its parent
>>>> irqdomain (ITS) from IORT table (simlar with the ACPI ITS support).
>>>>
>>>
>>> I understand that there is a consensus on IORT/SMMUv3 specific pieces
>>> of this series while there is some ongoing work on the MBIgen part in
>>> due to dependency on Agustin's patch vs. ACPI definitions.
>>>
>>> Can we merge the IORT/SMMUv3 specific pieces to 4.11 so that the base
>>> implementation comes in place?
>>
>> Sorry, but I may be missing something. Which IORT/SMMUv3 patches are we
>> talking about? Do you have a pointer to a series?
>>
> 
> I was talking about patches V8 00-12 of this particular one. 
> 
> [PATCH v8 00/15] ACPI platform MSI support and its example mbigen
> 
> Patches 13-15 are specific for MBIGEN. 00-12 are for the base functionality.

Is that to support SMMUv3's own MSI generation? It would be helpful if
you explained why you want this code to be merged beforehand,
potentially without any in-tree user.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
