From: robh@kernel.org (Rob Herring)
Date: Mon, 8 Oct 2018 08:46:08 -0500
Subject: [PATCH 28/36] dt-bindings: arm: Convert Rockchip board/soc
 bindings to json-schema
In-Reply-To: <1857752.ZLvpeyYpZr@phil>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-29-robh@kernel.org> <1857752.ZLvpeyYpZr@phil>
Message-ID: <CAL_Jsq+79kn8BtL_saZOMGRqJ0kJq14HCekhVPfbFSquBdRAqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 8, 2018 at 4:45 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Rob,
>
> either I'm misunderstanding that, or something did go a bit wrong during
> the conversion, as pointed out below:
>
> Am Freitag, 5. Oktober 2018, 18:58:40 CEST schrieb Rob Herring:
> > Convert Rockchip SoC bindings to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: devicetree at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-rockchip at lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/rockchip.txt      | 220 ----------------
> >  .../devicetree/bindings/arm/rockchip.yaml     | 242 ++++++++++++++++++
> >  2 files changed, 242 insertions(+), 220 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/rockchip.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/rockchip.yaml
> >
>
>
>
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - amarula,vyasa-rk3288
> > +              - asus,rk3288-tinker
> > +              - radxa,rock2-square
> > +              - chipspark,popmetal-rk3288
> > +              - netxeon,r89
> > +              - firefly,firefly-rk3288
> > +              - firefly,firefly-rk3288-beta
> > +              - firefly,firefly-rk3288-reload
> > +              - mqmaker,miqi
> > +              - rockchip,rk3288-fennec
> > +          - const: rockchip,rk3288
>
> These are very much distinct boards, so shouldn't they also get
> individual entries including their existing description like the phytec
> or google boards below?

It is grouped by SoC compatible and # of compatible strings. So this
one is all the cases that have 2 compatible strings. It is simply
saying the 1st compatible string must be one of the enums and the 2nd
compatible string must be "rockchip,rk3288".

>
> Similarly why is it an enum for those, while the Google boards get a
> const for each compatible string?

Because each Google board is a fixed list of strings.

> Most non-google boards below also lost their description and where lumped
> together into combined entries. Was that intentional?

If the description was just repeating the compatible string with
spaces and capitalization, then yes it was intentional. If your
description matches what you have for 'model', then I'd prefer to see
model added as a property schema.

Rob
