From: agraf@suse.de (Alexander Graf)
Date: Thu, 18 Apr 2013 10:44:32 +0200
Subject: [RFC] arm64: Early printk support for virtio-mmio console devices.
In-Reply-To: <CAAHg+HiHKV+8hBT1QWe4hSxocCX6wpRd3bCPWB7zU8jVFmPuAA@mail.gmail.com>
References: <1366264344-28025-1-git-send-email-pranavkumar@linaro.org>
 <87wqs02uws.fsf@rustcorp.com.au>
 <CAAHg+HiHKV+8hBT1QWe4hSxocCX6wpRd3bCPWB7zU8jVFmPuAA@mail.gmail.com>
Message-ID: <47354634-CA37-47E3-99D2-D4DDB08A9870@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Am 18.04.2013 um 09:32 schrieb Pranavkumar Sawargaonkar <pranavkumar@linaro.org>:

> On 18 April 2013 12:21, Rusty Russell <rusty@rustcorp.com.au> wrote:
>> 
>> PranavkumarSawargaonkar <pranavkumar@linaro.org> writes:
>>> From: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>>> 
>>> This patch implements early printk support for virtio-mmio console devices without using any hypercalls.
>> 
>> This makes some sense, though not sure that early console *read* makes
>> much sense.  I can see the PCI version of this being useful as well.
> 
> Read can be useful for "mach-virt" which will have only virtio console
> as a console device. Then if someone wants to have UEFI or any other
> boot-loader emulation, which expects user to input few things, in that
> case read might become handy.

A boot loader should easily be able to implement virtio-console for real.

In fact, you should be able to do a simple virtio-console implementation for early printk too, that polls the host for acks rather than use interrupts. Check out my s390-zipl code for reference. I use that there.

The advantage to that would be that no host changes are required whatsoever and the interface strictly stays as it is.


Alex
