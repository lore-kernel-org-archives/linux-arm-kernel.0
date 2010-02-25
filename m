From: rmelizalde@gmail.com (=?UTF-8?B?UmljYXJkbyBNYXJ077+9bmV6?=)
Date: Thu, 25 Feb 2010 13:00:32 +0100
Subject: Boot up & soft reboot Problems enabling & disabling MMU Discontiguous
	Memory
Message-ID: <515f88701002250400y3ae949caw918e9b4d202b9cad@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all

We have an ARM926ej based custom board with 32MB of discontiguous DDRII RAM.
Memory MAP is 0 to 8M, 16 to 24M, 32 to 40M and 48 to 56Megabytes.

Everything works perfectly (Linux boot) but sometimes, when we soft reboot
(kernel_restart()) system hangs in two different places randomly:
-   Switching off MMU in cpu_arm926_reset() in proc-arm926.S
-   Switching ON MMU in head.S __turn_mmu_on.

Linux version is 2.6.18 (I know it is quite out-of-date, but can't upgrade
due to some annoying & not linux issues). I was wondering if someone has
experienced this problems and mainly if this can be caused because of
DISCONTIGUOUS memory map.

Thanks in advance
Ricardo
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100225/5b13c367/attachment-0001.htm>
