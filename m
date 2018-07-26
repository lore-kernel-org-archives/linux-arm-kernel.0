From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 26 Jul 2018 12:41:31 +0200
Subject: [PATCH v7 4/6] dt-bindings: mailbox: imx-mu: add i.MX6SX and
 i.MX7S SoCs.
In-Reply-To: <CABb+yY32vBy5qVYsQ6u45=rV6gEggqKy3Jqn1B4oWHaGfTyQ8Q@mail.gmail.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-5-o.rempel@pengutronix.de>
 <CABb+yY32vBy5qVYsQ6u45=rV6gEggqKy3Jqn1B4oWHaGfTyQ8Q@mail.gmail.com>
Message-ID: <1532601691.32306.28.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

Am Donnerstag, den 26.07.2018, 15:25 +0530 schrieb Jassi Brar:
> On Thu, Jul 26, 2018 at 12:23 PM, Oleksij Rempel
> > <o.rempel@pengutronix.de> wrote:
> > This are currently tested SoCs with imx-mailbox driver.
> > 
> > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> > ?Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 2 +-
> > ?1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> > index 113d6ab931ef..5616d2afca45 100644
> > --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> > +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
> > @@ -18,7 +18,7 @@ Messaging Unit Device Node:
> > ?Required properties:
> > ?-------------------
> > ?- compatible : should be "fsl,<chip>-mu", the supported chips include
> > -???????????????imx8qxp, imx8qm.
> > +???????????????imx6sx, imx7s, imx8qxp, imx8qm.
> > 
> 
> This is not scalable. Do we add every new SoC that contains the same controller?

Yes, we do. This is a policy direction from the DT maintainers. If we
ever going to want to validate DTs against the binding, all compatibles
used in the DTs must be specified in the binding.

As we can't really tell if the controller is exactly the same or even
has some SoC integration bugs, we generally add a new compatible for
each SoC to key off any workarounds necessary in the driver without the
need to change the DTs, breaking compatibility.

Regards,
Lucas
