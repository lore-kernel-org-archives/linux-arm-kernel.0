From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 13 Oct 2015 13:28:33 -0400
Subject: [PATCH 1/4] Documentation: dt: soc: move driver description to
 a separate document
In-Reply-To: <CAL_Jsq+GZn0X-sxQ=oqRP7fR3bCPk5PN5CjgXzjnOxas_renzw@mail.gmail.com>
References: <1444679211-823-1-git-send-email-m-karicheri2@ti.com>
 <1444679211-823-2-git-send-email-m-karicheri2@ti.com>
 <CAL_Jsq+GZn0X-sxQ=oqRP7fR3bCPk5PN5CjgXzjnOxas_renzw@mail.gmail.com>
Message-ID: <561D3F41.4080803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/2015 10:42 AM, Rob Herring wrote:
> On Mon, Oct 12, 2015 at 2:46 PM, Murali Karicheri <m-karicheri2@ti.com> wrote:
>> Currently the DT bindings have details about the driver as well. This
>> patch moves this to a separate document for knav qmss driver so that
>> driver detail update can be done as needed without polluting the DT
>> bindings description.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> ---
>>   Documentation/arm/keystone/knav-qmss.txt           | 24 ++++++++++++++++++++++
>>   .../bindings/soc/ti/keystone-navigator-qmss.txt    | 20 ++++--------------
>>   2 files changed, 28 insertions(+), 16 deletions(-)
>>   create mode 100644 Documentation/arm/keystone/knav-qmss.txt
>>
>> diff --git a/Documentation/arm/keystone/knav-qmss.txt b/Documentation/arm/keystone/knav-qmss.txt
>> new file mode 100644
>> index 0000000..79946d1
>> --- /dev/null
>> +++ b/Documentation/arm/keystone/knav-qmss.txt
>> @@ -0,0 +1,24 @@
>> +* Texas Instruments Keystone Navigator Queue Management SubSystem driver
>> +
>> +Driver source code path
>> +  drivers/soc/ti/knav_qmss.c
>> +  drivers/soc/ti/knav_qmss_acc.c
>> +
>> +The QMSS (Queue Manager Sub System) found on Keystone SOCs is one of
>> +the main hardware sub system which forms the backbone of the Keystone
>> +multi-core Navigator. QMSS consist of queue managers, packed-data structure
>> +processors(PDSP), linking RAM, descriptor pools and infrastructure
>> +Packet DMA.
>> +The Queue Manager is a hardware module that is responsible for accelerating
>> +management of the packet queues. Packets are queued/de-queued by writing or
>> +reading descriptor address to a particular memory mapped location. The PDSPs
>> +perform QMSS related functions like accumulation, QoS, or event management.
>> +Linking RAM registers are used to link the descriptors which are stored in
>> +descriptor RAM. Descriptor RAM is configurable as internal or external memory.
>> +The QMSS driver manages the PDSP setups, linking RAM regions,
>> +queue pool management (allocation, push, pop and notify) and descriptor
>> +pool management.
>> +
>> +knav qmss driver provides a set of APIs to drivers to open/close qmss queues,
>> +allocate descriptor pools, map the descriptors, push/pop to queues etc. For
>> +details of the available APIs, please refers to include/linux/soc/ti/knav_qmss.h
>> diff --git a/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt b/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
>> index d8e8cdb..2cecea1 100644
>> --- a/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
>> +++ b/Documentation/devicetree/bindings/soc/ti/keystone-navigator-qmss.txt
>> @@ -1,20 +1,8 @@
>> -* Texas Instruments Keystone Navigator Queue Management SubSystem driver
>> -
>> -The QMSS (Queue Manager Sub System) found on Keystone SOCs is one of
>> -the main hardware sub system which forms the backbone of the Keystone
>> -multi-core Navigator. QMSS consist of queue managers, packed-data structure
>> -processors(PDSP), linking RAM, descriptor pools and infrastructure
>> -Packet DMA.
>> -The Queue Manager is a hardware module that is responsible for accelerating
>> -management of the packet queues. Packets are queued/de-queued by writing or
>> -reading descriptor address to a particular memory mapped location. The PDSPs
>> -perform QMSS related functions like accumulation, QoS, or event management.
>> -Linking RAM registers are used to link the descriptors which are stored in
>> -descriptor RAM. Descriptor RAM is configurable as internal or external memory.
>> -The QMSS driver manages the PDSP setups, linking RAM regions,
>> -queue pool management (allocation, push, pop and notify) and descriptor
>> -pool management.
>
> Only the last sentence seems to be about the driver and is rather
> obvious (a driver manages the h/w). I would leave all this as-is
> currently.
>
> Rob
>
Rob,

I am taking the liberty to add your Ack based on the above. I can remove 
it if you disagree.

Murali

>> +* Texas Instruments Keystone Navigator (knav) Queue Management SubSystem driver
>> +  DT bindings
>>
>> +For details of the driver, please refer to
>> +Documentation/arm/keystone/knav-qmss.txt
>>
>>   Required properties:
>>   - compatible   : Must be "ti,keystone-navigator-qmss";
>> --
>> 1.9.1
>>
>
>


-- 
Murali Karicheri
Linux Kernel, Keystone
