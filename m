From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 4 Jan 2016 13:25:15 -0800
Subject: [PATCH v2] ARM: shmobile: alt: Add QSPI device to DT
In-Reply-To: <CAMuHMdWbFHLKgkn9ShJkyyimpwJAbbL5TjqEp1E9GBteVKQmKg@mail.gmail.com>
References: <1451903819-19218-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdVFC1TEeTT5Gas8jz0Tvn2HB3EHBo7gp6pthsnOo6x5UQ@mail.gmail.com>
 <20160104203136.GB12748@verge.net.au>
 <CAMuHMdWbFHLKgkn9ShJkyyimpwJAbbL5TjqEp1E9GBteVKQmKg@mail.gmail.com>
Message-ID: <20160104212515.GA39910@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 09:42:59PM +0100, Geert Uytterhoeven wrote:
> On Mon, Jan 4, 2016 at 9:31 PM, Simon Horman <horms@verge.net.au> wrote:
> > Should we document "spansion,s25fl512s" for the benefit of checkpatch.pl?
> 
> Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt used to point to
> drivers/mtd/devices/m25p80.c for the list of supported chips.
> 
> That seems to have been changed lately. Now jedec,spi-nor.txt includes the
> list, but lacks the manufacturers' names, so checkpatch.pl is still not happpy.
> 
> Brian: Shouldn't the manufacturers's names be added?

We've had some of this discussion recently:

http://lkml.kernel.org/g/20151118194340.GF140057 at google.com

I don't think we can reasonably determine a good list of complete
strings, due to historical failures (IMO) in the SPI subsystem. We could
add a separate list of possible manufacturers, so people can do the MxN
pairing themselves.

checkpatch.pl has enough false positives that its author doesn't care to
fix that I'm not personally worried about yet another class of them. But
if you have good reasons and good patches for the documentation, I'm all
ears.

Regards,
Brian
