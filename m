From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Nov 2018 16:58:24 +0100
Subject: [PATCH v6 5/9] dt-bindings: ARM: document marvell,
 ecc-enable binding
In-Reply-To: <20181109114818.GB30658@n2100.armlinux.org.uk>
References: <20181109070349.20464-1-chris.packham@alliedtelesis.co.nz>
 <20181109070349.20464-6-chris.packham@alliedtelesis.co.nz>
 <CAK8P3a3PNvBhyQw0bfGxKmxj+KeJB2_TXtDx2R1BpjTCYNqVkA@mail.gmail.com>
 <20181109114818.GB30658@n2100.armlinux.org.uk>
Message-ID: <CAK8P3a26XmBpG3VzwUgSdd_Xo_S2ezSvA9mjKckRFr9p38j-dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 9, 2018 at 12:48 PM Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> On Fri, Nov 09, 2018 at 12:40:06PM +0100, Arnd Bergmann wrote:
> > On Fri, Nov 9, 2018 at 8:04 AM Chris Packham
> > <chris.packham@alliedtelesis.co.nz> wrote:
> > >
> > > Add documentation for the marvell,ecc-enable and marvell,ecc-disable
> > > properties which can be used to enable/disable ECC on the Marvell aurora
> > > cache.
> > >
> > > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > > ---
> >
> > Why do you need both enable and disable? Wouldn't one of them be enough here?
>
> It isn't an "on when ecc-enable is present, off when not" because the
> current behaviour is to preserve these bits in the control register.
>
> If we were to implement it as "if no ecc-enable property, turn off
> ECC" then that would drastically change the behaviour - systems which
> were configured for ECC suddenly lose ECC support.
>
> Since we don't know which have it and which don't, we can't implement
> the option like that.

What I meant was why we need support force-disabling it. I understand
that we need to allow leaving it at the boot-time default as well as
force-enabling it.

       Arnd
