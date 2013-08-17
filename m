From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 17 Aug 2013 18:12:04 +0400
Subject: =?UTF-8?B?UmU6IFN0YXJ0IHN5bWJvbCBmb3IgYW4gY29tcHJlc3NlZCBrZXJuZWw=?=
References: <CANEcUBUg++5UcKPKy+uUfJkfZRqt3C-52gCTV0ov76=GSH2fYg@mail.gmail.com>
 <20130817135751.GL23006@n2100.arm.linux.org.uk>
Message-ID: <1376748724.761782391@f272.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

I always thought that the "start" is necessary for the compiler to tell it
what is at the beginning of the program. So, on my opinion this is just
a way to tell to gcc where we should place initial kernel data.

---
