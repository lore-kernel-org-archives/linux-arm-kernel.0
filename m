From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 08 Aug 2014 10:36:04 +0200
Subject: [PATCH v2] ARM: imx6: add pci config space as platform resource
In-Reply-To: <CAOMZO5B1LWsBfDhsSn8PuxZb+Bdid-ce6ay_7G7SF75-vHpE5w@mail.gmail.com>
References: <1407433181-21960-1-git-send-email-l.stach@pengutronix.de>
 <CAOMZO5B1LWsBfDhsSn8PuxZb+Bdid-ce6ay_7G7SF75-vHpE5w@mail.gmail.com>
Message-ID: <1407486964.5167.4.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 07.08.2014, 15:12 -0300 schrieb Fabio Estevam:
> On Thu, Aug 7, 2014 at 2:39 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> > Fixes "imx6q-pcie 1ffc000.pcie: missing *config* reg space"
> > error exposed by new versions of the designware pcie driver.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > v2: also fix documentation example
> > ---
> >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 4 +++-
> >  arch/arm/boot/dts/imx6qdl.dtsi                           | 4 +++-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > index 9455fd0ec830..6fbba53a309b 100644
> > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > @@ -17,7 +17,9 @@ Example:
> >
> >         pcie at 0x01000000 {
> >                 compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
> > -               reg = <0x01ffc000 0x4000>;
> > +               reg = <0x01ffc000 0x04000>,
> > +                     <0x01f00000 0x80000>;
> > +               reg-names = "dbi", "config";
> 
> It would be nice to update the 'reg' description and add the
> 'reg-names' entry in the 'Required properties' section.
> 
> Currently we have the following description:
> 
> "reg: base addresse (---> typo here) and length of the pcie
> controller" ,which does not match the provided example after your
> patch.
> 
I'm a bit on the fence here. Yes, it's a bit inconsistent with the
example, but it's actually the same approach chosen for other properties
like clocks. Base properties are inherited from designware-pcie.txt and
only additional things are documented in fsl,imx6q-pcie.txt.

I'm leaning toward not breaking the existing practice.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
