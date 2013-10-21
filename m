From: jiada_wang@mentor.com (jiada)
Date: Sun, 20 Oct 2013 23:13:41 -0700
Subject: [PATCH] ARM: imx: replace imx6q_restart() with mxc_restart()
In-Reply-To: <857E9EDCA6C0904DB3357321AA9123EB62506BEA@NA-MBX-01.mgc.mentorg.com>
References: <1381050370-3301-1-git-send-email-shawn.guo@linaro.org>
 <857E9EDCA6C0904DB3357321AA9123EB62506837@NA-MBX-01.mgc.mentorg.com>
 <5264A06B.2040202@mentor.com>
 <20131021045917.GH17165@S2101-09.ap.freescale.net>
 <857E9EDCA6C0904DB3357321AA9123EB62506BEA@NA-MBX-01.mgc.mentorg.com>
Message-ID: <5264C615.4070504@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn

On 10/20/2013 10:53 PM, Wang, Jiada (ESD) wrote:
> On Sun, Oct 20, 2013 at 08:32:59PM -0700, jiada wrote:
>> the difference between successful "echo b > /proc/sysrq-trigger"
>> reboot and the failure one is:
>> whether CPU0 is firstly stopped or not
>
> Do you have commit a985941 (kernel/sys.c: call disable_nonboot_cpus() in
> kernel_restart()) on your 3.5 kernel.  The commit can be found on 3.5.7 kernel.
>
> Shawn
>
currently my kernel/sys.c is at
f36854c: reboot: rigrate shutdown/reboot to boot cpu
which means I have your commit: a985941

I tried to checkout upstream kernel at commit: f36854c
even without your "ARM: imx: replace imx6q_restart() with mxc_restart()" 
patch
I can reproduce system hang issue by "echo b > /proc/sysrq-trigger"

Thanks,
Jiada
