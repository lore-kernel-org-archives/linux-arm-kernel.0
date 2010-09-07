From: sundar.iyer@stericsson.com (Sundar R IYER)
Date: Tue, 7 Sep 2010 11:32:04 +0200
Subject: [PATCH 0/2] ARM: factorise CPU hotplug code
In-Reply-To: <20100906085650.GA20903@n2100.arm.linux.org.uk>
References: <1283515266-25374-1-git-send-email-sundar.iyer@stericsson.com>
	<33A307AF30D7BF4F811B1568FE7A9B181C7DC032@EXDCVYMBSTM006.EQ1STM.local>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CCFE7AF5@dbde02.ent.ti.com>
	<33A307AF30D7BF4F811B1568FE7A9B181C7DC10D@EXDCVYMBSTM006.EQ1STM.local>
	<20100906085650.GA20903@n2100.arm.linux.org.uk>
Message-ID: <33A307AF30D7BF4F811B1568FE7A9B181C855B90@EXDCVYMBSTM006.EQ1STM.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

>-----Original Message-----
>From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
>Sent: Monday, September 06, 2010 2:27 PM
>
>So what if a platform wants to completely power down a CPU?
>

Cannot this can be still implemented in the platform_do_lowpower()
inside the platform code? I think all that would be replaced for the
platform is the WFI portion, which might be accompanied by requests
to turn the core off.

>You'd want to implement it such that platform_cpu_die() does all
>the shutdown of the CPU except for power-off, and platform_cpu_kill()
>waits for that to complete before turning power off.
>
>With platform_cpu_kill() and platform_cpu_die() moved into generic
>code, you can no longer do this.

I am sorry but I didn't understand this. The erstwhile platform_cpu_die
contains helpers to prepare/enter/exit low power modes. Am I missing
something here that the prepare/enter/exit cannot be included in a 
do_low_power() which is platform specific?

>Lastly, what if you want to allow CPU0 to be offlined, which is
>possible, though its wake-up is a little more complex because it
>must not be allowed to go through its normal boot?

I moved this because none of the platforms currently support offlining
CPU0 in the current code. But, even if it may be possible, wouldn't it be
generic for the architecture?

Regards,
Sundar
