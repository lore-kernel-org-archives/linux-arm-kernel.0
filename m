From: narkewoody@gmail.com (Woody Wu)
Date: Wed, 30 Jan 2013 07:52:57 +0800
Subject: s3c2410 (Linux 2.6.36) Incorrect DRAM size
In-Reply-To: <CA+E=qVe3=cCLuELB7tuHp2Qis6_2EL_Q_XgC+aUk4398HysPSQ@mail.gmail.com>
References: <slrnkactau.29u.narkewoody@zuhnb712.local.com>
 <CA+E=qVe3=cCLuELB7tuHp2Qis6_2EL_Q_XgC+aUk4398HysPSQ@mail.gmail.com>
Message-ID: <CAAsE_uda4mKwOQ-4br-0Q7ZM46dFatRGi2GddVNJ98thXw84iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012-11-17 AM1:29?"Vasily Khoruzhick" <anarsoul@gmail.com>???
>
> On Fri, Nov 16, 2012 at 8:19 PM, Woody Wu <narkewoody@gmail.com> wrote:
> > Hi,
> >
> > I just buit a 2.6.36 and boot it from a s3c2410 board.  At the very
> > beginning of consol log, the kernel reports the DRAM size if 16M.
> > (Memory: 16M = 16M total).  But the board actually has 64M ram in two
> > bands (each is 32M).
> >
> > Did someone know the cause and have a hint or solution? And, does anyone
> > knows that the DRAM size is auto-detected by kernel or hard configured
> > in some .h?
>
> Bootloader passes ATAGs with memory location and size, so something's
> wrong with your bootloader.

Sorry only see ur reply after such long time.  The problem solved. The
bootloader did not have a problem, but it was not passing ATAGs, so I have
to config the kernel to parse old parameter format.

Thanks anyway.
>
> Regards
> Vasily
>
> > Thanks in advance
> >
> > --
> > -woody
> > I can't go back to yesterday - because I was a different person then.
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130130/51e68791/attachment-0001.html>
