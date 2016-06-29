From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jun 2016 22:07:21 +0200
Subject: [linux-sunxi] Re: [PATCH 1/4] brcmfmac: Add brcm,
 nvram_file_name dt property
In-Reply-To: <1467230078.2598.2.camel@plaes.org>
References: <1467209074-15634-1-git-send-email-hdegoede@redhat.com>
 <6402170.5s0abZDqlD@wuerfel> <1467230078.2598.2.camel@plaes.org>
Message-ID: <6119590.gPKNGsSJ3t@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 29, 2016 10:54:38 PM CEST Priit Laes wrote:
> On Wed, 2016-06-29 at 21:33 +0200, Arnd Bergmann wrote:

> > What is the size of this nvram file? As it's board specific, I wonder
> > if we can simply include it inside of the DT verbatim. I remember
> > doing that (in the pre-dtb days, on real open firmware) for the
> > "spidernet"
> > ethernet driver.
> 
> It contains a bit too much info:
> 
> This is what CubieTruck requires:
> 
> http://dl.cubieboard.org/public/Cubieboard/benn/firmware/ap6210/nvram_a
> p6210.txt

Ah, I had not realized that this is a text based interface rather than
a small binary blob with fixed offsets.

On the other hand, each line in there could be translated easily into
a separate DT property, and some of them (manfid/prodid, macaddr, ...)
look like they directly correspond to properties we already have.

As Arend said there is also the option of having a chip specific
nvram file (brcmfmac43362-sdio.txt) as a fallback when there is no
more specific module. How many of the lines in your example would
actually differ between the two? Does this affect all of them, or
just a subset that could be turned into a smaller set of DT
properties?

	Arnd
