From: maxime.ripard@free-electrons.com (maxime.ripard at free-electrons.com)
Date: Mon, 23 Sep 2013 21:34:30 +0300
Subject: [PATCH 1/3] Add smp support for Allwinner A20(sunxi 7i).
In-Reply-To: <CAK3cCByGeAK2H83bP0wy=kC_+kj4Q8cFHPQ1gYUJ=uv4gs-T-A@mail.gmail.com>
References: <1379852488-32147-1-git-send-email-cinifr@gmail.com>
 <1379852488-32147-2-git-send-email-cinifr@gmail.com>
 <1379861045.30708.22.camel@dagon.hellion.org.uk>
 <CAK3cCBzMXdeeSPC-OpWcHAuef=ocpy5n0=Fc2yBECPnU=2OTXw@mail.gmail.com>
 <1379920736.30708.26.camel@dagon.hellion.org.uk>
 <CAK3cCByGeAK2H83bP0wy=kC_+kj4Q8cFHPQ1gYUJ=uv4gs-T-A@mail.gmail.com>
Message-ID: <20130923183430.GT2779@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 23, 2013 at 10:43:55PM +0800, cinifr wrote:
> > In which case this kernel patch needs instead to speak the bootloader
> > wakeup protocol instead of speaking to the h/w directly like you've done
> > here, right?
> >
> > Or is it possible for the bootloader to set these things up and then put
> > the CPU back to sleep such that it both retains any settings and is
> > wakable by this patch? This code contains core resets and power control,
> > which makes me suspect not.
> 
> And I think secondary cpus  remains setting after h/w boot.
> >> > Wouldn't it be better to do all this stuff in the bootloader and
> >> either
> >> > implement PSCI or have the bootloader do the traditional holding pen
> >> and
> >> > mbox address thing?
> Uboot doesnot support PSCI, it use  traditional holding pen for sunxi
> platform now.
> 
> >> >
> >> I have modified uboot to set cntfrq and cntvoff in all smp cpus,and it
> >> works well. I guess kernel should believe all cpu should be all same
> >> when kernel boot. Bootloader should do it to ensure that.
> >
> > Yes, I think all CPUs must be in the same state at boot.
> >
> > But if you've done all that then what is this patch for?
> >
> > Do you have links to your u-boot patches?
> >
> > Ian.
> Yes, This is my patch for uboot.
> My working uboot code is in https://github.com/linux-sunxi/u-boot-sunxi.git
> Note this is only test patch. I have not commit it  formally for uboot.

Please do so. I'd like very much to avoid ending up in a situation where
we would break the mainline kernel for the A20, without any bootloader
we can point the users to to fix the issues.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130923/16791ec5/attachment.sig>
