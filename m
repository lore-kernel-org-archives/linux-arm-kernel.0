From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Jul 2014 18:32:26 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703170558.GZ32514@n2100.arm.linux.org.uk>
References: <CAMbhsRSzDYqDnLbicYYNq+=J1N8hZ0fu-mik+UNLs0cBfUf8DA@mail.gmail.com>
 <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
 <20140701234800.GA23577@sirena.org.uk>
 <20140702100133.GE18731@arm.com>
 <20140702163923.GJ410@sirena.org.uk>
 <20140702170141.GH24879@arm.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com>
 <CACxGe6vmNamkAzvL8c5qaVEh9kvmTa=gEyr8KgBS1PW+KFc_=Q@mail.gmail.com>
 <20140703170558.GZ32514@n2100.arm.linux.org.uk>
Message-ID: <20140703173226.GC17372@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 06:05:58PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 03, 2014 at 05:22:30PM +0100, Grant Likely wrote:
> > So, no. I completely reject any notion that breaking existing apps is
> > okay. If we're going to say that v8 still supports 32-bit apps, then
> > it has to be all of v7, not just the 'good' bits. Nor do I think
> > saying "it's just a bunch of games" justifies anything. We're kernel
> > engineers. Applications are applications and we don't break userspace.
> > Period.
> 
> +1 on all points above.  I'd go further - if we're going to say that v8
> still supports 32-bit apps, that covers at least v6 *as well*.

We've never pretended to support anything other than ARMv8 in the compat
layer. uname even reports this in the machine name.

If people are suddenly so concerned about *full* compatibility with an ARMv7
kernel, that needs a lot more than just SWP emulation:

  - Alignment fixups for ldm/stm
  - SETEND
  - CP15 barriers
  - SWI breakpoints + branch through zero syscalls
  (- SWP)

By the arguments presented so far, I can't see why we wouldn't also need
OABI too. In other words, where do we draw the line? If we're not completely
compatible, then the compatibility argument suddenly becomes subjective.

It seems that people really want us to implement the subset of the ABI which
is needed by the Google Play store and are trying to dress that up as the
ARMv7 kernel ABI. The latter is a lot more work and conflating the two isn't
especially helpful.

Will
