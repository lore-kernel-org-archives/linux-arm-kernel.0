From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Aug 2013 15:16:35 +0100
Subject: Start symbol for an compressed kernel
In-Reply-To: <CANEcUBV1C2DETTrKBW5T_LndgsyzyP4TU9h4v7mjF==Ycy2KLw@mail.gmail.com>
References: <CANEcUBUg++5UcKPKy+uUfJkfZRqt3C-52gCTV0ov76=GSH2fYg@mail.gmail.com>
 <20130817134832.GJ23006@n2100.arm.linux.org.uk>
 <CANEcUBX8TNvTTbTP9+uLEeHNez_ofCfkFrduRA=WVaWxA6njBQ@mail.gmail.com>
 <20130817135751.GL23006@n2100.arm.linux.org.uk>
 <CANEcUBV1C2DETTrKBW5T_LndgsyzyP4TU9h4v7mjF==Ycy2KLw@mail.gmail.com>
Message-ID: <20130817141635.GM23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 17, 2013 at 10:03:32PM +0800, zhaobin xv wrote:
> 2013/8/17 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > On Sat, Aug 17, 2013 at 09:56:14PM +0800, zhaobin xv wrote:
> >> 2013/8/17 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> >> > On Sat, Aug 17, 2013 at 07:39:46PM +0800, zhaobin xv wrote:
> >> >> how to find Start symbol for an compressed kernel for arm
> >> >
> >> > The start address of a compressed kernel is the first byte of the image.
> >> >
> >> > Symbolically, that is 'start', which is a non-global symbol.  However,
> >> > this symbol is useless since it normally is zero, because the entire
> >> > image is relocatable and therefore built for address zero.
> >> >
> >> > However, it is normal to load the image not at address zero.
> >>
> >> why do U define ENTRY(_start)?
> >> Is _start the Start symbol?
> >> how to explain _start
> >
> > There is no _start symbol in the compressed kernel.
> 
> But there is ENTRY(_start) and _start in
> linux-2.6.22.6\arch\arm\boot\compressed/head.S

There is no mainline -final kernel with ENTRY(_start) in that file.
I would be really surprised to find that a stable kernel ever introduced
such a thing without it being in a mainline kernel first.  Therefore, I
believe you are mistaken that a vanilla 2.6.22.6 has this.

You may have a modified 2.6.22.6 kernel source there.
