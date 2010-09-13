From: simon@sequanux.org (Simon Guinot)
Date: Mon, 13 Sep 2010 10:10:39 +0000
Subject: Maximum bootable kernel size in current ARM linux
In-Reply-To: <AANLkTimti4ajAOR0_aZ8aeGu9PN4a0MX8dbpg6dpZJYf@mail.gmail.com>
References: <4C8DD588.7040009@endruntechnologies.com>
	<201009131043.48688.marek.vasut@gmail.com>
	<AANLkTimti4ajAOR0_aZ8aeGu9PN4a0MX8dbpg6dpZJYf@mail.gmail.com>
Message-ID: <20100913101039.GC2614@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 13, 2010 at 05:56:30PM +0800, Haojian Zhuang wrote:
> On Mon, Sep 13, 2010 at 4:43 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Dne Po 13. z??? 2010 09:40:56 Bruce M. Penrod napsal(a):
> >> This seems like a pretty straightforward question, but extensive web
> >> searching hasn't shown a really clear, up-to-date answer. ?The most
> >> recent info is circa 2004 and states that 4MB is the largest
> >> uncompressed ARM kernel that may be loaded. ?Not being an ARM assembly
> >> guru (head.S baffles me), I'd like to know if that is still true in
> >> 2010, and if it is, why?
> >>
> >> I'm having one hell of a time compiling a monolithic kernel and keeping
> >> it under 4M without leaving out some core networking features I need.
> >> ?From my searching, it looks like x86 has either removed the limit or
> >> raised it to a much higher number. ?It's not clear to me why a 32 bit
> >> processor would not be able to boot a kernel larger than 4 MB.
> >
> > Hey, CCed Russell.
> >
> > Btw. this shouldn't be true anymore. On the other hand, why do you need such a
> > huge kernel?
> >
> > It's not even possible to create kernel that big if you don't have some kind of
> > initramfs in, right? Besides, you can use some kind of a compression, like LZMA
> > or something to keep the size down.
> >
> > Cheers
> 
> If initramfs is built in, we'll get a huge kernel. Even using LZMA, my
> kernel size is near 5MB.

The initramfs is located at the end of the init section and before the
text section. Because the kernel must be able to 'branch' between the
init and text sections, the initramfs size can't be greater than the
'branch' maximum offset. 32MB ?

I guess that relocate the initramfs just after the text section should
break this limitation.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100913/8210778f/attachment-0001.sig>
