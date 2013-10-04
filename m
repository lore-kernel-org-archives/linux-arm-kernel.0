From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 3 Oct 2013 22:26:03 -0300
Subject: [PATCH] imx6q: fix emergency restart
In-Reply-To: <1380832337-4637-1-git-send-email-nathan_lynch@mentor.com>
References: <1380832337-4637-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <CAOMZO5C1VBN_T0SQvNXg5x9BKOqoyPMu_v6QQ+E8-Ej94eJodg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nathan,

On Thu, Oct 3, 2013 at 5:32 PM, Nathan Lynch <nathan_lynch@mentor.com> wrote:
> Emergency restart (e.g. sysrq-b) BUGs and panics on i.MX6Q SABRE Lite:
>
> kernel BUG at mm/vmalloc.c:1305!
> Internal error: Oops - BUG: 0 [#1] SMP ARM
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.12.0-rc3-00059-g522d6d3-dirty #29
> task: c0cf15d8 ti: c0ce6000 task.ti: c0ce6000
> PC is at __get_vm_area_node.isra.36+0xe8/0xf8
> LR is at get_vm_area_caller+0x40/0x48
> pc : [<c00be184>]    lr : [<c00bed1c>]    psr: 20000193
> sp : c0ce7db8  ip : c0ce6000  fp : 00004000
> r10: c0cf2ab0  r9 : 020bc000  r8 : f0000000
> r7 : 00000001  r6 : 000000d0  r5 : 00000001  r4 : c0ce7db8
> r3 : 00010000  r2 : 00000001  r1 : 00000001  r0 : 00004000
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c5387d  Table: 3eec404a  DAC: 00000015
> Process swapper/0 (pid: 0, stack limit = 0xc0ce6240)

Not related to your patch, but when I run:

echo c > /proc/sysrq-trigger

Then I wait sometime, but watchdog never resets the system.

Also, if I pass an invalid root file system, system crashes as
expected, but watchdog never resets.

However, if I do:

echo 0 > /dev/watchdog, then after 60 seconds the watchdog resets the board.

I haven't debugged this yet, but I thought that the first two methods
above should also trigger a watchdog reset.

Regards,

Fabio Estevam
