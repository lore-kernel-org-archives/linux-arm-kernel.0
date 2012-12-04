From: armando.visconti@st.com (Armando Visconti)
Date: Tue, 4 Dec 2012 10:36:55 +0100
Subject: [PATCH] nommu: Enable the strict alignment (CR_A) bit only if
 ARCH < v6
In-Reply-To: <20121203174617.GL20074@mudshark.cambridge.arm.com>
References: <1354187042-28568-1-git-send-email-armando.visconti@st.com>
 <50BCD6DB.2030200@st.com> <20121203172553.GC14363@n2100.arm.linux.org.uk>
 <20121203174617.GL20074@mudshark.cambridge.arm.com>
Message-ID: <50BDC437.1050701@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2012 06:46 PM, Will Deacon wrote:
> On Mon, Dec 03, 2012 at 05:25:53PM +0000, Russell King - ARM Linux wrote:
>> On Mon, Dec 03, 2012 at 05:44:11PM +0100, Armando Visconti wrote:
>>> On 11/29/2012 12:04 PM, Armando VISCONTI wrote:
>>>> This patch keeps disabled the strict alignment CP15 bit for
>>>> all armv6 and armv7 processor without the mmu. This behaviour
>>>> is now same as in the mmu case.
>>>>
>>>> Signed-off-by: Armando Visconti<armando.visconti@st.com>
>>>> ---
>>>>    arch/arm/kernel/head-nommu.S |    2 +-
>>>>    1 files changed, 1 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
>>>> index 278cfc1..2c228a0 100644
>>>> --- a/arch/arm/kernel/head-nommu.S
>>>> +++ b/arch/arm/kernel/head-nommu.S
>>>> @@ -68,7 +68,7 @@ __after_proc_init:
>>>>    	 * CP15 system control register value returned in r0 from
>>>>    	 * the CPU init function.
>>>>    	 */
>>>> -#ifdef CONFIG_ALIGNMENT_TRAP
>>>> +#if defined(CONFIG_ALIGNMENT_TRAP)&&   __LINUX_ARM_ARCH__<   6
>>>>    	orr	r0, r0, #CR_A
>>>>    #else
>>>>    	bic	r0, r0, #CR_A
>>>
>>> Any feedback on this simple patch?
>>
>> Well, it brings the nommu version into line with the mmu version, so
>> it's sensible.  Please put it in the patch system, thanks.
>

Done!

> In which case, I'll definitely dust-off the patches to prevent unaligned
> accesses to strongly-ordered memory because that results in good ol'
> UNPREDICTABLE behaviour.
>

Yes, we definetely need them.

Thx,
Arm
