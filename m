From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Jul 2013 11:49:21 -0700
Subject: [PATCHv5 00/11] MSI support for Marvell EBU PCIe driver
In-Reply-To: <20130716153911.423cc408@skate>
References: <1373889167-27878-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <51E4167B.4000208@wwwdotorg.org> <20130716104347.045a612a@skate>
 <20130716131547.GC12062@titan.lakedaemon.net>
 <20130716153911.423cc408@skate>
Message-ID: <20130725184920.GC18584@dhcp-172-17-186-34.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 03:39:11PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Tue, 16 Jul 2013 09:15:47 -0400, Jason Cooper wrote:
> 
> > > A quick diagram of the dependencies, best viewed with a fixed-size font
> > > mailer.
> > > 
> > > kernel/irq/irqdomain    drivers/pci        arch/arm/kernel
> > >      patch 1           patch 2, 3, 4           patch 8
> > >         ||                  ||                   ||
> > >         ||                  \/                   \/
> > >         ||               drivers/of   ==> drivers/pci/host
> > >         ||                patch 5           patch 10
> > >         ||                  ||
> > >         \\__________________//
> > >                   ||
> > >                   \/
> > >             drivers/irqchip
> > >               patch 6, 7
> > 
> > Well, that got more complicated.  :(  No cookie for you.
> 
> Yeah, sorry about this. I'm not sure how to handle that differently.
> 
> > > Patches 9 and 11 are DT patches, so they are not mentioned in this
> > > diagram.
> > > 
> > > Normally tegra would require 1, 2, 3, 4, 5 and 8, so ideally, with
> > > the respective maintainers ACKs, Jason Cooper could take them in a
> > > specific topic stable branch that would not be rebased, on top of which
> > > both the Marvell work and Tegra work could be done.
> > 
> > After my recent discussions with tglx, here's my proposal:
> > 
> > - rmk creates a dedicated topic branch with patch 8
> > 
> > - Bjorn creates a dedicated topic branch based on rmk's with 2, 3, 4, 5,
> >   and 10
> > 
> > - tglx creates a dedicated topic branch based on Bjorn's with 1, 6, 7
> 
> I am wondering if this merge strategy isn't too complicated to work
> nicely. Would it be easier if one person took all of those patches in a
> stable topic branch, with the ACKs from the proper maintainers?
> 
> But anyway, as long as things get merged, I don't really mind what
> merge strategy is used, so I'll trust on what will be the best option
> on this.
> 
> Thanks a lot for taking care of this!

Hi Thomas, Jason,

I've talked this over with Stephen and he'd be willing to create the
stable branch with patches 2, 4 and 8. That could serve as the basis
for both Tegra and Marvell.

Given that there are no cross-dependencies for any of the other patches
(that I'm aware of) it would probably be easier to take them through the
Marvell tree if Bjorn and Thomas (tglx) agree to Ack the patches.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130725/a1eb8ff1/attachment.sig>
