From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 26 Jul 2018 17:16:12 +0530
Subject: [PATCH v7 4/6] dt-bindings: mailbox: imx-mu: add i.MX6SX and
 i.MX7S SoCs.
In-Reply-To: <1532604937.32306.30.camel@pengutronix.de>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-5-o.rempel@pengutronix.de>
 <CABb+yY32vBy5qVYsQ6u45=rV6gEggqKy3Jqn1B4oWHaGfTyQ8Q@mail.gmail.com>
 <1532601691.32306.28.camel@pengutronix.de>
 <CABb+yY1GEmw_8q2HaF8y5VfFJX_c_0_MbWtPUE_j_o-zS8iZ_g@mail.gmail.com>
 <1532604937.32306.30.camel@pengutronix.de>
Message-ID: <CABb+yY0LbLfK2SEdTeuDmaGc+PsVn0AREQ=E=c4UZgxa5K95qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 5:05 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Donnerstag, den 26.07.2018, 16:45 +0530 schrieb Jassi Brar:
>> On Thu, Jul 26, 2018 at 4:11 PM, Lucas Stach <l.stach@pengutronix.de>
>> wrote:
>> > Hi Jassi,
>> >
>> > Am Donnerstag, den 26.07.2018, 15:25 +0530 schrieb Jassi Brar:
>> > > On Thu, Jul 26, 2018 at 12:23 PM, Oleksij Rempel
>> > > > <o.rempel@pengutronix.de> wrote:
>> > > > This are currently tested SoCs with imx-mailbox driver.
>> > > >
>> > > > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> > > >
>> > > > ---
>> > > >  Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 2 +-
>> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > > >
>> > > > diff --git
>> > > > a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
>> > > > b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
>> > > > index 113d6ab931ef..5616d2afca45 100644
>> > > > --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
>> > > > +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
>> > > > @@ -18,7 +18,7 @@ Messaging Unit Device Node:
>> > > >  Required properties:
>> > > >  -------------------
>> > > >  - compatible : should be "fsl,<chip>-mu", the supported chips
>> > > > include
>> > > > -               imx8qxp, imx8qm.
>> > > > +               imx6sx, imx7s, imx8qxp, imx8qm.
>> > > >
>> > >
>> > > This is not scalable. Do we add every new SoC that contains the
>> > > same controller?
>> >
>> > Yes, we do. This is a policy direction from the DT maintainers.
>> >
>>
>> I would love to read the post/documentation.
>>
>> Consider the same h/w - controller and platforms, but only the the MU
>> chapter said the controller name is, say, 'MU121'. I am sure now you
>> will see it correct to call it "fsl,mu121" compatible.
>> What changed? just the name, right?
>>
>>
>> > If we
>> > ever going to want to validate DTs against the binding, all
>> > compatibles
>> > used in the DTs must be specified in the binding.
>> >
>> > As we can't really tell if the controller is exactly the same or
>> > even
>> > has some SoC integration bugs, we generally add a new compatible
>> > for
>> > each SoC to key off any workarounds necessary in the driver without
>> > the
>> > need to change the DTs, breaking compatibility.
>> >
>>
>> I think if the h/w resources and behaviour remain the same and the
>> documentation does not call it by a different name -- it is safe to
>> assume its the same IP. Especially when the driver is absolutely
>> indifferent to the 5 SoC names.
>
> Even if it is the same IP core, the SoC integration might have bugs
> that need different behavior from the driver. We've already had that
> case with the i.MX6 SPI controller.
>
For h/w quirks/bugs, a new "has-that-bug" property makes better sense.
Or, if you insist, a new compatible based on the first soc that has
the buggy block.


>> If/when we find the controller changes, we could revisit the binding
>> and add another compatible option and modify the driver to catch that
>> and adapt.
>
> That's way too late. If we want to keep DTs stable
>
How do you keep the DT stable by explicitly defining every new SoC to
the compatible list in DT, _add_ to the driver.... only to have the
driver absolutely not care which SoC is it?
Which is the situation right now with this patchset.

thnx.
