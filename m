From: horms@verge.net.au (Simon Horman)
Date: Mon, 6 Jan 2014 11:24:30 +0900
Subject: [PATCH 3/3] ARM: shmobile: Koelsch: Add QSPI support
In-Reply-To: <871u0mkkpg.wl%kuninori.morimoto.gx@gmail.com>
References: <1388763256-25851-1-git-send-email-geert@linux-m68k.org>
 <1388763256-25851-4-git-send-email-geert@linux-m68k.org>
 <52C6EAA7.7050200@cogentembedded.com>
 <CAMuHMdVzawC2ccXCwyLSe7u0Uaa0qpLwaO+3dqQiSrmOcGdTCA@mail.gmail.com>
 <871u0mkkpg.wl%kuninori.morimoto.gx@gmail.com>
Message-ID: <20140106022426.GD11231@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 05, 2014 at 04:39:14PM -0800, Kuninori Morimoto wrote:
> Hi
> 
> > <sergei.shtylyov@cogentembedded.com> wrote:
> > >> +       platform_device_register_resndata(&platform_bus, "qspi", 0,
> > >
> > >    As I understood, there's single QSPI controller, so why you pass 0, and
> > > not -1 here?
> > 
> > Indeed, there's only a single QSPI instance.
> > However, I choose to use "0" for consistency with Lager.
> > Mach-shmobile seems to use a mix of 0 and -1.
> > 
> > If the maintainer prefers -1, I can change that.
> 
> In SPI driver case, spi master will use dynamic 
> bus_num value if ID was -1 (in spi_register_master()).
> Then, slave device can't be detected.
> So, ID = 0 is reasonable even though single QSPI.

When it makes sense I prefer -1, however, in this case it
seems that 0 is a better choice.
