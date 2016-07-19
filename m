From: dave.long@linaro.org (David Long)
Date: Tue, 19 Jul 2016 15:38:38 -0400
Subject: [PATCH v15 00/10] arm64: Add kernel probes (kprobes) support
In-Reply-To: <20160719182744.GI21256@e104818-lin.cambridge.arm.com>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <20160719182744.GI21256@e104818-lin.cambridge.arm.com>
Message-ID: <578E81BE.3060100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/19/2016 02:27 PM, Catalin Marinas wrote:
> On Fri, Jul 08, 2016 at 12:35:44PM -0400, David Long wrote:
>> From: "David A. Long" <dave.long@linaro.org>
>>
>> This patchset is heavily based on Sandeepa Prabhu's ARM v8 kprobes patches,
>> first seen in October 2013. This version attempts to address concerns
>> raised by reviewers and also fixes problems discovered during testing.
>>
>> This patchset adds support for kernel probes(kprobes), jump probes(jprobes)
>> and return probes(kretprobes) support for ARM64.
>
> Some more errors with this patchset applied and CONFIG_NET_TCPPROBE
> enabled (it's fine with this option disabled though). I boot on a Juno
> with NFS over UDP and then try to ssh into it (hence establish the first
> TCP connection):
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000003
> pgd = ffff000008ceb000
> [00000003] *pgd=00000009fff6d003, *pud=00000009fff6c003, *pmd=0000000000000000
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.7.0-rc4+ #9
> Hardware name: ARM Juno development board (r0) (DT)
> task: ffff800976901900 ti: ffff800976910000 task.ti: ffff800976910000
> PC is at enqueue_task_fair+0x818/0x1188
> LR is at enqueue_task_fair+0x8a4/0x1188
> pc : [<ffff0000080e73d8>] lr : [<ffff0000080e7464>] pstate: 600001c5
> sp : ffff80097fec3a80


[...]

I've reproduced the failure on hikey. I'm looking at it.

-dl
