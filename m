From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 18 Nov 2011 08:59:14 +0530
Subject: [PATCH 6/7] ARM: restart: only perform setup for restart when
 soft-restarting
In-Reply-To: <20111117174247.GF9581@n2100.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6b9-0001NG-NS@rmk-PC.arm.linux.org.uk>
 <20111117174247.GF9581@n2100.arm.linux.org.uk>
Message-ID: <4EC5D10A.1020402@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2011 11:12 PM, Russell King - ARM Linux wrote:
>> We only need to set the system up for a soft-restart if we're going to
>> be doing a soft-restart.  Provide a new function (soft_restart()) which
>> does the setup and final call for this, and make platforms use it.
>> Eliminate the call to setup_restart() from the default handler.
>>
>> This means that platforms arch_reset() function is no longer called with
>> the page tables prepared for a soft-restart, and caches will still be
>> enabled.
>>
>> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> ---
> 
> diff --git a/arch/arm/plat-spear/include/plat/system.h b/arch/arm/plat-spear/include/plat/system.h
>> index a235fa0..1171f22 100644
>> --- a/arch/arm/plat-spear/include/plat/system.h
>> +++ b/arch/arm/plat-spear/include/plat/system.h
>> @@ -31,7 +31,7 @@ static inline void arch_reset(char mode, const char *cmd)
>>  {
>>       if (mode == 's') {
>>               /* software reset, Jump into ROM at address 0 */
>> -             cpu_reset(0);
>> +             soft_restart(0);
>>       } else {
>>               /* hardware reset, Use on-chip reset capability */
>>               sysctl_soft_reset((void __iomem *)VA_SPEAR_SYS_CTRL_BASE);

For SPEAr:

Acked-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
