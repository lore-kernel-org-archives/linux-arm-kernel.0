From: jacopo@jmondi.org (jacopo mondi)
Date: Wed, 13 Jun 2018 10:54:55 +0200
Subject: [PATCH v4 6/6] dt-bindings: media: rcar-vin: Clarify optional
 props
In-Reply-To: <20180612154553.kgqnqkwv3y6srivg@kekkonen.localdomain>
References: <1528813566-17927-1-git-send-email-jacopo+renesas@jmondi.org>
 <1528813566-17927-7-git-send-email-jacopo+renesas@jmondi.org>
 <20180612154553.kgqnqkwv3y6srivg@kekkonen.localdomain>
Message-ID: <20180613085455.GC4952@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sakari,

On Tue, Jun 12, 2018 at 06:45:53PM +0300, Sakari Ailus wrote:
> Hi Jacopo,
>
> On Tue, Jun 12, 2018 at 04:26:06PM +0200, Jacopo Mondi wrote:
> > Add a note to the R-Car VIN interface bindings to clarify that all
> > properties listed as generic properties in video-interfaces.txt can
> > be included in port at 0 endpoint, but if not explicitly listed in the
> > interface bindings documentation, they do not modify it behaviour.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> >  Documentation/devicetree/bindings/media/rcar_vin.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
> > index 8130849..03544c7 100644
> > --- a/Documentation/devicetree/bindings/media/rcar_vin.txt
> > +++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
> > @@ -55,6 +55,12 @@ from local SoC CSI-2 receivers (port1) depending on SoC.
> >        instances that are connected to external pins should have port 0.
> >
> >        - Optional properties for endpoint nodes of port at 0:
> > +
> > +        All properties described in [1] and which apply to the selected
> > +        media bus type could be optionally listed here to better describe
> > +        the current hardware configuration, but only the following ones do
> > +        actually modify the VIN interface behaviour:
> > +
>
> I don't think this should be needed. You should only have properties that
> describe the hardware configuration in a given system.
>

There has been quite some debate on this, and please bear with me
here for re-proposing it: I started by removing properties in some DT
files for older Renesas board which listed endpoint properties not
documented in the VIN's bindings and not parsed by the VIN driver [1]
Niklas (but Simon and Geert seems to agree here) opposed to that
patch, as those properties where described in 'video-interfaces.txt' and
even if not parsed by the current driver implementation, they actually
describe hardware. I rebated that only properties listed in the device
bindings documentation should actually be used, and having properties
not parsed by the driver confuses users, which may expect changing
them modifies the interface configuration, which does not happens at
the moment.

This came out as a middle ground from a discussion with Niklas. As
stated in the cover letter if this patch makes someone uncomfortable, feel
free to drop it not to hold back the rest of the series which has been
well received instead.

Thanks
   j

[1] https://www.spinics.net/lists/arm-kernel/msg656302.html

> >          - hsync-active: see [1] for description. Default is active high.
> >          - vsync-active: see [1] for description. Default is active high.
> >          - data-enable-active: polarity of CLKENB signal, see [1] for
> > --
> > 2.7.4
> >
>
> --
> Sakari Ailus
> sakari.ailus at linux.intel.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180613/e8557938/attachment.sig>
