From: ijc@hellion.org.uk (Ian Campbell)
Date: Mon, 16 Dec 2013 12:49:12 +0000
Subject: [linux-sunxi] Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
In-Reply-To: <CAOMqctTdasLxJki0xu4aq_sEgujDt3Jdu=BXy9WvQeji282_Rg@mail.gmail.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <1387058295-20641-2-git-send-email-hdegoede@redhat.com>
 <20131215134415.GE3651@lukather>
 <CAOMqctRspBPmNsyXye_gpfwGoZ=gMcCzEjM+hD3g+ZfQix7G6Q@mail.gmail.com>
 <20131216100551.GD3037@lukather>
 <CAOMqctTdasLxJki0xu4aq_sEgujDt3Jdu=BXy9WvQeji282_Rg@mail.gmail.com>
Message-ID: <1387198152.10247.19.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-12-16 at 12:59 +0100, Michal Suchanek wrote:
> On 16 December 2013 11:05, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Sun, Dec 15, 2013 at 11:01:17PM +0100, Michal Suchanek wrote:
> >> On 15 December 2013 14:44, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> >> --- a/drivers/mmc/host/Kconfig
> >> >> +++ b/drivers/mmc/host/Kconfig
> >> >> @@ -665,3 +665,11 @@ config MMC_REALTEK_PCI
> >> >>       help
> >> >>         Say Y here to include driver code to support SD/MMC card interface
> >> >>         of Realtek PCI-E card reader
> >> >> +
> >> >> +config MMC_SUNXI
> >> >> +     tristate "Allwinner sunxi SD/MMC Host Controller support"
> >> >> +     depends on ARCH_SUNXI
> >> >> +     default y
> >> >
> >> > I'm not that fond of these "default y" patterns. It forces the driver
> >> > down to every user of the multiplatform kernels. I'd suggest removing
> >> > the default and adding the driver to the defconfigs we have.
> >>
> >> And why would you build support for sunxi without building support for
> >> sunxi mmc?
> >
> > Because you can?
> 
> But does that need to be the default? And is that sane default?
> 
> >
> > And where am I actually suggesting to do so?
> 
> Just a few lines above. You suggest it should not be built by default.

I'm pretty sure this isn't specific to sunxi, in the past Linus has
complained about the inappropriate use of "default y". Apparently it
should only be used rarely.

Note that default in the Kconfig is different to the defconfig file.

Ian.
