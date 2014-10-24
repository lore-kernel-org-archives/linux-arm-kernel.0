From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Oct 2014 12:55:33 +0200
Subject: [PATCH RFC 1/2] drivers: pci: fix window allocation order wrt
 bus_range filtering
In-Reply-To: <20141024090409.GR25302@e106497-lin.cambridge.arm.com>
References: <1414077787-20633-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20141023222707.GB11115@google.com>
 <20141024090409.GR25302@e106497-lin.cambridge.arm.com>
Message-ID: <3428924.HDrlijkpFb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 24 October 2014 10:04:09 Liviu Dudau wrote:
> On Thu, Oct 23, 2014 at 11:27:07PM +0100, Bjorn Helgaas wrote:
> > On Thu, Oct 23, 2014 at 04:23:06PM +0100, Lorenzo Pieralisi wrote:
> > > The number of windows allocated for the host bridge depends on the
> > > bus resource. Instead of first allocating the windows and then
> > > limit the bus resource, this patch reshuffles the code so that if any
> > > limitation is applied to the bus resource it is taken into account in
> > > the windows allocation.
> > > 
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > 
> > Hi Lorenzo,
> > 
> > I can *read* your patches just fine, but when I save them using mutt to
> > apply them, they look like this:
> > 
> >   --- a/drivers/pci/host/pci-host-generic.c
> >   +++ b/drivers/pci/host/pci-host-generic.c
> >   @@ -276,17 +276,17 @@ static int gen_pci_parse_map_cfg_windows(struct gen_p=
> >   ci *pci)
> >    =09=09return err;
> >     =09}
> >     =20
> >     -=09pci->cfg.win =3D devm_kcalloc(dev,
> >     resource_size(&pci->cfg.bus_range),
> > 
> > I can work around this by downloading them another way, but it is a
> > bit of a hassle.  I *think* this is because your email has
> > 
> >   Content-Type: text/plain; charset=WINDOWS-1252
> > 
> > which apparently confuses mutt.  Any idea why this is?  Anybody know how I
> > can fix mutt to deal with this?
> 
> I use decode-save (<Esc>s on my setup) to save the attachment(s). Sometimes
> it works well enough, although more often than not tabs get lost.

I just tried applying the patches locally here. The patch looks the same way
for me, but 'git am' actually works while 'patch' does not.

Maybe Bjorn is using an outdated git version. While the patch clearly shouldn't
have been sent that way, I think git has been changed now to work around that.
I'm using a git-2.1 snapshot here.

	Arnd
