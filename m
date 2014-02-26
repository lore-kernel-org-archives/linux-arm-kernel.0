From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 26 Feb 2014 22:54:08 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <CAL_Jsq+3jBdca9zVnxHG+7pxy2_316emsP=PB3WkTMQP0JYBYQ@mail.gmail.com>
References: <20140226183454.GA14639@cbox> <5553754.0b4gMg5OS7@wuerfel>
 <CAL_Jsq+3jBdca9zVnxHG+7pxy2_316emsP=PB3WkTMQP0JYBYQ@mail.gmail.com>
Message-ID: <CAFEAcA8u6u8Hh=qn8XE2Evc93_-pkZPSDSShm-eiSn-vcsYgKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 February 2014 22:49, Rob Herring <robherring2@gmail.com> wrote
> The SBSA only spec's a very minimal pl011 subset which is only
> suitable for early serial output. Not only is there no DMA, but there
> are no interrupts and maybe no input.

No interrupts on a UART in a VM (especially an emulated one)
is a good way to spend all your time bouncing around in I/O
emulation of the "hey can we send another byte yet?" register...

> I think it also assumes the uart
> is enabled and configured already by firmware. It is all somewhat
> pointless because the location is still not known or discoverable by
> early code.

This sounds like we should specify and implement something
so we can provide this information in the device tree. Telling
the kernel where the hardware is is exactly what DT is for, right?

> I think the VM image just has to support pl011, virtio-console, and
> xen console. Arguably, an 8250 should also be included in interest of
> making things just work.

What does the 8250 have to recommend it over just providing
the PL011?

thanks
-- PMM
