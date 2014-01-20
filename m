From: horms@verge.net.au (Simon Horman)
Date: Mon, 20 Jan 2014 09:14:46 +0900
Subject: PWM...
In-Reply-To: <201401192126.41543.arnd@arndb.de>
References: <20140119164956.GR15937@n2100.arm.linux.org.uk>
 <CAOesGMi7g=PHjzhkuObkeu+P_c6kUz5uFcND7euafUW56CvsnQ@mail.gmail.com>
 <20140119193026.GS15937@n2100.arm.linux.org.uk>
 <201401192126.41543.arnd@arndb.de>
Message-ID: <20140120001446.GD9752@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 09:26:40PM +0100, Arnd Bergmann wrote:
> On Sunday 19 January 2014, Russell King - ARM Linux wrote:
> > On Sun, Jan 19, 2014 at 11:11:41AM -0800, Olof Johansson wrote:
> > > On Sun, Jan 19, 2014 at 11:08 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > > Ah, yes, if you add a cell that can be done. There'll still be the
> > > "dead" first cell that will always be 0, but that's alright.
> > 
> > Does it not mean that PWM specifications of:
> > 
> >         <&pwm1 0 n> <&pwm2 0 n>
> > 
> > would need to be converted to:
> > 
> >         <&pwm1 0 n 0> <&pwm2 0 n 0>
> > 
> > in every DT file referring to these PWMs - because isn't this just
> > treated in DT as one single array of values?  (If DT knew how many
> > were in each specification, we wouldn't need the #foo-cells...)
> 
> Right: if you change an existing dts file from #pwm-cells=<2> to
> #pwm-cells=<3>, that requires changing all references to the pwm
> controller at the same time. If both the per-soc .dtsi files
> and the per-board .dts files contain references to the same pwm
> controller, that can end up in significant work. I have not checked
> if this is the case for i.MX though.

Would this change imply that old dtbs would no longer work with new kernels?
