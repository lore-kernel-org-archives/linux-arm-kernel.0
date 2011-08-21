From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Aug 2011 09:53:29 +0100
Subject: [RFC PATCH 2/2] ARM: CSR: add PM sleep entry for SiRFprimaII
In-Reply-To: <CAGsJ_4yon5jPkwVkohiokSm1=_gNG=+Hvv55JYQ7-BeHxPkeaA@mail.gmail.com>
References: <1312512888-25070-1-git-send-email-bs14@csr.com>
	<1312512888-25070-3-git-send-email-bs14@csr.com>
	<20110814075927.GB4986@n2100.arm.linux.org.uk>
	<CAGsJ_4yigTt40g0-9jrz5qAbdrQdsXuQ65MhX+x1AZ1M4Ztr=w@mail.gmail.com>
	<20110815082027.GA26827@n2100.arm.linux.org.uk>
	<CAGsJ_4wyGUC=gNagaGGVcr=+nrJU2xjGJDxwS+H-UKPLajrLpg@mail.gmail.com>
	<CAGsJ_4yon5jPkwVkohiokSm1=_gNG=+Hvv55JYQ7-BeHxPkeaA@mail.gmail.com>
Message-ID: <20110821085329.GF12028@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 09:34:35AM +0800, Barry Song wrote:
> 2011/8/15 Barry Song <21cnbao@gmail.com>:
> > 2011/8/15 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> >> On Mon, Aug 15, 2011 at 03:43:13PM +0800, Barry Song wrote:
> >>> Sorry, my fault. i simply picked these lines which have been verified
> >>> to be working in local old 2.6.38.8 kernel and really didn't think and
> >>> refine more carefully.
> >>> in deep sleep mode, SiRFprimaII will powerdown CPU core.
> >>
> >> ... just like everyone else.
> >>
> >>> due to this,
> >>> i just ignored to delete the codes saving registers of all kinds of
> >>> CPU modes. but it is not the real situation in kernel. For example,
> >>> IRQ mode used the stack of corrupted thread, and kernel was not in
> >>> interrupt while going to pm_ops->enter(), then it is unnecessary to
> >>> enter IRQ and save sp of IRQ:
> >>
> >> No. ?There is _no_ need to save and restore these registers. ?They
> >> can simply be re-setup. ?The generic cpu_suspend stuff already
> >> takes care of that.
> >
> > i did have saied it is not necessary to save and restore if you read
> > my reply carefully :-)
> 
> just as you said, after deleting all codes to save/restore regsiters:
...
> and call cpu_init() to re-setup while resuming, things go well.

Good - so can we have a patch based on the generic cpu suspend support
in the kernel for this SoC please?

Thanks.
