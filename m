From: mogambo.kztrj@gmail.com (Khushhua Mogambo)
Date: Sun, 31 Jan 2010 00:13:42 +0900
Subject: Static mappings at boottime
In-Reply-To: <20100130145549.GA17097@n2100.arm.linux.org.uk>
References: <2703439e1001300647q1149a357v3b3e9da6bd8c91cf@mail.gmail.com>
	<20100130145549.GA17097@n2100.arm.linux.org.uk>
Message-ID: <2703439e1001300713k5782d098h6420f19565437c9f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 30, 2010 at 11:55 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Jan 30, 2010 at 11:47:36PM +0900, Khushhua Mogambo wrote:
>> And pass already mapped Virtual addr(and not phys addr) to device drivers
>> ?via IORESOURCE_MEM.
>
> But you can't do this. ?Resources take physical addresses, not virtual
> addresses.
 but phys addr and virt addr is both u32 numbers
 how can kernel detect i passes virt and not phys address?

>> i thinks that way i can do most use of virtual address space for ioremap
>> and I can set VMALLOC size to maximum possible. also drivers doesnt have
>> to worry about mapping(and no addr space is mapped twice in two code pieces)
>>
>> is it considered good kernel porting practice? can we face any problem
>> after some times?
>
> Definitely not.
sorry i asks two opposite qeustions same time.
i am hopeful "Definitely not" is reply of second question ^^

> The "simple" approach to your proposal is to map the device space
> statically and then intercept ioremap(). ?When you detect a request
> for a range which is already statically mapped, then return the
> already mapped virtual address.
i almost forgets the __arch_ioremap. thanks.
