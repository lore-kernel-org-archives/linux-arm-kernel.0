From: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 22 Apr 2013 10:51:13 +0930
Subject: [RFC] arm64: Early printk support for virtio-mmio console devices.
In-Reply-To: <CAAHg+HiHKV+8hBT1QWe4hSxocCX6wpRd3bCPWB7zU8jVFmPuAA@mail.gmail.com>
References: <1366264344-28025-1-git-send-email-pranavkumar@linaro.org>
 <87wqs02uws.fsf@rustcorp.com.au>
 <CAAHg+HiHKV+8hBT1QWe4hSxocCX6wpRd3bCPWB7zU8jVFmPuAA@mail.gmail.com>
Message-ID: <87ehe3bbsm.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pranavkumar Sawargaonkar <pranavkumar@linaro.org> writes:
> On 18 April 2013 12:21, Rusty Russell <rusty@rustcorp.com.au> wrote:
>>
>> PranavkumarSawargaonkar <pranavkumar@linaro.org> writes:
>> > From: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> >
>> > This patch implements early printk support for virtio-mmio console devices without using any hypercalls.
>>
>> This makes some sense, though not sure that early console *read* makes
>> much sense.  I can see the PCI version of this being useful as well.
>
> Read can be useful for "mach-virt" which will have only virtio console
> as a console device. Then if someone wants to have UEFI or any other
> boot-loader emulation, which expects user to input few things, in that
> case read might become handy.

But implementing virtio inside a bootloader has already been done for
coreboot, for example.  A bootloader probably wants a virtio block
device, so a console is trivial.

A single writable field for debugging makes sense.  Anything more is far
less certain.

Thanks,
Rusty.
