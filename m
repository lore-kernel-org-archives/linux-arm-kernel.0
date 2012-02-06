From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 Feb 2012 11:03:15 -0800
Subject: An extremely simplified pinctrl bindings proposal
In-Reply-To: <CACRpkdbtTPSoX1x4aBtNVGZ2Qex9t77D09V9JgON_jfShQdx6w@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF178E5D3160@HQMAIL01.nvidia.com>
 <CACRpkdahin4srDh7dphgvq306gjz7CGP=h4dVkUY+w0z0wpXRQ@mail.gmail.com>
 <4F2F6AE2.1040504@nvidia.com>
 <CACRpkdbtTPSoX1x4aBtNVGZ2Qex9t77D09V9JgON_jfShQdx6w@mail.gmail.com>
Message-ID: <20120206190315.GU1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [120206 08:58]:
> On Mon, Feb 6, 2012 at 6:53 AM, Stephen Warren <swarren@nvidia.com> wrote:
> 
> I will certainly finalize the pinctrl subsystem as-is, adding the
> pin configurations states as the last major piece. If for nothing
> else it provides some understanding of the problem space.
> 
> I think we should keep both for the time being and consider the
> alternative approach when patches appear. So if/when someone
> creates a new subsystem like this, drivers can move over to it on a
> per-driver basis. If there are zero drivers left in pinctrl it can be
> deleted.

Yes it seems that we can easily do both. So far the only
change needed for pinctrl drivers containing no data is that
we should make the string names optional and structure debugfs
around the physical register addresses instead. I'm basically
just setting the mux register physcal address as the pin name
for now to work around this.

Regards,

Tony
