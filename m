From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 12 Aug 2013 21:58:53 +0100
Subject: SCSI bus failures with qemu-arm in kernel 3.8+
In-Reply-To: <52093133.9050306@windriver.com>
References: <5207B3C3.9080508@roeck-us.net>
 <20130811220450.GY23006@n2100.arm.linux.org.uk>
 <52082EF8.10005@roeck-us.net> <52093133.9050306@windriver.com>
Message-ID: <CAFEAcA--pjr8fqH6MdTr5P64PhteeJA=HXfAXFhPJ0ctQGpf_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 August 2013 20:02, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
>
> If I recall correctly, I'd showed the patch to Russell at the time (via
> IRC, I believe) and he'd told me essentially the same thing as the above
> paragraph, which is why I didn't put it in the patch system, and why the
> commit log of the yocto patch (http://goo.gl/riEZXY) reads as it does
> (i.e. it is unclear what the real swizzle is).

That patch reads like "make the kernel work with old (pre 1.5)
QEMU behaviour" (where every IRQ for every PCI card was always
IRQ27). I'm committing to making QEMU continue to support that
for backward compatibility, as well as to "work like hardware"
(our autodetect hack is based on what the kernel writes to
PCI_INTERRUPT_LINE), so in that sense it's a stable and well
defined[*] thing to write to, but for mainline I imagine the
kernel will want to just go for the 'work on real h/w' approach.

[*] by which I mean "not written down outside the QEMU source
code but I will write it up if you need it" :-)

-- PMM
