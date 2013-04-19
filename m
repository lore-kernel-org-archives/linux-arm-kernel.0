From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Apr 2013 17:22:26 +0100
Subject: [RFC] arm64: Early printk support for virtio-mmio console devices.
In-Reply-To: <CAFEAcA-F18kR4JihdxaLTm3qb4n51tsygG1RW4djwJ0u9+FQqw@mail.gmail.com>
References: <CAAHg+HhtCorArCmx=ha0=64+SJZiizzrDUKSPLV=N+OzO8zAxQ@mail.gmail.com>
 <20130419090558.GA13283@mudshark.cambridge.arm.com>
 <CAAHg+HipCX2ma6brxj9Kgc3ew39b5e30grLwyun9CViif-5wZQ@mail.gmail.com>
 <20130419092752.GB13283@mudshark.cambridge.arm.com>
 <CAFEAcA8j124G=vaHObJ_w5wOhUiS3KYKbjMnigbnr6mgwFxZUg@mail.gmail.com>
 <CAAHg+Hg=t97SJ0JPZYgrZaL+zimo-wbezwaj1BQvHqE-vf4VDA@mail.gmail.com>
 <20130419093953.GD13283@mudshark.cambridge.arm.com>
 <CAFEAcA_WfYpyvq54rZqS8JZkmDF5JXB+CNHFH5CnrhKun52uzA@mail.gmail.com>
 <20130419161201.GA5383@localhost.cambridge.arm.com>
 <CAFEAcA-F18kR4JihdxaLTm3qb4n51tsygG1RW4djwJ0u9+FQqw@mail.gmail.com>
Message-ID: <20130419162226.GB5383@localhost.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 19, 2013 at 05:14:36PM +0100, Peter Maydell wrote:
> On 19 April 2013 17:12, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Apr 19, 2013 at 11:05:47AM +0100, Peter Maydell wrote:
> >> Please make the kernel pick the device out of the device tree
> >> blob. The whole point of device tree is that it's how to tell
> >> the kernel where things live -- making kvmtool/QEMU and/or the
> >> user also have to mess with the kernel command line is awkward
> >> and annoying.
> >
> > For a normal console device, it indeed needs to get it from the DT. For
> > early console, you want it earlier than DT parsing so we pass it on the
> > kernel command line via the earlyprintk= parameter.
> 
> You should fix your DT handling code so you can get at the info
> when you need it rather than pushing the problem into bootloaders
> and QEMU, please. DT is your data structure so feel free to
> (re)design it so relevant information can be accessed early
> if that's useful.

earlyprintk is used for debugging early problems, like DT parsing. You
don't have to use it unless you are debugging something. Without
earlyprintk you just get a normal console during boot, based on the DT
description.

-- 
Catalin
