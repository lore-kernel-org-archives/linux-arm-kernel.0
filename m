From: marek.vasut@gmail.com (Marek Vasut)
Date: Thu, 14 Jun 2018 01:06:52 +0200
Subject: [PATCH 2/4] ARM: Introduce ability to enable invalidate of BTB
 with ICIALLU on Cortex-A15 for CVE-2017-5715
In-Reply-To: <20180613213222.qxuiw7cajizslso7@kahuna>
References: <20180612202411.29798-1-nm@ti.com>
 <20180612202411.29798-3-nm@ti.com>
 <8fac2f1c-ecc4-1aa1-0620-8ac6e2efdbf1@gmail.com>
 <20180613133215.2cv7iyjb2laaha3j@kahuna>
 <20180613154627.GP350@bill-the-cat.ec.rr.com>
 <20180613213222.qxuiw7cajizslso7@kahuna>
Message-ID: <2286b326-3970-412a-a47b-164d65c6cb18@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2018 11:32 PM, Nishanth Menon wrote:
> On 15:46-20180613, Tom Rini wrote:
>> On Wed, Jun 13, 2018 at 08:32:15AM -0500, Nishanth Menon wrote:
>>> On 23:05-20180612, Marek Vasut wrote:
>>>> On 06/12/2018 10:24 PM, Nishanth Menon wrote:
>>> [..]
>>>>> +#ifdef CONFIG_ARM_CORTEX_A15_CVE_2017_5715
>>>>> +	mrc	p15, 0, r0, c1, c0, 1	@ read auxilary control register
>>>>> +	orr	r0, r0, #1 << 0		@ Enable invalidates of BTB
>>>>
>>>> Can we use BIT() macro in the assembler code too ?
>>>
>>> Probably, but just following convention in the rest of the file. Do we
>>> want to change from existing code?
>>
>> Agreed, we should follow the existing style (and I'm not 100% sure I
>> like using BIT() in asm files).
> 
> OK. Will drop this feedback about BIT() macro if I have to do a v2.

Fine by me

-- 
Best regards,
Marek Vasut
