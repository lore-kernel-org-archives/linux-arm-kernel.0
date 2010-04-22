From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Thu, 22 Apr 2010 13:09:03 +0100
Subject: Can I use VFP in work queue context ?
References: <2A1038AD87AFFA4291065666737B4EAA08CB0BA1BC@dlee06.ent.ti.com>
	<20100422100939.GG6684@trinity.fluff.org>
Message-ID: <yw1x8w8f1yg0.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks <ben-linux@fluff.org> writes:

> On Wed, Apr 21, 2010 at 06:11:18PM -0500, Anbumony, Kasi Lakshman Karthi wrote:
>> I have done some optimization in NEON (Neon/VFP sharing the same
>> register set) and using it in my driver running in (Linux) kernel
>> space. The neon optimized code will be used under a work queue
>> context and not under any interrupt. Going by the design of Linux
>> kernel, it looks like there is no context save and restore on VFP
>> registers whenever there is a context switch from user mode to
>> kernel mode, but Linux handles the same for user space processes.
>> 
>> Currently I am not seeing any issues (may be lucky) with my
>> implementation (any exceptions) and was wondering whether it is
>> safe to use of neon code in work queue context? My development
>> platform is OMAP 3 (ARM cortex A-8) and using Android with Linux
>> kernel: 2.6.29.
>
> No FP in the kernel.
>
> I expect this applies to NEON too.

Same registers, so yes.

-- 
M?ns Rullg?rd
mans at mansr.com
