From: robherring2@gmail.com (Rob Herring)
Date: Wed, 26 Feb 2014 17:08:38 -0600
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <CAFEAcA8u6u8Hh=qn8XE2Evc93_-pkZPSDSShm-eiSn-vcsYgKA@mail.gmail.com>
References: <20140226183454.GA14639@cbox> <5553754.0b4gMg5OS7@wuerfel>
 <CAL_Jsq+3jBdca9zVnxHG+7pxy2_316emsP=PB3WkTMQP0JYBYQ@mail.gmail.com>
 <CAFEAcA8u6u8Hh=qn8XE2Evc93_-pkZPSDSShm-eiSn-vcsYgKA@mail.gmail.com>
Message-ID: <CAL_JsqJ+mXadxLHqFw6uXvM9=juC-emKT7G-d-_PLYbXNSX7Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 4:54 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 26 February 2014 22:49, Rob Herring <robherring2@gmail.com> wrote
>> The SBSA only spec's a very minimal pl011 subset which is only
>> suitable for early serial output. Not only is there no DMA, but there
>> are no interrupts and maybe no input.
>
> No interrupts on a UART in a VM (especially an emulated one)
> is a good way to spend all your time bouncing around in I/O
> emulation of the "hey can we send another byte yet?" register...
>
>> I think it also assumes the uart
>> is enabled and configured already by firmware. It is all somewhat
>> pointless because the location is still not known or discoverable by
>> early code.
>
> This sounds like we should specify and implement something
> so we can provide this information in the device tree. Telling
> the kernel where the hardware is is exactly what DT is for, right?

Yes, I'm looking into that, but that's not really a concern for this
doc as early output is a debug feature.

>> I think the VM image just has to support pl011, virtio-console, and
>> xen console. Arguably, an 8250 should also be included in interest of
>> making things just work.
>
> What does the 8250 have to recommend it over just providing
> the PL011?

As I mentioned, it will just work for anything that expects the serial
port to be ttyS0 as on x86 rather than ttyAMA0. Really, I'd like to
see ttyAMA go away, but evidently that's not an easily fixed issue and
it is an ABI.

Rob
