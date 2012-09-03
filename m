From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Sep 2012 16:20:16 +0100
Subject: [PATCH 3/3] i2c: nomadik: Add Device Tree support to the Nomadik
 I2C driver
In-Reply-To: <5044C82E.5060207@gmail.com>
References: <20120831122323.GC5962@gmail.com>
 <CACRpkdZ=C1EV4WO2b=1YLHPNhsDsQdq7Kfnpzm8i7uGRtVjJuQ@mail.gmail.com>
 <20120903094448.GB11780@pengutronix.de>
 <20120903100656.GC5782@gmail.com>
 <CACRpkdb8owKBxawAv4LVVYx5kUgZ9cUSiQ=BV0f3Pf3bHtknuQ@mail.gmail.com>
 <CAF2Aj3j25w1Nn9O6hV+=i-j1ts_p_Ucswk_M7r04S7i5BzPkHg@mail.gmail.com>
 <CACRpkdZ5VFhrbONy=0K5MFh4e6BDFckq0yqzjQ2QkW9MgwKqBg@mail.gmail.com>
 <5044BFD1.10708@nvidia.com>
 <CACRpkda0akcLRe3J=fVcyYpxHmkJmVe+c1doXQ4=vOA6iNxe2g@mail.gmail.com>
 <5044C82E.5060207@gmail.com>
Message-ID: <20120903152012.GH31163@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2012 at 10:09:34AM -0500, Rob Herring wrote:
> On 09/03/2012 09:35 AM, Linus Walleij wrote:
> > On Mon, Sep 3, 2012 at 4:33 PM, Stephen Warren <swarren@nvidia.com> wrote:
> >> On 09/03/2012 05:58 AM, Linus Walleij wrote:
> >>> On Mon, Sep 3, 2012 at 1:32 PM, Lee Jones <lee.jones@linaro.org> wrote:
> >>>
> >>>> No, this is wrong. Platform data should not override DT.
> >>>>
> >>>> If DT is enabled and passed, it should have highest priority.
> >>
> >> No, that's wrong. If platform data is specified, it overrides DT, so
> >> that if the DT needs any fixup, it can be provided using platform data.
> > 
> > Thanks Stephen, now there are two of us saying this, Lee please
> > follow this design pattern.
> > 
> > (Unless Rob/Grant start shouting counter-orders...)
> 
> Ideally, you only use DT or platform_data and you override DT with a new
> DTB. Hopefully we can ultimately remove platform_data or all but parts
> that can't be described in DT (i.e. function callouts).

Exactly. I don't believe that AUX_DATA() should be used as a facility to
override DT settings from platform_data.

> But if you are handling both, then I agree that platform_data should
> override DT.

I do agree with this, but I haven't stumbled over such a use-case yet.
I have only provided; clock names, DMA settings and call-back information
via AUX_DATA() thus far, and those are being removed too when a) the 
correct bindings are mainlined and b) I have the time.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
