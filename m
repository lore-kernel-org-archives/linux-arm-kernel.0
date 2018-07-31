From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 31 Jul 2018 15:46:59 +0530
Subject: [PATCH v7 4/6] dt-bindings: mailbox: imx-mu: add i.MX6SX and
 i.MX7S SoCs.
In-Reply-To: <20180730222207.GA28554@rob-hp-laptop>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-5-o.rempel@pengutronix.de>
 <CABb+yY32vBy5qVYsQ6u45=rV6gEggqKy3Jqn1B4oWHaGfTyQ8Q@mail.gmail.com>
 <20180730222207.GA28554@rob-hp-laptop>
Message-ID: <CABb+yY1LsOUOrEGfmVyOptGRGwUL8KmoLEWABg6AxMo+ia53Lg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 3:52 AM, Rob Herring <robh@kernel.org> wrote:
> On Thu, Jul 26, 2018 at 03:25:15PM +0530, Jassi Brar wrote:
>> On Thu, Jul 26, 2018 at 12:23 PM, Oleksij Rempel
>> <o.rempel@pengutronix.de> wrote:
>> > This are currently tested SoCs with imx-mailbox driver.
>> >
>> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>> > ---
>> >  Documentation/devicetree/bindings/mailbox/fsl,mu.txt | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
>> > index 113d6ab931ef..5616d2afca45 100644
>> > --- a/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
>> > +++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.txt
>> > @@ -18,7 +18,7 @@ Messaging Unit Device Node:
>> >  Required properties:
>> >  -------------------
>> >  - compatible : should be "fsl,<chip>-mu", the supported chips include
>> > -               imx8qxp, imx8qm.
>> > +               imx6sx, imx7s, imx8qxp, imx8qm.
>> >
>> This is not scalable. Do we add every new SoC that contains the same controller?
>> I think the controller name, if it has one or create a new one like
>> 'imx-mu',  should be used here.
>> So,
>>     compatible : should be "fsl,imx-mu"
>
> No, for all the reasons already correctly explained in this thread.
>
OK. I curious
>> BTW, the driver doesn't even probe anything other than
>> 'fsl,imx6sx-mu', unlike what the binding says.
>
> This aspect should be documented here though. The documentation should
> clearly define what are valid combinations of compatibles.
>
> Rob
