From: jiada_wang@mentor.com (jiada)
Date: Tue, 29 Oct 2013 20:13:02 -0700
Subject: [PATCH] ARM: imx: replace imx6q_restart() with mxc_restart()
In-Reply-To: <20131028074524.GE2839@S2101-09.ap.freescale.net>
References: <1381050370-3301-1-git-send-email-shawn.guo@linaro.org>
 <857E9EDCA6C0904DB3357321AA9123EB62506837@NA-MBX-01.mgc.mentorg.com>
 <5264A06B.2040202@mentor.com>
 <20131021045917.GH17165@S2101-09.ap.freescale.net>
 <857E9EDCA6C0904DB3357321AA9123EB62506BEA@NA-MBX-01.mgc.mentorg.com>
 <5264C615.4070504@mentor.com>
 <20131021070451.GI17165@S2101-09.ap.freescale.net>
 <526DCED3.2070704@mentor.com>
 <20131028074524.GE2839@S2101-09.ap.freescale.net>
Message-ID: <5270793E.9000605@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 10/28/2013 12:45 AM, Shawn Guo wrote:
> On Sun, Oct 27, 2013 at 07:41:23PM -0700, jiada wrote:
>> as per discussion locally, when do you think you will post the fix patch
>> for the system hang I observed?
>> I would like to test for your patch, and then pull it to my kernel.
>
> Sorry, Jiada.  After another closer look at the fix I provided before,
> it's not correct, because emergency_restart() is a function that is safe
> to call in interrupt context, while migrate_to_reboot_cpu() is not.
> That said, we cannot call migrate_to_reboot_cpu() in emergency_restart()
> at all.
>
> I just found a more easier fix at platform level.  The following is what
> you need to do on your 3.5 kernel.
>
> 1. Apply the following change
>
> https://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=commitdiff;h=6050d181a4fd4abb745506a6e565d55f1f9df964
>
> 2. Remove imx_src_prepare_restart() from imx6q_restart().
>
> I will send a patch against the latest kernel.
>
Thanks Shawn, I have verified with these two changes,
system reboot by "echo b > /proc/sysrq-trigger" works
for me.

> Shawn
>

Thanks,
Jiada
