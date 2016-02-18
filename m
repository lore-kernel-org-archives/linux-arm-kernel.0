From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Feb 2016 15:41:45 +0100
Subject: [PATCH] PCI: mvebu: Restrict build to 32-bit ARM
In-Reply-To: <87egcaqe89.fsf@free-electrons.com>
References: <1455802330-17565-1-git-send-email-thierry.reding@gmail.com>
 <5051836.EUN3ennYNm@wuerfel> <87egcaqe89.fsf@free-electrons.com>
Message-ID: <2551766.4Kx1a2F3t1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 February 2016 15:34:30 Gregory CLEMENT wrote:
>  On jeu., f?vr. 18 2016, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > On Thursday 18 February 2016 14:32:10 Thierry Reding wrote:
> >> From: Thierry Reding <treding@nvidia.com>
> >> 
> >> This driver uses PCI glue that is only available on 32-bit ARM. This
> >> used to work fine as long as ARCH_MVEBU and ARCH_DOVE were exclusively
> >> 32-bit, but that's changed now, with ARCH_MVEBU also being available
> >> on 64-bit ARM.
> >> 
> >> Signed-off-by: Thierry Reding <treding@nvidia.com>
> >
> > Looks fine as a temporary workaround, but I think what we really want to
> > do here is to remove the dependency, as the new ARM64 platforms are going
> > to need this driver anyway.
> 
> Actually the mvebu ARM64 platform we know about (Armada 3700, 7K and
> 8K), won't use the same controller. A7K/A8K will use a synopsis IP and
> Armada 3700 a new Marvell IP.
> 
> So for me depending on ARM32 is enough.

Ah, that makes things much easier indeed.

Does this mean no more MBUS on the 64-bit platforms too?

	Arnd
