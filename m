From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 26 Jul 2017 16:17:11 +0100
Subject: [PATCH v8 1/3] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <20170726151314.GA10696@hc>
References: <20170725150422.4775-1-jglauber@cavium.com>
 <20170725150422.4775-2-jglauber@cavium.com>
 <72145781-e9ec-036f-f752-b4756fef08ee@arm.com> <20170726111946.GA6273@hc>
 <faa339c4-b087-d970-1099-3d6cf8186545@arm.com> <20170726131058.GA8665@hc>
 <131179fe-42e7-f286-5bd4-801f4c93d5f9@arm.com>
 <20170726145522.GC28875@nazgul.tnic> <20170726151314.GA10696@hc>
Message-ID: <0a0daa94-bad7-cbb5-e421-f8e9d6c79d54@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/07/17 16:13, Jan Glauber wrote:
> On Wed, Jul 26, 2017 at 04:55:22PM +0200, Borislav Petkov wrote:
>> On Wed, Jul 26, 2017 at 03:35:25PM +0100, Suzuki K Poulose wrote:
>>> So the Cavium EDACs, which appear as PCI devices have a PMU attached to it.
>>
>> Cavium EDACs?
>>
>> So let me set something straight first: An EDAC driver simply talks to
>> some RAS IP block and reports errors. It shouldn't have anything to do
>> with a PMU.
>>
>>> In order to build this PMU driver as a module, we need a way to load the module
>>> automatically based on the PCI id. However, since the EDAC driver already
>>> registers with that PCI id, we cannot use the same for the PMU. Ideally,
>>
>> So this is strange. There's a single PCI ID but multiple functionalities
>> behind it?
>
> Yes, but I would still not call a memory controller a RAS IP block.

> There are a number of registers on the memory controller (or on the OCX
> TLK interconnect), and while some of them are RAS related there are also
> other registers in the same device like the counters we want to access
> via PMU code.

How about adding a soc specific (wrapper) driver for the memory controller, which
could use the PCI id and trigger EDAC and PMU drivers (based on what is
selected by configs)  ?

Suzuki
