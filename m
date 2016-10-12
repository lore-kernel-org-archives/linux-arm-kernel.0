From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 12 Oct 2016 11:03:29 +0200
Subject: [PATCH v4 08/10] ARM: dts: sun8i: Enable sun8i-emac on the
 Orange Pi 2
In-Reply-To: <20161012105559.aaf9122e376fa5969a2e61d9@free.fr>
References: <1475828757-926-1-git-send-email-clabbe.montjoie@gmail.com>
 <1475828757-926-9-git-send-email-clabbe.montjoie@gmail.com>
 <20161012105559.aaf9122e376fa5969a2e61d9@free.fr>
Message-ID: <20161012090329.GA9245@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2016 at 10:55:59AM +0200, Jean-Francois Moine wrote:
> On Fri,  7 Oct 2016 10:25:55 +0200
> Corentin Labbe <clabbe.montjoie@gmail.com> wrote:
> 
> > The sun8i-emac hardware is present on the Orange PI 2.
> > It uses the internal PHY.
> > 
> > This patch create the needed emac node.
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---
> >  arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
> > index f93f5d1..5608eb4 100644
> > --- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
> > +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
> > @@ -54,6 +54,7 @@
> >  
> >  	aliases {
> >  		serial0 = &uart0;
> > +		ethernet0 = &emac;
> 
> As there is no 'of_alias_get_id' in the driver, this alias is
> useless.

Not really, this is used by U-Boot to set the mac address.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161012/982f5d88/attachment.sig>
