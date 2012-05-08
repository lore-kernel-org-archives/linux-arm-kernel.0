From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 08 May 2012 23:02:20 +0200
Subject: [PATCH 2/2] ARM: OMAP3/4: consolidate cpuidle Makefile
In-Reply-To: <87wr4mmmgn.fsf@ti.com>
References: <1336151921-9485-1-git-send-email-daniel.lezcano@linaro.org>
 <1336151921-9485-3-git-send-email-daniel.lezcano@linaro.org>
 <87wr4mmmgn.fsf@ti.com>
Message-ID: <4FA989DC.2030800@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2012 10:44 PM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> Define a CPU_IDLE section in the makefile, declare the functions in
>> the header files conforming to the kernel coding rules and remove the
>> 'define's in the C files.
>>
>> CONFIG_PM is enabled when CPU_IDLE is enabled because the cpuidle drivers
>> use some functions from the pm subsystem.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> Reviewed-by: Jean Pihet<j-pihet@ti.com>
>
> The changelog doesn't really answer "why" this change is needed.  IOW, I
> don't understand from the changelog exactly what problem this patch is
> trying to solve.
>
> AFAICT, it's just shuffling around the dependencies, and changes the
> omap*_idle_init() calls into inline nops instead of function call nops.

Ok, I will modify the changelog. I'm always bad with the changelogs, 
this is something I have to improve :) I'm the first one to be happy 
when I find a nice description in the patches log.

Thanks.

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
