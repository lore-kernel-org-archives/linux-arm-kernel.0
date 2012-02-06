From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 Feb 2012 13:04:56 -0800
Subject: An extremely simplified pinctrl bindings proposal
In-Reply-To: <CACRpkdZthbejmTqRJAWHb8jU-p8LPT_+zj_CY1q0voMb4FKz2Q@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF178E5D3160@HQMAIL01.nvidia.com>
 <CACRpkdahin4srDh7dphgvq306gjz7CGP=h4dVkUY+w0z0wpXRQ@mail.gmail.com>
 <4F2F6AE2.1040504@nvidia.com>
 <CACRpkdbtTPSoX1x4aBtNVGZ2Qex9t77D09V9JgON_jfShQdx6w@mail.gmail.com>
 <20120206190315.GU1426@atomide.com>
 <CACRpkdZthbejmTqRJAWHb8jU-p8LPT_+zj_CY1q0voMb4FKz2Q@mail.gmail.com>
Message-ID: <20120206210456.GV1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [120206 11:25]:
> On Mon, Feb 6, 2012 at 8:03 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > So far the only
> > change needed for pinctrl drivers containing no data is that
> > we should make the string names optional and structure debugfs
> > around the physical register addresses instead. I'm basically
> > just setting the mux register physcal address as the pin name
> > for now to work around this.
> 
> OK please make a patch to do it really optional in the core if
> you find the time, it seems like a good change anyway, because
> it will make it possible to reduce some current pin name lists
> quite easily.

OK, will take a look at that.

> If you need to change the layout of debugfs just do it.
> 
> I actually had something like unnamed pins in the early patches
> to register a bunch of anonymous pins ranges, so why not bring
> it back in.

Yeah it seems that the mux registers should be listed, it might
require a little bit of thinking for cases where one register
controls multiple pins. So maybe we need just a new entry for
mux registers?

Regards,

Tony
