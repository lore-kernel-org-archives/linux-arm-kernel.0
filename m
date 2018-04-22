From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 22 Apr 2018 19:23:42 +0200
Subject: [PATCH] ARM: dts: imx6qdl-cubox-i: Move card-detect GPIO to 1.5
 SOM devices only
In-Reply-To: <CABdtJHuE05ea1EPSR916vSEz6gtCirLF77c_PW2N2ofGnzN-bw@mail.gmail.com>
References: <20180422142151.17910-1-contact@paulk.fr>
 <20180422143911.GB16141@n2100.armlinux.org.uk>
 <CABdtJHuE05ea1EPSR916vSEz6gtCirLF77c_PW2N2ofGnzN-bw@mail.gmail.com>
Message-ID: <12bc46186bb643203601165b7b0136d96e0613c9.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le dimanche 22 avril 2018 ? 15:02 +0000, Jon Nettleton a ?crit :
> On Sun, Apr 22, 2018 at 4:39 PM Russell King - ARM Linux <linux@armlin
> ux.org.uk> wrote:
> > On Sun, Apr 22, 2018 at 04:21:51PM +0200, Paul Kocialkowski wrote:
> > > The Solid-Run CuBox-i lower board used in the first generation of
> > > CuBox-i devices feature a hinged micro SD card slot, that does not
> > have
> > > card-detect capability. Since the card-detect GPIO was specified
> > in the
> > > common cubox-i dtsi, it is moved to each device using the 1.5 SOM
> > and is
> > > thus removed from the imx6q-cubox-i dts.
> > 
> > This seems incorrect.
> > 
> > The 1.5 SOM is a relatively recent thing, and I have one of the
> > first
> > Cubox-i's that were produced which is not hinged, and does not have
> > a
> > 1.5 SOM.  There is _no_ correlation between the 1.5 SOM and the SD
> > card slot.
> > 
> > Talking to folk at SolidRun, we're all confused about your
> > assertions.
> > 
> > We're also confused about "hinged micro SD card slot" - Cubox-i's
> > come with either a push-push slot or a static (push-in, pull-out)
> > slot.
> > (Prototypes were the latter.)
> > 
> > Maybe someone's modified yours?
> > 
> Regardless of the physical mechanics of the device, the CD-GPIO is a
> mechanism of the carrier and not the SOM. I have one of the few Cubox-
> i's that have been physically modified to work with the rev 1.5 som
> and have no issues (the heat spreader needs additional cutouts).

There was some confusion about the relationship with the 1.5 SOM. It is
now clear that the issue is not linked to it at all.

> Now if you are still using the old 2013 u-boot then there is possibly
> confusion between the eMMC and SDHC slots which can cause
> strangeness.  Please use the 2018.01 branch on our github and that
> will handle this properly.

I'm using U-Boot 2018.03, so I think I'm safe on that side.

Cheers,

-- 
Paul Kocialkowski,

developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180422/e96ecc56/attachment.sig>
