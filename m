From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 13 Dec 2011 15:07:08 -0800
Subject: [PATCH V2 2/2] ARM: mmp: enable pinmux in platform driver
In-Reply-To: <CACRpkdbqj0zyRP4skGm4EX0Hx1Axe5-wkC14Y6Ee_B9TFzy39g@mail.gmail.com>
References: <1323769253-22580-1-git-send-email-haojian.zhuang@marvell.com>
 <1323769253-22580-3-git-send-email-haojian.zhuang@marvell.com>
 <CACRpkdbqj0zyRP4skGm4EX0Hx1Axe5-wkC14Y6Ee_B9TFzy39g@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1751860C3C@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Tuesday, December 13, 2011 4:02 PM:
> On Tue, Dec 13, 2011 at 10:40 AM, Haojian Zhuang wrote:
...
> > +static struct pinmux_map brownstone_pmx_map[] = {
> > + ? ? ? {
> > + ? ? ? ? ? ? ? .name = "dkin",
> > + ? ? ? ? ? ? ? .ctrl_dev_name = "mmp2-pinmux",
> > + ? ? ? ? ? ? ? .function = "dkin",
> > + ? ? ? ? ? ? ? .group = "dkin-2-pin",
> > + ? ? ? ? ? ? ? .hog_on_boot = true,
> > + ? ? ? }, {
...
> 
> Looks like we want to add
> #define PINMUX_MAP_SYS_HOG_GROUP() or so with four
> arguments, what do you say Stephen? Shall I try to patch  in
> something like that (then this patch will look even better).

Yes, sounds like a good idea. I just realized that I ignored PINMUX_MAP_*
in the stuff I'm working on and implemented exactly that macro as a custom
macro right before the map array. So, having it in the pinctrl header
would be good. 

-- 
nvpublic
