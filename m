From: zhang.lyra@gmail.com (Lyra Zhang)
Date: Wed, 26 Nov 2014 11:08:01 +0800
Subject: [PATCH v3 4/5] arm64: Add support for Spreadtrum's Sharkl64
 Platform in Kconfig and defconfig
In-Reply-To: <3490516.nCDXzA8J8x@wuerfel>
References: <1416917818-10506-5-git-send-email-chunyan.zhang@spreadtrum.com>
 <3490516.nCDXzA8J8x@wuerfel>
Message-ID: <CAAfSe-uDk-ih2tqU9a3UEzr=BZgU_=+XJm9=zWbE3J4HMOuiog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-25 20:57 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>
> On Tuesday 25 November 2014 20:16:57 Chunyan Zhang wrote:
> >
> > +menuconfig ARCH_SPRD
> > +       bool "Spreadtrum SoC platform"
> > +       depends on ARM64
> > +       help
> > +         Support for Spreadtrum ARM based SoCs
> > +
> > +if ARCH_SPRD
> > +
> > +config ARCH_SHARKL64
> > +       bool "Sharkl64 SoC Platform"
> > +       help
> > +         Sharkl64 is a Spreadtrum's SoC Platform which is based
> > +         on ARM 64-bit processor core including
> > +           sc9836
> > +
> > +endif #ARCH_SPRD
> > +
>
> I don't think we need multiple levels here, it should be enough to
> have either ARCH_SPRD or ARCH_SHARKL64, because all device drivers
> are going to be optional anyway. Typically a Kconfig symbol covers
> all SoCs that are related, so if you Spreadtrum are doing both
> phone and server chips and these are designed independently, you
> would have two symbols, but if you only expect to see phone chips
> here that are all derived from the same product line, using ARCH_SPRD
> to refer to all of them should be enough.
>
>         Arnd


For now, we have only one platform(Sharkl64) based on ARM64 been
submitted, but we're intending to add support for more our platforms
based on ARM64 or ARM32 in the future. There are many common devices
on these platforms, such as serial. Our idea would be that if we had a
'menuconfig ARCH_SPRD' in the Kconfig, these common devices only need
to depend on ARCH_SPRD in the respective Kconfig, otherwise they may
depend on a few Kconfig symbols for every platforms which include
these common devices.

So, do you think whether we should define a menuconfig(ARCH_SPRD) in
the Kconfig for this case ?

Thanks!

Best regards,
Chunyan
