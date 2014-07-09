From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 Jul 2014 10:44:44 +0200
Subject: [PATCH] ARM: shmobile: Enable R-Car Gen 2 PCIe in
 shmobile_defconfig
In-Reply-To: <20140708081542.GA23642@verge.net.au>
References: <1404739432-1408-1-git-send-email-horms+renesas@verge.net.au>
 <53BAA68D.609@cogentembedded.com>
 <66f679dbac764c329125a8ea50cd9ebd@HKXPR06MB168.apcprd06.prod.outlook.com>
 <20140708081542.GA23642@verge.net.au>
Message-ID: <20140709084443.GI5656@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 08, 2014 at 10:15:44AM +0200, Simon Horman wrote:
> On Mon, Jul 07, 2014 at 01:59:12PM +0000, Phil Edworthy wrote:
> > Hi Sergei
> > 
> > On 07 July 2014 14:54, Sergei wrote:
> > > On 07/07/2014 05:23 PM, Simon Horman wrote:
> > > 
> > > > The R-Car Gen 2 PCIe driver provides PCIe host support for
> > > > Renesas R-Car Gen2 platforms. To increase hardware support enable
> > > > the driver in the shmobile_defconfig multiplatform configuration.
> > > 
> > > > Cc: Phil Edworthy <phil.edworthy@renesas.com>
> > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > ---
> > > >   arch/arm/configs/shmobile_defconfig | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > 
> > > > diff --git a/arch/arm/configs/shmobile_defconfig
> > > b/arch/arm/configs/shmobile_defconfig
> > > > index 5f05e98..6bc85a5 100644
> > > > --- a/arch/arm/configs/shmobile_defconfig
> > > > +++ b/arch/arm/configs/shmobile_defconfig
> > > > @@ -24,6 +24,7 @@ CONFIG_PL310_ERRATA_588369=y
> > > >   CONFIG_ARM_ERRATA_754322=y
> > > >   CONFIG_PCI=y
> > > >   CONFIG_PCI_RCAR_GEN2=y
> > > > +CONFIG_PCI_RCAR_GEN2_PCIE=y
> > > 
> > >     Hmm, I'm not sure why the option has GEN2 -- the driver claims support for
> > > R8A7779 as well as R8A779x. Probably the option should be renamed.
> > Technically, you are correct. However, whilst the driver does support R8A7779, that device only supports 32-bit
> > accesses over the PCIe bus so it's only useful for custom cards, not off-the-shelf PCIe cards.
> 
> It seems to me that dropping GEN2 from the config option may be a good idea.
> But I believe that conversation is orthogonal to enabling the driver
> in the defconfig. At this stage I plan to apply this patch.

I have queued up this change.
