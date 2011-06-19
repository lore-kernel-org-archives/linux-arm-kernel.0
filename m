From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 19 Jun 2011 15:46:59 +0800
Subject: [PATCH 2/3] net/fec: add device tree support
In-Reply-To: <20110618162220.GI8195@ponder.secretlab.ca>
References: <1308410354-21387-1-git-send-email-shawn.guo@linaro.org>
	<1308410354-21387-3-git-send-email-shawn.guo@linaro.org>
	<20110618162220.GI8195@ponder.secretlab.ca>
Message-ID: <20110619074658.GD23171@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 18, 2011 at 10:22:20AM -0600, Grant Likely wrote:
> On Sat, Jun 18, 2011 at 11:19:13PM +0800, Shawn Guo wrote:
> > It adds device tree data parsing support for fec driver.
> > 
> > Signed-off-by: Jason Liu <jason.hui@linaro.org>
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: David S. Miller <davem@davemloft.net>
> > ---
> >  Documentation/devicetree/bindings/net/fsl-fec.txt |   14 ++++++++++
> >  drivers/net/fec.c                                 |   28 +++++++++++++++++++++
> >  2 files changed, 42 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/fsl-fec.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/fsl-fec.txt b/Documentation/devicetree/bindings/net/fsl-fec.txt
> > new file mode 100644
> > index 0000000..705111d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/fsl-fec.txt
> > @@ -0,0 +1,14 @@
> > +* Freescale Fast Ethernet Controller (FEC)
> > +
> > +Required properties:
> > +- compatible : should be "fsl,<soc>-fec", "fsl,fec"
> 
> Ditto to comment on last patch.  "fsl,fec" is to generic.
> "fsl,imx51-soc" should be the generic value.
> 

Ditto to the feedback on the last comment.  "fsl,imx51-fec" is not
a good one to be the compatibility string for imx27 and imx35 fec.

> Otherwise looks okay to me, and I don't see any problem with queueing
> it up for v3.1 with that change since it doesn't depend on any other
> patches.
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 

-- 
Regards,
Shawn
