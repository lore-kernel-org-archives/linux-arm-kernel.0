From: robh@kernel.org (Rob Herring)
Date: Mon, 8 Oct 2018 08:30:38 -0500
Subject: [PATCH 22/36] dt-bindings: arm: Convert FSL board/soc bindings to
 json-schema
In-Reply-To: <20181008070142.GM3587@dragon>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-23-robh@kernel.org>
 <20181008070142.GM3587@dragon>
Message-ID: <CAL_JsqJu0AGH7VizWJJVB2UnFhWKwMVTm-EznOfhDVabgQUA_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 8, 2018 at 2:02 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Fri, Oct 05, 2018 at 11:58:34AM -0500, Rob Herring wrote:
> > Convert Freescale SoC bindings to DT schema format using json-schema.

> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - description: i.MX23 based Boards
> > +        items:
> > +          - enum:
> > +              - fsl,imx23-evk
> > +              - olimex,imx23-olinuxino
> > +          - const: fsl,imx23
> > +
> > +      - description: i.MX25 Product Development Kit
> > +        items:
> > +          - enum:
> > +              - fsl,imx25-pdk
> > +          - const: fsl,imx25
> > +
> > +      - description: i.MX27 Product Development Kit
> > +        items:
> > +          - enum:
> > +              - fsl,imx27-pdk
> > +          - const: fsl,imx27
> > +
> > +      - description: i.MX28 based Boards
> > +        items:
> > +          - enum:
> > +              - fsl,imx28-evk
> > +              - i2se,duckbill
> > +              - i2se,duckbill-2
> > +              - technologic,imx28-ts4600
> > +          - const: fsl,imx28
> > +      - items:
>
> The schema is new to me.  This line looks unusual to me, so you may want
> to double check.

It's fine. There's just no description schema on this one as it's a
continuation of the previous one (logically, but not from a schema
perspective). Perhaps add "i.MX28 I2SE Duckbill 2 based boards".

> > +          - enum:
> > +              - i2se,duckbill-2-485
> > +              - i2se,duckbill-2-enocean
> > +              - i2se,duckbill-2-spi
> > +          - const: i2se,duckbill-2
> > +          - const: fsl,imx28
> > +
> > +      - description: i.MX51 Babbage Board
