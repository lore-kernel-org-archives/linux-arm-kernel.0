From: arun.ramamurthy@broadcom.com (Arun Ramamurthy)
Date: Wed, 18 Mar 2015 13:58:54 -0700
Subject: Setting reboot type at run time for ARM
In-Reply-To: <5508CBD0.5060508@gmail.com>
References: <5508A047.7060308@broadcom.com> <5508CBD0.5060508@gmail.com>
Message-ID: <5509E70E.7060907@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 15-03-17 05:50 PM, Florian Fainelli wrote:
> On 17/03/15 14:44, Arun Ramamurthy wrote:
>> Hello
>>
>> I would like to specify a reset type just before issuing the reboot
>> command in the kernel. I know the kernel command line parameter can be
>> set as "reboot=w" to indicate warm reset but I want to be able to decide
>> this at run time before issuing a reboot command. What would be the best
>> way to implement this? Modify the reboot command
>> to accept a parameter or is there a standard hook I can use?
>
> If you use the reboot(2) system call you can already specify a large
> number of options, for options that are currently not supported by
> coreutils' reboot or busybox's reboot, you could probably provide a
> shell script wrapper which calls into either your own reboot
> implementation or the regular one, would that work?
>
Thanks Florian. After looking at the sys call documentation, i can see 
that it passes an argument to the kernel_restart function if I use 
LINUX_REBOOT_CMD_RESTART2 as the cmd. However as you mentioned the 
coreutils reboot or busybox's reboot do not support these options so I 
will write a shell script to wrap the system call.
