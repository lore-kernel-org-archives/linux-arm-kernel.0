From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 28 Sep 2018 10:50:31 -0700
Subject: [PATCH 1/3] firmware/psci: Fix cpu_resume entry points with
 THUMB2_KERNEL
In-Reply-To: <20180928134704.deonmn5hozam74tz@lakrids.cambridge.arm.com>
References: <20180927192711.26455-1-f.fainelli@gmail.com>
 <20180927192711.26455-2-f.fainelli@gmail.com>
 <20180928134704.deonmn5hozam74tz@lakrids.cambridge.arm.com>
Message-ID: <b21ea7e5-9ca7-f76e-1bbf-9d29374553f8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/28/2018 06:47 AM, Mark Rutland wrote:
> On Thu, Sep 27, 2018 at 12:27:09PM -0700, Florian Fainelli wrote:
>> When THUMB2_KERNEL is enabled, we would be failing to resume from an
>> idle or system suspend call where the reentry point is set to
>> cpu_resume() because that function is in Thumb2. Utilize
>> cpu_resume_arm() for ARM 32-bit kernels which takes care of the mode
>> switching for us.
> 
> Looking at the PSCI spec, if bit[0] of the entry point address is set,
> the CPU should be placed into thumb state.
> 
> So either there's a FW bug here, or perhaps we're stripping bit[0] when
> we do the __pa_symbol() dance.
> 
> Which firmware have you seen this with?

This is a custom implementation use with ARCH_BRCMSTB, the same way I
managed to miss it during code review, I missed it again here, sorry
about that and thanks for pointing me in the right direction.
-- 
Florian
