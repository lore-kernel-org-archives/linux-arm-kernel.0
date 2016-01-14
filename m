From: tn@semihalf.com (Tomasz Nowicki)
Date: Thu, 14 Jan 2016 18:45:58 +0100
Subject: [PATCH V3 14/21] x86, ia64: Include acpi_pci_{add|remove}_bus to
 the default pcibios_{add|remove}_bus implementation.
In-Reply-To: <20160114163313.GB19513@red-moon>
References: <1452691267-32240-1-git-send-email-tn@semihalf.com>
 <1452691267-32240-15-git-send-email-tn@semihalf.com>
 <20160114163313.GB19513@red-moon>
Message-ID: <5697DED6.3000600@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/14/2016 05:33 PM, Lorenzo Pieralisi wrote:
> On Wed, Jan 13, 2016 at 02:21:00PM +0100, Tomasz Nowicki wrote:
>> Arches in subject are the only one who use pcibios_{add|remove}_bus hooks
> "x86 and ia64 are the only arches that implement..."
>
>> and implement it in the same way. Moreover ARM64 is going to do the same.
> "implement them"
>
>> So it seams that acpi_pci_{add|remove}_bus is generic enough to be default
> s/seams/seems
>
>> option for pcibios_{add|remove}_bus hooks. Also, it is always safe to run
>> acpi_pci_{add|remove}_bus as they have empty stubs for !ACPI case and
>> return if ACPI has been switched off in run time.
>>
>> After all we can remove x86 and ia64 pcibios_{add|remove}_bus
>> implementation.
> I think you should rephrase the commit log and fix the typos.
yes, I will.
>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>> ---
>>   arch/ia64/pci/pci.c   | 10 ----------
>>   arch/x86/pci/common.c | 10 ----------
>>   drivers/pci/probe.c   |  3 +++
>>   3 files changed, 3 insertions(+), 20 deletions(-)
> Patch seems fine to me, I do not see why moving the acpi calls into
> generic code would create issues (and why it has not been done before)
> as you mentioned in the commit log, so:
>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Thanks,
Tomasz
