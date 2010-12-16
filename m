From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Thu, 16 Dec 2010 13:40:37 -0800
Subject: [PATCH v5 4/5] msm: hotplug: support cpu hotplug on msm
In-Reply-To: <AANLkTinzVP4rjOZM0PZQGYBNm+z-O=S0h6vo1QVoh+ps@mail.gmail.com>
References: <1292482456-22690-1-git-send-email-johlstei@codeaurora.org>	<1292482456-22690-5-git-send-email-johlstei@codeaurora.org>
	<AANLkTinzVP4rjOZM0PZQGYBNm+z-O=S0h6vo1QVoh+ps@mail.gmail.com>
Message-ID: <4D0A8755.9080408@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas wrote:
> On 16 December 2010 06:54, Jeff Ohlstein <johlstei@codeaurora.org> wrote:
>> --- /dev/null
>> +++ b/arch/arm/mach-msm/hotplug.c
> [...]
>> +static inline void platform_do_lowpower(unsigned int cpu)
>> +{
>> +       /* Just enter wfi for now. TODO: Properly shut off the cpu. */
>> +       for (;;) {
>> +               /*
>> +                * here's the WFI
>> +                */
>> +               asm(".word      0xe320f003\n"
>> +                   :
>> +                   :
>> +                   : "memory", "cc");
>
> Is this for an ARMv7 platform? If yes, you could just use the WFI
> instruction directly (and it would also work if compiling the kernel
> to Thumb-2 mode).
>   

I was trying to make the code as similar to the realview code as I
reasonably could. There are several instances of that, we could fix all
of them in one go.

-Jeff

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
