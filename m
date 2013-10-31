From: jiada_wang@mentor.com (jiada)
Date: Wed, 30 Oct 2013 22:31:54 -0700
Subject: [PATCH] ARM: imx: replace imx6q_restart() with mxc_restart()
In-Reply-To: <20131030175426.GK16735@n2100.arm.linux.org.uk>
References: <1381050370-3301-1-git-send-email-shawn.guo@linaro.org>
 <857E9EDCA6C0904DB3357321AA9123EB62506837@NA-MBX-01.mgc.mentorg.com>
 <5264A06B.2040202@mentor.com>
 <20131021045917.GH17165@S2101-09.ap.freescale.net>
 <857E9EDCA6C0904DB3357321AA9123EB62506BEA@NA-MBX-01.mgc.mentorg.com>
 <5264C615.4070504@mentor.com>
 <20131021070451.GI17165@S2101-09.ap.freescale.net>
 <526DCED3.2070704@mentor.com>
 <20131028074524.GE2839@S2101-09.ap.freescale.net>
 <5270793E.9000605@mentor.com> <20131030175426.GK16735@n2100.arm.linux.org.uk>
Message-ID: <5271EB4A.2080707@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 10/30/2013 10:54 AM, Russell King - ARM Linux wrote:
> On Tue, Oct 29, 2013 at 08:13:02PM -0700, jiada wrote:
>> Hi
>>
>> On 10/28/2013 12:45 AM, Shawn Guo wrote:
>>> 1. Apply the following change
>>>
>>> https://git.linaro.org/gitweb?p=people/shawnguo/linux-2.6.git;a=commitdiff;h=6050d181a4fd4abb745506a6e565d55f1f9df964
>>>
>>> 2. Remove imx_src_prepare_restart() from imx6q_restart().
>>>
>>> I will send a patch against the latest kernel.
>>>
>> Thanks Shawn, I have verified with these two changes,
>> system reboot by "echo b > /proc/sysrq-trigger" works
>> for me.
>
> The test you really want to do is a reboot via serial console: <break> b.
> That's definitely the one which will get you if your restart handler has
> anything in it which sleeps.  This will definitely call the restart
> handler from IRQ context.
>
Yes, I tested both "echo b > /proc/sysrq-trigger" and console: <break> b
reboot, but with out this fix patch, previously I saw problem when
reboot by "echo b > /proc/sysrq-trigger".
with this fix patch, both way work fine.


Thanks,
Jiada
