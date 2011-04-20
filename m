From: matt@0xlab.org (Matt Hsu)
Date: Wed, 20 Apr 2011 07:14:34 -0000
Subject: [TuxOnIce-devel] [RFC PATCH] Current status, suspend-to-disk
	support on ARM
In-Reply-To: <alpine.DEB.2.00.1104191859260.4937@localhost6.localdomain6>
References: <alpine.DEB.2.00.1104041424310.690@localhost6.localdomain6>
	<20110412183208.GC26916@elf.ucw.cz>
	<alpine.DEB.2.00.1104131020080.29883@localhost6.localdomain6>
	<201104132338.03003.rjw@sisk.pl>
	<alpine.DEB.2.00.1104141747310.9967@localhost6.localdomain6>
	<BANLkTinroLCypX-iG0xGpnyxBk=P5TVtJQ@mail.gmail.com>
	<alpine.DEB.2.00.1104191859260.4937@localhost6.localdomain6>
Message-ID: <BANLkTinp1+6Ocmy5LAUEiPwAje+VnrTo9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> Also, I'd like to investigate whether ARM will require a set of
> platform_hibernation_ops - Samsung's patch from last December,
>
> http://www.spinics.net/lists/arm-kernel/msg108565.html
>

    Hi FrankH,

     The patch seems has connection with this

     www.kernel.org/doc/ols/2010/ols2010-pages-9-18.pdf

    You can see the section 4.3 fast device reactivation.
    It does the similar thing  as STR, but drivers status are kept in
hibernation image instead of main memory.
    I guess this is why this patch comes out.

    In the current device driver model, there are no appropriate handling
specific to
    hibernation_suspend/hibernation_resume ops.

    So they make their own interface/platform drivers.


> seems to indicate that they believe it's necessary at least on some ARM
> hardware. OMAP has similar functions to that, it'd be great to unify.
>
>
> FrankH.
>
>
> --
- Matt
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110420/37618720/attachment-0001.html>
