From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 19 Dec 2011 09:09:57 +0100
Subject: [PATCH] mioa701: add newly available DoC G3 chip
In-Reply-To: <CAN1soZyS-qO-N7bbKBvhm1UzvpUJU9py20_uabEPCQxbsp7_Tg@mail.gmail.com>
 (Haojian Zhuang's message of "Mon, 19 Dec 2011 12:06:10 +0800")
References: <1324122591-1756-1-git-send-email-robert.jarzmik@free.fr>
 <CAN1soZyS-qO-N7bbKBvhm1UzvpUJU9py20_uabEPCQxbsp7_Tg@mail.gmail.com>
Message-ID: <87hb0xf0dm.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@gmail.com> writes:

>> -static struct resource strataflash_resource = {
>> +static struct resource docg3_resource = {
>> ? ? ? ?.start = PXA_CS0_PHYS,
>> - ? ? ? .end ? = PXA_CS0_PHYS + SZ_64M - 1,
>> + ? ? ? .end ? = PXA_CS0_PHYS + SZ_8K - 1,
>> ? ? ? ?.flags = IORESOURCE_MEM,
>> ?};
>
> You resized the flash from 64MB to 8KB. It surprised me that the flash
> size is only 8KB. Could you help to check this?
Checked and confirmed, it's 8K.
The docg3 has a mapped IO space, where :
 - 0x0 - 0x7ff     : boot memory (NOR like)
 - 0x800 - 0xfff   : data area
 - 0x1000 - 0x17ff : registers area
 - 0x1800 - 0x1fff : boot memory (the same one as before)

And the previous "64MB" was because I didn't know which kind of memory was
there, and a static bank can be as big as 64MB.

Cheers.

--
Robert
