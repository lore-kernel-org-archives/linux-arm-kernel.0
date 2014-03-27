From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Mar 2014 01:29:40 +0100
Subject: [PATCH 0/3] Fix stmmac-socfpga allmodconfig breakage in arm-soc
In-Reply-To: <53336B39.3080209@gmail.com>
References: <1395790482-3957-1-git-send-email-dinguyen@altera.com>
 <201403262254.41069.arnd@arndb.de> <53336B39.3080209@gmail.com>
Message-ID: <4983643.yPXNcULbxi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 March 2014 19:05:13 Dinh Nguyen wrote:
> On 03/26/2014 04:54 PM, Arnd Bergmann wrote:
> > On Wednesday 26 March 2014, dinguyen at altera.com wrote:
> >> From: Dinh Nguyen <dinguyen@altera.com>
> >>
> >> Hi,
> >>
> >> These 3 patches are based on Arnd's patch to fix the allmodconfig for the
> >> dwmac-socfpga implementation. I just broke the patch out into drivers,
> >> dts, and dts documentation.
> >>
> >> The original patch is here:
> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/241518.html
> >>
> >> Arnd mentioned that he was thinking about just removing the dwmac-socfpga
> >> and send out the new verion to the netdev tree, but I haven't seen it. So
> >> just in case this solution might work, here are the patches.
> >>
> >> These patches are based on arm-soc/for-next.
> >
> > Hi Dinh,
> >
> > Thanks for putting these patches together. The problem I see with these
> > is that we have multiple conflicts between my changes and the other
> > patches that went into the netdev tree.
> >
> > Originally, the idea was that David Miller gave his Ack to have
> > the patches merged through arm-soc, but I think that was a mistake,
> > and they should have been treated like the other patches for
> > the same driver, i.e. put the driver and binding changes into
> > netdev, and the dt changes into arm-soc.
> >
> > If I apply your patches on top of the next/drivers branch, we get
> > conflicts for a handful of files, and get Linus to resolve them.
> > I tried applying my patch on Sunday, but backed it out because
> > of this.
> >
> > My preferred solution at this point would be to revert the driver
> > addition in the arm-soc tree and have David put the new version
> > in, but I don't know if he still takes patches like that for 3.15.
> >
> 
> That's fine. Do you mind if I send out a fresh patch based on the netdev 
> tree? If there is still for 3.15, otherwise, going for 3.16 is fine.

Sounds good. I've reverted the two patches (driver addition, and
binding addition plus dts changes) in arm-soc/next/drivers now.

Please submit the updated versions to netdev, but split out the
dts changes into a patch that we can take through arm-soc.

I'll send an Ack when I see your patches.

	Arnd
