From: shiraz.hashim@st.com (Shiraz HASHIM)
Date: Sat, 17 Apr 2010 15:58:21 +0530
Subject: Query: ARM Cortex A9: Is invalidating L1 data cache mandatory
	before	usage
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C4F1657F@dbde02.ent.ti.com>
References: <4BC985BD.8040704@st.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C4F1657F@dbde02.ent.ti.com>
Message-ID: <4BC98D45.9080900@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Santosh,

On 4/17/2010 3:37 PM, Shilimkar, Santosh wrote:
>> -----Original Message-----
>> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
>> bounces at lists.infradead.org] On Behalf Of Shiraz HASHIM
>> Sent: Saturday, April 17, 2010 3:26 PM
>> To: linux-arm-kernel at lists.infradead.org
>> Subject: Query: ARM Cortex A9: Is invalidating L1 data cache mandatory before usage
>>
>> Hello,
>>
>> I am trying to port Linux on ARM Cortex A9 based platform and what
>> I see is that if I don't invalidate the data cache before enabling
>> and using it (in arch/arm/boot/compressed/head.S) the system crashes.
> 
> Are you enabling $L1 D in your bootloader before jumping into the kernel??

No. uboot is not enabling data cache. The first time it gets enabled is
in head.S before Linux decompression.

>> I need to do the same for second core before calling secondary_startup.
>>
>> Is it normal? Why then other platforms (cortex A9 based) are not doing
>> this. What am I missing?
>>
>> thanks for your help.

regards
Shiraz
