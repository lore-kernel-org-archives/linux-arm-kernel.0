From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 28 Jul 2015 17:16:44 +0200
Subject: [RFCv2 1/3] docs: dts: Added documentation for Xilinx Zynq
 Reset Controller bindings.
In-Reply-To: <CAAtXAHc=WTg3VHugKZ+SHnCA7OKXLLay-aOJyk9C9r+Z2MWwBg@mail.gmail.com>
References: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
 <1437783682-13632-2-git-send-email-moritz.fischer@ettus.com>
 <1438070702.3193.4.camel@pengutronix.de> <55B73C64.5050903@xilinx.com>
 <CAAtXAHc=WTg3VHugKZ+SHnCA7OKXLLay-aOJyk9C9r+Z2MWwBg@mail.gmail.com>
Message-ID: <1438096604.3193.51.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Moritz, Michal,

Am Dienstag, den 28.07.2015, 06:57 -0700 schrieb Moritz Fischer:
[...]
> >>> +Example:
> >>> +    rstc: rstc at 240 {
> >>> +            #reset-cells = <1>;
> >>> +            compatible = "xlnx,zynq-reset-pl";
> >>> +            syscon = <&slcr>;
> >>
> >> Why the syscon phandle if rstc always is the child of slcr? Why not just
> >> request the syscon for the rstc's parent node.
> >
> > We are using this description for pincntrl which was properly reviewed
> > that's why I expect Moritz just use the same style.
> > But yes also referencing parent should work.
> 
> Michal is right, I tried to be consistent with the pinctrl. Either one
> is fine for me.
> We'll just have to make a decision :-)

Do you have a pointer to the pinctrl review? I'd like to know if
somebody had a good reason to use the phandle over the parent-child
relationship. I'd rather not add DT properties if they are not
necessary.
Regarding consistency, since the pinctrl node is also a child of the
slcr, you could just as well make the syscon phandle optional there and
remove it from the DT without breaking backwards compatibility.

> > TBH I don't have strong preference but having unified style is something
> > what I would prefer.
> >
> > Also I see that using parent is used by others and it looks like that
> > having something like syscon_regmap_lookup_parent will be worth to have.

That would be useful, yes.

regards
Philipp
