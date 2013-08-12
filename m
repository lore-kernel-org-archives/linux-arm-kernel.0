From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Mon, 12 Aug 2013 15:29:45 +0530
Subject: Kexec: BE kernel on ARM VE TC2
In-Reply-To: <20130808215034.GE19383@mudshark.cambridge.arm.com>
References: <CALicx6ueLxCFCeun1grdtcC21HSkCDfenLWOSfuoSJnhx9GZ6w@mail.gmail.com>
 <20130808215034.GE19383@mudshark.cambridge.arm.com>
Message-ID: <CALicx6sjPOBRVVOQGOt4CgRCPg+4eOhwmrGC=ZjpZg+LGSvDrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 9, 2013 at 3:20 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Mon, Aug 05, 2013 at 01:12:17PM +0100, Vijay Kilari wrote:
>> Hi Will,
>>
>> I am trying to make kexec work on BE kernel on ARM VE TC2.
>>
>> First, to make KEXEC work with SMP on ARM VE TC2 board,
>> I set nr_cpus=2 (i.e boot only A15's) this works with LE kernel.
>
> Interesting, is this with a mainline kernel? I don't see how SMP kexec can
> work on TC2 without additional patches to park the secondary cores safely.
>

Yes, it is our internal kernel based on 3.10.3. I have not made any changes
related to this. I found that booting only 2 CPU's works
and I continue to check Kdump and other features on top of this.

However with Big Endian, I see that Kexec is not stable. I suspect
that UART is the issue. because playing around with some printk and delays
make it work. Any help? I plan to reset pl011 before kexec softreset.
But could not find any register to reset complete pl011 uart.
I will try to reset/clear IMSC, ICR and CR registers of pl011 and check.

Note: On Kexec with CONFIG_KEXEC_JUMP disabled, the softreboot happens
without resetting/shutdown of any devices


> Will
