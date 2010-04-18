From: shiraz.linux.kernel@gmail.com (shiraz hashim)
Date: Sun, 18 Apr 2010 20:05:09 +0530
Subject: Query: ARM Cortex A9: Is invalidating L1 data cache mandatory
	before usage
In-Reply-To: <20100417181457.GA24299@n2100.arm.linux.org.uk>
References: <4BC985BD.8040704@st.com>
	<20100417181457.GA24299@n2100.arm.linux.org.uk>
Message-ID: <n2pb0a4007f1004180735k7a6f91dal472b584c887ece7a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Sat, Apr 17, 2010 at 11:44 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Apr 17, 2010 at 03:26:13PM +0530, Shiraz HASHIM wrote:
>> Hello,
>>
>> I am trying to port Linux on ARM Cortex A9 based platform and what
>> I see is that if I don't invalidate the data cache before enabling
>> and using it (in arch/arm/boot/compressed/head.S) the system crashes.
>>
>> I need to do the same for second core before calling secondary_startup.
>>
>> Is it normal? Why then other platforms (cortex A9 based) are not doing
>> this. What am I missing?
>
> Yes, it's required. ?See:
>
> http://www.arm.linux.org.uk/developer/booting.php

OK. So it means that the bootloader is expected to do this
invalidation or cleanup,
and for secondary cpus we can do it before calling secondary_startup.
Am I right ?

regards
Shiraz
