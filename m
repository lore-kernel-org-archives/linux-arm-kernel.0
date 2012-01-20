From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 20 Jan 2012 13:15:34 -0800
Subject: Pinmux bindings proposal
In-Reply-To: <20120119165607.GG22818@atomide.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF17801D202F@HQMAIL01.nvidia.com>
 <CAJuYYwQoh4_SnA9wmy4x+cG0w0hGukxTkODWtcSw_2QHYuDsrg@mail.gmail.com>
 <20120119165607.GG22818@atomide.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB47A@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren wrote at Thursday, January 19, 2012 9:56 AM:
> * Thomas Abraham <thomas.abraham@linaro.org> [120119 04:37]:
...
> > * Specifying the pinmux/pinconfig settings in dts files:
> >
> > Device nodes which require specific pinmux/pinconfig settings should
> > include information about the required settings. For example, a i2c
> > controller node in dts file is listed below.
> >
> > i2c0: i2c at 18000000 {
> >         [... other properties ...]
> >         pinctrl-active = <&pctrl0 5 0 2 3 0>,
> >                              <&pctrl0 5 1 2 3 0>;
> >         pinctrl-suspend = <&pctrl0 5 0 2 0 0>,
> >                                 <&pctrl0 5 1 2 0 0>;
> > };
> 
> Maybe we should have just the active/suspend/off flags in the
> same array? Otherwise we'll end up unnecessarily repeating the
> the pin information. See the pins + #pin-args example I posted,
> which is otherwise similar.

Earlier discussions in this thread have discussed how to share common
settings between the various named states, by allowing the device to
refer to multiple properties or nodes for each named state; roughly:

foo at c8000200 {
   ...
   pinctrl = <&pinmux_foo> <&pinmux_foo_extra>
             <&pinmux_foo_suspend> <&pinmux_foo_extra_suspend>;
   pinctrl-entries = <2 2>;
   pinctrl-names = "active", "suspend";
};

I'll describe this more completely in my V2 bindings proposal.

-- 
nvpublic
