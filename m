From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 Feb 2012 15:57:33 -0800
Subject: An extremely simplified pinctrl bindings proposal
In-Reply-To: <CACRpkdYrbD3PpJ3wb69yb3Ya8SeZJnPpgJdtttjWTkS5xsD-4g@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF178E5D3160@HQMAIL01.nvidia.com>
 <CACRpkdahin4srDh7dphgvq306gjz7CGP=h4dVkUY+w0z0wpXRQ@mail.gmail.com>
 <4F2F6AE2.1040504@nvidia.com>
 <CACRpkdbtTPSoX1x4aBtNVGZ2Qex9t77D09V9JgON_jfShQdx6w@mail.gmail.com>
 <20120206190315.GU1426@atomide.com>
 <CACRpkdZthbejmTqRJAWHb8jU-p8LPT_+zj_CY1q0voMb4FKz2Q@mail.gmail.com>
 <20120206210456.GV1426@atomide.com>
 <CACRpkdYrbD3PpJ3wb69yb3Ya8SeZJnPpgJdtttjWTkS5xsD-4g@mail.gmail.com>
Message-ID: <20120206235733.GY1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [120206 14:44]:
> On Mon, Feb 6, 2012 at 10:04 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> >> I actually had something like unnamed pins in the early patches
> >> to register a bunch of anonymous pins ranges, so why not bring
> >> it back in.
> >
> > Yeah it seems that the mux registers should be listed, it might
> > require a little bit of thinking for cases where one register
> > controls multiple pins. So maybe we need just a new entry for
> > mux registers?
> 
> I'm not sure if I'm following completely, if this is inside the devicetree-based
> driver file, would it work to just add a struct dentry * to the
> pinctrl_desc where you put a per-driver file?

I was thinking generic debufs entries for all drivers.
 
> Or maybe add extern void pinctrl_add_debugfs(struct dentry *) that adds
> a new file to the existing per-driver directory through the core and then
> have this add that file?

Sounds like you've thought it further than me already :)

Maybe that's the way to go to solve the one register for
multiple pins issue.
 
> Or did you mean that the core.c should be register-aware?

I was just thinking string name ignoring core.c, so that would
be the pinctrl_add_debugfs() option then. Do you see problems
with this approach?

Regards,

Tony
