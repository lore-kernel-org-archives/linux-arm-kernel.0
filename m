From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 6 Mar 2014 13:44:11 +0100
Subject: [RESEND Patch 2/2] DT: bindings: add missing Marvell Kirkwood
 SoC documentation
In-Reply-To: <20140306122300.GW1872@titan.lakedaemon.net>
References: <1394054474-4310-1-git-send-email-andrew@lunn.ch>
 <1394054474-4310-3-git-send-email-andrew@lunn.ch>
 <20140306122300.GW1872@titan.lakedaemon.net>
Message-ID: <20140306124411.GH4780@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 07:23:00AM -0500, Jason Cooper wrote:
> On Wed, Mar 05, 2014 at 10:21:14PM +0100, Andrew Lunn wrote:
> > Marvell Dove SoC binding was not documented, yet. Add the
> 
> s/Dove/Kirkwood/

Doh. I cut/paste from the Dove file.
 
> > documentation including the supported SoCs and boards.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  .../devicetree/bindings/arm/marvell,kirkwood.txt   | 97 ++++++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
> > new file mode 100644
> > index 000000000000..925ecbf6e7b7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/marvell,kirkwood.txt
> > @@ -0,0 +1,97 @@
> > +Marvell Kirkwood SoC Family Device Tree Bindings
> > +------------------------------------------------
> > +
> > +Boards with a SoC of the Marvell Kirkwook family, eg 88f6281
> 
> s/Kirkwook/Kirkwood/

I really need to add Kirkwood to my dictionary.
 
> > +
> > +* Required root node properties:
> > +compatible: must contain "marvell,kirkwood"
> > +
> > +In addition, the above compatible shall be extended with the specific
> > +SoC. Currently known SoC compatibles are:
> > +
> > +"marvell,kirkwood-88f6192"
> > +"marvell,kirkwood-88f6281"
> > +"marvell,kirkwood-88f6282"
> > +"marvell,kirkwood-88f6283"
> > +"marvell,kirkwood-88f6702"
> > +"marvell,kirkwood-98DX4122"
> > +
> > +And in addition, the compatible shall be extended with the specific
> > +board. Currently known boards are:
> 
> This is more a question for Grant and the other DT maintainers: Do we
> really need this?

checkpatch.pl says yes, we need this. It gives warnings for every
unknown compatible string. I would say it is up to Grant and the other
DT maintainers to decide if checkpatch.pl is wrong.

       Andrew
