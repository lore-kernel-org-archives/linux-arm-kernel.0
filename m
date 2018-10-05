From: robh@kernel.org (Rob Herring)
Date: Fri, 5 Oct 2018 13:32:38 -0500
Subject: [PATCH 19/36] dt-bindings: arm: Convert Atmel board/soc bindings
 to json-schema
In-Reply-To: <20181005180725.GH5626@piout.net>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-20-robh@kernel.org>
 <20181005180725.GH5626@piout.net>
Message-ID: <CAL_JsqJBRaNf73feHzG4aYyEMxWso8a7Wt6L0JZJLGWecymoUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 5, 2018 at 1:07 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello,
>
> On 05/10/2018 11:58:31-0500, Rob Herring wrote:
> > diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > new file mode 100644
> > index 000000000000..f788315b94fa
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> > @@ -0,0 +1,132 @@
> > +# SPDX-License-Identifier: None
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bindings/arm/atmel-at91.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Atmel AT91 device tree bindings.
> > +
> > +maintainers:
> > +  - Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > +  - Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>
> Jean-Christophe has not been active for years, I'd mention Ludovic
> instead.

Will update. I generated these out of git log. I didn't use
get_maintainers.pl because it seems lots of files don't have
maintainers listed (other than Mark and me) and I didn't want to be
it.

>
> > +description: |
> > +  Boards with a SoC of the Atmel AT91 or SMART family shall have the following
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: atmel,at91rm9200
> > +      - items:
> > +          - enum:
> > +              - olimex,sam9-l9260
> > +          - enum:
> > +              - atmel,at91sam9260
> > +              - atmel,at91sam9261
> > +              - atmel,at91sam9263
> > +              - atmel,at91sam9g20
> > +              - atmel,at91sam9g45
> > +              - atmel,at91sam9n12
> > +              - atmel,at91sam9rl
> > +              - atmel,at91sam9xe
> > +          - const: atmel,at91sam9
> > +
> > +      - items:
> > +          - enum:
> > +              - atmel,at91sam9g15
> > +              - atmel,at91sam9g25
> > +              - atmel,at91sam9g35
> > +              - atmel,at91sam9x25
> > +              - atmel,at91sam9x35
> > +          - const: atmel,at91sam9x5
> > +          - const: atmel,at91sam9
> > +
> > +      - items:
> > +          - const: atmel,sama5d27
> > +          - const: atmel,sama5d2
> > +          - const: atmel,sama5
> > +
> > +      - description: Nattis v2 board with Natte v2 power board
> > +        items:
> > +          - const: axentia,nattis-2
> > +          - const: axentia,natte-2
> > +          - const: axentia,linea
>
> Shouldn't we have the board specific compatibles in a separate file to
> avoid mixing everything with the SoC compatibles?

You can't validate it that way. I have to say "must be compatible A,
B, C and in that order" and you can't if A, B, and C are in different
files. We could do board vendor files, but then we have to duplicate
the SoC compatibles. I don't think there's any board vendor with
enough boards to justify that. The only place I've found that the
compatible lists get kind of messy is when platforms have a variable
number of compatible strings.

We generally have not split things this way for most platforms except
i.MX which this series changes. Looks like I forgot to remove the
axentia.txt for Atmel.

Rob
