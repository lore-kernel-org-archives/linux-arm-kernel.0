From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 21 Feb 2017 12:41:53 +0100
Subject: [PATCH v2 2/5] KVM: arm/arm64: Add ARM user space interrupt
 signaling ABI
In-Reply-To: <CAFEAcA-HMZnjbnhDC-13rWuQP-X2pk-W-6DvSR8n9_f-e4R=cA@mail.gmail.com>
References: <20170203145655.15007-1-cdall@linaro.org>
 <20170203145655.15007-3-cdall@linaro.org>
 <CAFEAcA-HMZnjbnhDC-13rWuQP-X2pk-W-6DvSR8n9_f-e4R=cA@mail.gmail.com>
Message-ID: <20170221114153.GA26976@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alex,

On Fri, Feb 03, 2017 at 05:51:18PM +0000, Peter Maydell wrote:
> On 3 February 2017 at 14:56, Christoffer Dall <cdall@linaro.org> wrote:
> > From: Christoffer Dall <christoffer.dall@linaro.org>
> >
> > We have 2 modes for dealing with interrupts in the ARM world. We can
> > either handle them all using hardware acceleration through the vgic or
> > we can emulate a gic in user space and only drive CPU IRQ pins from
> > there.
> >
> > Unfortunately, when driving IRQs from user space, we never tell user
> > space about events from devices emulated inside the kernel, which may
> > result in interrupt line state changes, so we lose out on for example
> > timer and PMU events if we run with user space gic emulation.
> >
> > Define an ABI to publish such device output levels to userspace.
> >
> > Signed-off-by: Alexander Graf <agraf@suse.de>
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
> 
> Acked-by: Peter Maydell <peter.maydell@linaro.org>
> 
> for the userspace ABI/docs part.
> 

Given Peter's ack on this ABI, any chance you could take a look at
fixing the userspace SMP issue and respinning the userspace patches for
this series?

Thanks,
-Christoffer
