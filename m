From: horms@verge.net.au (Simon Horman)
Date: Tue, 27 Feb 2018 09:35:09 +0100
Subject: [PATCH 0/8] R-Car M3-N: Enable EtherAVB device node
In-Reply-To: <20180227082838.GA23738@w540>
References: <1519667836-31330-1-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdXwxhT7MP5xs3HLP3oFX+V9rhCM5jQycXUiCyBOKOUg1Q@mail.gmail.com>
 <20180227082838.GA23738@w540>
Message-ID: <20180227083509.6qrp2g3wstq7j24x@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 09:28:38AM +0100, jacopo mondi wrote:
> Hi Geert,
> 
> On Mon, Feb 26, 2018 at 07:28:47PM +0100, Geert Uytterhoeven wrote:
> > Hi Jacopo,
> >
> > On Mon, Feb 26, 2018 at 6:57 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > >   as discussed with you Sergei and Geert, in order to enable EtherAVB for
> > > R8A77965 we first wanted to make the phy-mode "rgmii-txid" a board specific
> > > property for all other SoCs.
> >
> > Thanks for your series!
> >
> > > This series adds  the phy-mode property to salvator-common.dtsi and reset the
> > > one for R8A77965/R8A7796/R8A77995 to "rgmii".
> >
> > I forgot that r8a7795.dtsi and r8a7796.dtsi are used for the ULCB boards, too.
> > So to avoid regressions, you need to make a similar change to ulcb.dtsi like you
> > made for salvator-common.dtsi.
> >
> > In addition, r8a77995.dtsi is only used for the Draak board.
> > So you have to update r8a7795-draak.dtsi first, too.
> 
> Of course! I forgot about ULCB (and had a patch for Draak I lost while
> rebasing :/ )
> >
> > > Then, in order to enable EtherAVB for R-Car M3-N, iommu nodes had to be added
> > > as they are referenced by the "avb" device node (CC the iommu list for the
> > > series for that reason).
> >
> > I don't think we need the iommu properties and nodes at this early stage.
> > Ethernet works fine without them. Simon, do you agree?
> 
> I'll wait for Simon reply and then resend, possibly without iommu and
> ULCB and Draak patches!

I don't feel strongly about this but I don't think iommu is a strict
dependency of enabling Ethernet and I think its good not to include extra
dependencies - if it was me I'd try to get Ethernet accepted then follow-up
on iommu.
