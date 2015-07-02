From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 2 Jul 2015 10:52:14 +0800
Subject: [PATCH v2 2/4] dt-bindings: ARM: Mediatek: Document devicetree
 bindings for clock controllers
In-Reply-To: <CAGS+omD9Mvz0-RQMc5TsWCPct80S5fyqMn3+-zR7HB9yb7KoDQ@mail.gmail.com>
References: <1435633127-31952-1-git-send-email-jamesjj.liao@mediatek.com>
 <1435633127-31952-3-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omD9Mvz0-RQMc5TsWCPct80S5fyqMn3+-zR7HB9yb7KoDQ@mail.gmail.com>
Message-ID: <1435805534.3526.23.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

> > +Required Properties:
> > +
> > +- compatible: Should be:
> > +       - "mediatek,mt8173-imgsys", "syscon"
> > +- #clock-cells: Must be 1
> > +
> > +The imgsys controller uses the common clk binding from
> > +Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> > +
> > +Example:
> > +
> > +imgsys: imgsys at 15000000 {
> 
> Since these nodes will be supplying clocks to the rest of the system,
> I think the "name" part of each of these should all be
> "clock-controller", like topckgen and apmixedsys:
> 
>   imgsys: clock-controller at 15000000 {

These subsystems (and topckgen also) also contains other functions such
as reset controller, which may be implemented in clk/mediatek/ in the
future. It is suitable to use "clock-controller" as their name?


Best regards,

James
