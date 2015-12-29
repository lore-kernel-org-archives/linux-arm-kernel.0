From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 29 Dec 2015 22:26:52 +0100
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <20151229200244.GA27426@rob-hp-laptop>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151229200244.GA27426@rob-hp-laptop>
Message-ID: <1451424412.13576.1.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mardi 29 d?cembre 2015 ? 14:02 -0600, Rob Herring a ?crit :
> On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:
> > LP872x regulators are made active via the EN pin, which might be hooked to a
> > GPIO. This adds support for driving the GPIO high when the driver is in use.
> > 
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >  .../devicetree/bindings/regulator/lp872x.txt       |  1 +
> >  drivers/regulator/lp872x.c                         | 33 ++++++++++++++++++++--
> >  include/linux/regulator/lp872x.h                   |  2 ++
> >  3 files changed, 33 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/regulator/lp872x.txt b/Documentation/devicetree/bindings/regulator/lp872x.txt
> > index 7818318..0559c25 100644
> > --- a/Documentation/devicetree/bindings/regulator/lp872x.txt
> > +++ b/Documentation/devicetree/bindings/regulator/lp872x.txt
> > @@ -28,6 +28,7 @@ Optional properties:
> >    - ti,dvs-gpio: GPIO specifier for external DVS pin control of LP872x devices.
> >    - ti,dvs-vsel: DVS selector. 0 = SEL_V1, 1 = SEL_V2.
> >    - ti,dvs-state: initial DVS pin state. 0 = DVS_LOW, 1 = DVS_HIGH.
> > +  - ti,enable-gpio: GPIO specifier for EN pin control of LP872x devices.
> 
> Should be "-gpios" instead of "-gpio".

Care to comment why? There is only one GPIO that can be used here, since
there is only one single EN pin. I thought this matched what is done
already with "ti,dvs-gpio".

Thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151229/e2fc963f/attachment.sig>
