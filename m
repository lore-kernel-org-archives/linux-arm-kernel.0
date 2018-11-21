From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 21 Nov 2018 08:46:27 -0800
Subject: [PATCH v5 08/12] dt-bindings: mediatek: Change the binding for
 mmsys clocks
In-Reply-To: <CAL_JsqKJQwfDJbpmwW+oCxiDkSp5+6mG-uoURmCQVEMP_jFOEg@mail.gmail.com>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-9-matthias.bgg@kernel.org>
 <20181116231522.GA18006@bogus>
 <2a23e407-4cd4-2e2b-97a5-4e2bb96846e0@gmail.com>
 <CAL_JsqKJQwfDJbpmwW+oCxiDkSp5+6mG-uoURmCQVEMP_jFOEg@mail.gmail.com>
Message-ID: <154281878765.88331.10581984256202566195@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Rob Herring (2018-11-19 11:15:16)
> On Sun, Nov 18, 2018 at 11:12 AM Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
> > On 11/17/18 12:15 AM, Rob Herring wrote:
> > > On Fri, Nov 16, 2018 at 01:54:45PM +0100, matthias.bgg at kernel.org wrote:
> > >> -    #clock-cells = <1>;
> > >> +
> > >> +    mmsys_clk: clock-controller at 14000000 {
> > >> +            compatible = "mediatek,mt2712-mmsys-clk";
> > >> +            #clock-cells = <1>;
> > >
> > > This goes against the general direction of not defining separate nodes
> > > for providers with no resources.
> > >
> > > Why do you need this and what does it buy if you have to continue to
> > > support the existing chips?
> > >
> >
> > It would show explicitly that the mmsys block is used to probe two
> > drivers, one for the gpu and one for the clocks. Otherwise that is
> > hidden in the drm driver code. I think it is cleaner to describe that in
> > the device tree.
> 
> No, that's maybe cleaner for the driver implementation in the Linux
> kernel. What about other OS's or when Linux drivers and subsystems
> needs change? Cleaner for DT is design bindings that reflect the h/w.
> Hardware is sometimes just messy.
> 

I agree. I fail to see what this patch series is doing besides changing
driver probe and device creation methods and making a backwards
incompatible change to DT. Is there any other benefit here?
