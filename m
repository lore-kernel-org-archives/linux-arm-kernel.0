From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Mon, 7 Jul 2014 13:59:12 +0000
Subject: [PATCH] ARM: shmobile: Enable R-Car Gen 2 PCIe in
 shmobile_defconfig
In-Reply-To: <53BAA68D.609@cogentembedded.com>
References: <1404739432-1408-1-git-send-email-horms+renesas@verge.net.au>
 <53BAA68D.609@cogentembedded.com>
Message-ID: <66f679dbac764c329125a8ea50cd9ebd@HKXPR06MB168.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei

On 07 July 2014 14:54, Sergei wrote:
> On 07/07/2014 05:23 PM, Simon Horman wrote:
> 
> > The R-Car Gen 2 PCIe driver provides PCIe host support for
> > Renesas R-Car Gen2 platforms. To increase hardware support enable
> > the driver in the shmobile_defconfig multiplatform configuration.
> 
> > Cc: Phil Edworthy <phil.edworthy@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >   arch/arm/configs/shmobile_defconfig | 1 +
> >   1 file changed, 1 insertion(+)
> 
> > diff --git a/arch/arm/configs/shmobile_defconfig
> b/arch/arm/configs/shmobile_defconfig
> > index 5f05e98..6bc85a5 100644
> > --- a/arch/arm/configs/shmobile_defconfig
> > +++ b/arch/arm/configs/shmobile_defconfig
> > @@ -24,6 +24,7 @@ CONFIG_PL310_ERRATA_588369=y
> >   CONFIG_ARM_ERRATA_754322=y
> >   CONFIG_PCI=y
> >   CONFIG_PCI_RCAR_GEN2=y
> > +CONFIG_PCI_RCAR_GEN2_PCIE=y
> 
>     Hmm, I'm not sure why the option has GEN2 -- the driver claims support for
> R8A7779 as well as R8A779x. Probably the option should be renamed.
Technically, you are correct. However, whilst the driver does support R8A7779, that device only supports 32-bit accesses over the PCIe bus so it's only useful for custom cards, not off-the-shelf PCIe cards.

Phil
