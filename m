From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 12 Sep 2016 14:04:29 +0100
Subject: [UPDATE PATCH V10 1/8] ACPI: I/O Remapping Table (IORT) initial
 support
In-Reply-To: <38e36eee-cece-75db-4781-5727dd11c93d@semihalf.com>
References: <1473152938-17388-2-git-send-email-tn@semihalf.com>
 <1473249412-20226-1-git-send-email-tn@semihalf.com>
 <20160909092012.GC19669@red-moon>
 <38e36eee-cece-75db-4781-5727dd11c93d@semihalf.com>
Message-ID: <57D6A7DD.1060305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/16 13:37, Tomasz Nowicki wrote:
> Hi Rafael,
> 
> On 09.09.2016 11:20, Lorenzo Pieralisi wrote:
>> Hi Rafael,
>>
>> On Wed, Sep 07, 2016 at 01:56:52PM +0200, Tomasz Nowicki wrote:
>>> IORT shows representation of IO topology for ARM based systems.
>>> It describes how various components are connected together on
>>> parent-child basis e.g. PCI RC -> SMMU -> ITS. Also see IORT spec.
>>> http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
>>>
>>> Initial support allows to detect IORT table presence and save its
>>> root pointer obtained through acpi_get_table(). The pointer validity
>>> depends on acpi_gbl_permanent_mmap because if acpi_gbl_permanent_mmap
>>> is not set while using IORT nodes we would dereference unmapped pointers.
>>>
>>> For the aforementioned reason call iort_table_detect() from acpi_init()
>>> which guarantees acpi_gbl_permanent_mmap to be set at that point.
>>>
>>> Add generic helpers which are helpful for scanning and retrieving
>>> information from IORT table content. List of the most important helpers:
>>> - iort_find_dev_node() finds IORT node for a given device
>>> - iort_node_map_rid() maps device RID and returns IORT node which provides
>>>   final translation
>>>
>>> IORT support is placed under drivers/acpi/arm64/ new directory due to its
>>> ARM64 specific nature. The code there is considered only for ARM64.
>>> The long term plan is to keep all ARM64 specific tables support
>>> in this place e.g. GTDT table.
>>>
>>> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
>>> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
>>> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> ---
>>
>> Apart from the minor commit logs oversights we consider these two
>> patches ready to go, please let us know if there is something you want
>> changed since we are at risk of missing yet another merge window.
>>
>> It is ARM64 specific code, we created and moved the code to its
>> ARM64 specific directory and we are happy to maintain it as such,
>> we need your ACK to get this done so if there is something you
>> want changed please let us know otherwise I would ask your ACK
>> on these two patches to give Marc a go-ahead for -next and
>> hopefully 4.9.
> 
> Kindly reminder. Is there anything we need to do more about these 
> patches? Please let us know. Note this is the major thing for incoming 
> IORT more advance feature.

May I convey a slight sense of urgency here? I'd like to cut the irqchip
branch for 4.9 pretty soon (this week), in order to let it sink in -next
for a few days at the very least.

It'd be a bit disappointing if these patches missed the boat this time
again.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
