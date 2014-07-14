From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 14 Jul 2014 10:07:01 +0200
Subject: [PATCH v5 00/14] Clock support for rk3066,rk3188 and rk3288
In-Reply-To: <CAOesGMgcM3Z68VUOu8g6Ee0FjvW4r3R2sLtf255e9pv+gGyqFA@mail.gmail.com>
References: <156042792.J76K6jxIGl@diego> <20140713194622.9850.99668@quantum>
 <CAOesGMgcM3Z68VUOu8g6Ee0FjvW4r3R2sLtf255e9pv+gGyqFA@mail.gmail.com>
Message-ID: <2878354.yVHl3h6vxm@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Am Sonntag, 13. Juli 2014, 20:12:07 schrieb Olof Johansson:
> Hi,
> 
> On Sun, Jul 13, 2014 at 12:46 PM, Mike Turquette <mturquette@linaro.org> 
wrote:
> > Quoting Heiko St?bner (2014-07-02 16:53:24)
> > 
> >> This series adds a clock driver infrastructure for Rockchip SoCs in
> >> general and clock-definitions for the RK3188 and RK3288 in particular.
> >> 
> >> Apart from the arch/arm patches included here, there are some more
> >> in the waiting line, like adding the i2c nodes and possibly the pwm, i2s
> >> and spi nodes if the relevant drivers get accepted, where the ids
> >> defined in the dt-binding headers are needed.
> >> 
> >> So if the whole thing is acceptable could we either offer a branch
> >> from the clk-tree that can get merged or take the whole series through
> >> the arm tree?
> > 
> > Heiko,
> > 
> > This version looks good. I've pushed a branch with all 14 of these
> > patches based on 3.16-rc3 to the clk tree. See:
> > 
> > git://git.linaro.org/people/mike.turquette/linux.git clk-rockchip
> > 
> > If everyone is OK to merge that stable branch then I will merge
> > clk-rockchip into clk-next and we're all good. If the arm-soc guys want
> > to carve it up a bit further or handle it in a different way then we can
> > do that. I've Cc'd arm-soc for clarification.
> 
> Traditionally we usually take the DT changes through arm-soc, but as
> long as we share the branch we might be ok. We tend to stick them in
> different branches in our tree though, so rockchip will be a little
> mis-sorted this release. Not a big deal, and we can deal with it.
> 
> So, I'll leave it to Heiko to choose here, he knows best what other DT
> changes are coming this release. If he wants to carry the DT changes
> separately, then patches 1-10 would be for the clk tree, so it should
> be easy to reset the branch back a bit (and 11-14 would be for
> arm-soc).

hmm, there are essentially two changeset/branches upcoming:
- the collected dts changes for rk3066 and rk3188 I posted saturday
  These essentially extend patches 12-14
- rk3288 support which would start off patch 11 (the reset controller)

So if we were to separate the series I would say patches 1-11 in the shared 
branch and patch 12-14 as the first ones for a rk3066/rk3188 specific branch.


Heiko
