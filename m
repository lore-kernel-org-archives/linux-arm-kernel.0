From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Sun, 05 Jan 2014 16:39:14 -0800 (PST)
Subject: [PATCH 3/3] ARM: shmobile: Koelsch: Add QSPI support
In-Reply-To: <CAMuHMdVzawC2ccXCwyLSe7u0Uaa0qpLwaO+3dqQiSrmOcGdTCA@mail.gmail.com>
References: <1388763256-25851-1-git-send-email-geert@linux-m68k.org>
 <1388763256-25851-4-git-send-email-geert@linux-m68k.org>
 <52C6EAA7.7050200@cogentembedded.com>
 <CAMuHMdVzawC2ccXCwyLSe7u0Uaa0qpLwaO+3dqQiSrmOcGdTCA@mail.gmail.com>
Message-ID: <871u0mkkpg.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

> <sergei.shtylyov@cogentembedded.com> wrote:
> >> +       platform_device_register_resndata(&platform_bus, "qspi", 0,
> >
> >    As I understood, there's single QSPI controller, so why you pass 0, and
> > not -1 here?
> 
> Indeed, there's only a single QSPI instance.
> However, I choose to use "0" for consistency with Lager.
> Mach-shmobile seems to use a mix of 0 and -1.
> 
> If the maintainer prefers -1, I can change that.

In SPI driver case, spi master will use dynamic 
bus_num value if ID was -1 (in spi_register_master()).
Then, slave device can't be detected.
So, ID = 0 is reasonable even though single QSPI.
