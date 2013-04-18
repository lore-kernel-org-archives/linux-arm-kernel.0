From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 18 Apr 2013 12:01:32 +0200
Subject: [RFC] arm64: Early printk support for virtio-mmio console devices.
In-Reply-To: <CAAHg+HiHKV+8hBT1QWe4hSxocCX6wpRd3bCPWB7zU8jVFmPuAA@mail.gmail.com>
References: <1366264344-28025-1-git-send-email-pranavkumar@linaro.org>
 <87wqs02uws.fsf@rustcorp.com.au>
 <CAAHg+HiHKV+8hBT1QWe4hSxocCX6wpRd3bCPWB7zU8jVFmPuAA@mail.gmail.com>
Message-ID: <20130418100132.GE4998@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:02 Thu 18 Apr     , Pranavkumar Sawargaonkar wrote:
> On 18 April 2013 12:21, Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > PranavkumarSawargaonkar <pranavkumar@linaro.org> writes:
> > > From: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> > >
> > > This patch implements early printk support for virtio-mmio console devices without using any hypercalls.
> >
> > This makes some sense, though not sure that early console *read* makes
> > much sense.  I can see the PCI version of this being useful as well.
> 
> Read can be useful for "mach-virt" which will have only virtio console
> as a console device. Then if someone wants to have UEFI or any other
> boot-loader emulation, which expects user to input few things, in that
> case read might become handy.

yes I'm adding barebox on arm64 and will need it for virt target

Best Regards,
J.
> >
> >
> > The spec definition for this will be interesting, because it can be used
> > before the device is initialized (something which is generally
> > verboten).
> >
> > Cheers,
> > Rusty.
> 
> Thanks,
> Pranav
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
