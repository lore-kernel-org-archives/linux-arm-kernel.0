From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Mon, 29 Oct 2018 14:07:57 +0100
Subject: [PATCH v5 04/11] dt-bindings: iio: adc: add AXP803 ADC bindings
In-Reply-To: <20181028154011.04efdecf@archlinux>
References: <20181023185330.10472-1-oskari@lemmela.net>
 <20181023185330.10472-5-oskari@lemmela.net>
 <20181024135633.GA342@bogus> <20181028154011.04efdecf@archlinux>
Message-ID: <20181029130757.m5okrfvusjl5fu5m@qschulz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On Sun, Oct 28, 2018 at 03:40:11PM +0000, Jonathan Cameron wrote:
> On Wed, 24 Oct 2018 08:56:33 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Tue, 23 Oct 2018 21:53:23 +0300, Oskari Lemmela wrote:
> > > The AXP803 ADC is compatible with AXP813 ADC, but add
> > > specific compatible for it.
> > > 
> > > Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> > > ---
> > >  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >   
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> This doesn't seem to have any dependencies with the other patches
> so applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to ignore.  However I am a little curious to know
> why we would add the ID and then not use it (that I can see)?
> 

Sometimes with Allwinner (and X-Powers), two IPs seem identical until we
discover something that is slightly different. When this happens, we
have to add a compatible to differentiate both. However, we would also
need to change the Device Tree to change the compatible. We would need
to handle the driver behaviour for both Device Trees.

So better anticipate a possible difference so that we don't have to do
some hacks in the driver to handle the device correctly.

As always, Chen-Yu or Maxime may know better so I'm just stating what I
seem to recall.

Quentin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/12ea90f9/attachment-0001.sig>
