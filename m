From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 12 Mar 2012 16:14:37 +0100
Subject: [PATCH] stmmac: Add device-tree support
In-Reply-To: <201203121606.26926.sr@denx.de>
References: <1331561157-3820-1-git-send-email-sr@denx.de>
 <4F5E0993.9020000@gmail.com> <201203121606.26926.sr@denx.de>
Message-ID: <20120312151437.GC13869@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:06 Mon 12 Mar     , Stefan Roese wrote:
> Hi Rob,
> 
> On Monday 12 March 2012 15:34:59 Rob Herring wrote:
> > On 03/12/2012 09:05 AM, Stefan Roese wrote:
> > > This patch adds support to configure the STMMAC ethernet driver via
> > > device-tree instead of platform_data.
> > > 
> > > Currently, only the properties needed on SPEAr600 are provided. All
> > > other properties should be added once needed on other platforms.
> > > 
> > > Signed-off-by: Stefan Roese <sr@denx.de>
> > > Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> > > Cc: Viresh Kumar <viresh.kumar@st.com>
> > > ---
> > > 
> > >  Documentation/devicetree/bindings/net/stmmac.txt   |   38 +++++++++++
> > >  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   66
> > >  +++++++++++++++++++- 2 files changed, 103 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/devicetree/bindings/net/stmmac.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/stmmac.txt
> > > b/Documentation/devicetree/bindings/net/stmmac.txt new file mode 100644
> > > index 0000000..386a47f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/stmmac.txt
> > > @@ -0,0 +1,38 @@
> > > +* STMicroelectronics 10/100/1000 Ethernet driver (GMAC)
> > > +
> > > +Required properties:
> > > +- compatible: Should be "stm,gmac"
> > 
> > This is too generic. This should be 1 string per version of h/w.
> 
> Viresh, Giuseppe, can you please suggest a proper string for the SPEAr600 
> STMMAC core, including version?
IIRC this IP is the same as the sti7108

st,sti7018-gmac

as this IP has been used first on SH4

Best Regards,
J.
