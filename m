From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 24 Oct 2014 14:11:17 +0200
Subject: [PATCH 2/4] ARM: mvebu: Move SCU power up in a function
In-Reply-To: <20141024140551.0890f204@free-electrons.com>
References: <1414088070-12510-1-git-send-email-gregory.clement@free-electrons.com>	<1414088070-12510-3-git-send-email-gregory.clement@free-electrons.com>
 <20141024140551.0890f204@free-electrons.com>
Message-ID: <544A41E5.2090802@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 24/10/2014 14:05, Thomas Petazzoni wrote:
> Dear Gregory CLEMENT,
> 
> On Thu, 23 Oct 2014 20:14:28 +0200, Gregory CLEMENT wrote:
> 
>> +ENTRY(power_up_scu)
>> +	mrc     p15, 4, r1, c15, c0	@ get SCU base address
>> +	orr	r1, r1, #0x8		@ SCU CPU Power Status Register
>> +	mrc	15, 0, r0, cr0, cr0, 5	@ get the CPU ID
>> +	and	r0, r0, #15
>> +	add	r1, r1, r0
>> +	mov	r0, #0x0
>> +	strb	r0, [r1]		@ switch SCU power state to Normal mode
>> +	ret	lr
>> +ENDPROC(power_up_scu)
> 
> Since this function is not static, I think it might be a good idea to
> use a prefix that makes it more specific to the platform in order to
> not pollute the global namespace. Maybe something like
> 'armada_38x_scu_power_up', or something like that.

Yes given the fact that this function is declared in the mach-mveu folder
it is sensible to use a more specific name. However the function itself
is not specific at all to an SoC. This function could be used for any Cortex A9
using the SCU.


Thanks,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
