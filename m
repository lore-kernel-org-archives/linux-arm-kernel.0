From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 22 Apr 2018 19:22:14 +0200
Subject: [PATCH] ARM: dts: imx6qdl-cubox-i: Move card-detect GPIO to 1.5
 SOM devices only
In-Reply-To: <20180422143911.GB16141@n2100.armlinux.org.uk>
References: <20180422142151.17910-1-contact@paulk.fr>
 <20180422143911.GB16141@n2100.armlinux.org.uk>
Message-ID: <8012696a7bf0132dd2361a896bf0abfbe8a3084e.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le dimanche 22 avril 2018 ? 15:39 +0100, Russell King - ARM Linux a
?crit :
> On Sun, Apr 22, 2018 at 04:21:51PM +0200, Paul Kocialkowski wrote:
> > The Solid-Run CuBox-i lower board used in the first generation of
> > CuBox-i devices feature a hinged micro SD card slot, that does not
> > have
> > card-detect capability. Since the card-detect GPIO was specified in
> > the
> > common cubox-i dtsi, it is moved to each device using the 1.5 SOM
> > and is
> > thus removed from the imx6q-cubox-i dts.
> 
> This seems incorrect.
> 
> The 1.5 SOM is a relatively recent thing, and I have one of the first
> Cubox-i's that were produced which is not hinged, and does not have a
> 1.5 SOM.  There is _no_ correlation between the 1.5 SOM and the SD
> card slot.
> 
> Talking to folk at SolidRun, we're all confused about your assertions.

It appears that I was also confused about the different models in the
CuBox-i line. I had assumed that the models had been updated to a new
revision (carrying that 1.5 SOM) since the time I bought mine (which was
thus some sort of first generation). With this scenario in mind, it made
sense to me that a CD GPIO required only for the second generation would
have been applied by mistake to all the cubox-i devices by having it in
the common dtsi.

I checked on the leaflet inside the box and models did not change, only
the 4x4 model was added in the meantime. 

> We're also confused about "hinged micro SD card slot" - Cubox-i's
> come with either a push-push slot or a static (push-in, pull-out)
> slot.
> (Prototypes were the latter.)

The one I have definitely does not have a spring-loaded mechanism, so I
would call it a push/pull static slot. I mentioned a hinged slot because
that's the term used to describe the layout in the CuBox-i-Lower
schematics, SD/MMC Connector part: "U3 is an internal hinged micro SD".
Looking at pictures of what hinged slots look like, that's definitely
not what I have here.

Are all CuBox-i units that have ever been sold supposed to have a
connector with a CD line? I find it hard to believe that it's broken
specifically on mine.

If that's really needed, I could open up the device, check whether the
R8 pull is in place and check the voltage there.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180422/16834a0a/attachment.sig>
