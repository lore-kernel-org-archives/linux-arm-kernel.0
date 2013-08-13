From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Aug 2013 12:15:12 +0100
Subject: Kexec: BE kernel on ARM VE TC2
In-Reply-To: <CALicx6sjPOBRVVOQGOt4CgRCPg+4eOhwmrGC=ZjpZg+LGSvDrg@mail.gmail.com>
References: <CALicx6ueLxCFCeun1grdtcC21HSkCDfenLWOSfuoSJnhx9GZ6w@mail.gmail.com>
 <20130808215034.GE19383@mudshark.cambridge.arm.com>
 <CALicx6sjPOBRVVOQGOt4CgRCPg+4eOhwmrGC=ZjpZg+LGSvDrg@mail.gmail.com>
Message-ID: <20130813111512.GC30280@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 10:59:45AM +0100, Vijay Kilari wrote:
> On Fri, Aug 9, 2013 at 3:20 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Mon, Aug 05, 2013 at 01:12:17PM +0100, Vijay Kilari wrote:
> >> I am trying to make kexec work on BE kernel on ARM VE TC2.
> >>
> >> First, to make KEXEC work with SMP on ARM VE TC2 board,
> >> I set nr_cpus=2 (i.e boot only A15's) this works with LE kernel.
> >
> > Interesting, is this with a mainline kernel? I don't see how SMP kexec can
> > work on TC2 without additional patches to park the secondary cores safely.
> >
> 
> Yes, it is our internal kernel based on 3.10.3. I have not made any changes
> related to this. I found that booting only 2 CPU's works
> and I continue to check Kdump and other features on top of this.

I think 2 CPUs is working by fluke. Try kexecing a Thumb kernel from an ARM
kernel.

> However with Big Endian, I see that Kexec is not stable. I suspect
> that UART is the issue. because playing around with some printk and delays
> make it work. Any help? I plan to reset pl011 before kexec softreset.
> But could not find any register to reset complete pl011 uart.
> I will try to reset/clear IMSC, ICR and CR registers of pl011 and check.

Wait are you trying to kexec a BE kernel from an LE kernel? That would be
similar to the Thumb/ARM case I mentioned above. A better starting point
would be to try UP kernels and get that working first, since we already know
that SMP kexec is broken on TC2.

Will
