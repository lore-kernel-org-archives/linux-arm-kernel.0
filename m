From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Wed, 15 Feb 2017 00:35:39 +0100
Subject: [PATCH v6 5/5] ARM: dts: sun9i: Initial support for the Sunchip
 CX-A99 board
In-Reply-To: <CAGb2v64AfBW+CHHkFvvNzCGBG09UK-sPcAZi2QgCR9wM=jguxw@mail.gmail.com>
References: <cover.1486592470.git.rask@formelder.dk>
 <d4211c5d57f80b0281d7d332edc7d69e66202d3d.1486592471.git.rask@formelder.dk>
 <20170210085920.7l7gswm6yjuqgdfx@lukather>
 <CAGb2v64AfBW+CHHkFvvNzCGBG09UK-sPcAZi2QgCR9wM=jguxw@mail.gmail.com>
Message-ID: <20170214233538.enkffjiw3kkfromu@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 10, 2017 at 05:22:21PM +0800, Chen-Yu Tsai wrote:
> On Fri, Feb 10, 2017 at 4:59 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Thu, Feb 09, 2017 at 12:34:06AM +0100, Rask Ingemann Lambertsen wrote:
[...]
> >> diff --git a/arch/arm/boot/dts/sun9i-a80-cx-a99.dts b/arch/arm/boot/dts/sun9i-a80-cx-a99.dts
> >> new file mode 100644
> >> index 0000000..f5496d2
> >> --- /dev/null
> >> +++ b/arch/arm/boot/dts/sun9i-a80-cx-a99.dts
[...]
> >> +     pmic at 745 {
> >> +             compatible = "x-powers,axp808", "x-powers,axp806";
> 
> As you mentioned elsewhere, they are not really compatible.
> You should drop the latter compatible.

The compatibility is good enough that it works fine with the driver that
went into kernel 4.9 and 4.10. Using this device tree file, I have built and
booted 4.9.9 and 4.10-rc7 kernels as per the instructions here;
https://linux-sunxi.org/Sunchip_CX-A99#Linux_kernel
Likewise any other AXP806 driver which doesn't touch the register at address
0xff will work fine.

So, the disadvantage of removing the "x-powers,axp806" compatible is that
it breaks on two kernel versions where it works fine with the compatible.
What is the advantage of removing the "x-powers,axp806" compatible?

As to touching the register at 0xff, it would be interesting to know more
precisely what goes wrong. The symptom is these messages in the log:

[    3.209573] axp20x-rsb sunxi-rsb-745: AXP20x variant AXP806 found
[    3.210153] axp20x-rsb sunxi-rsb-745: Failed to set masks in 0x40: -5
[    3.210178] axp20x-rsb sunxi-rsb-745: failed to add irq chip: -5
[    3.210306] axp20x-rsb: probe of sunxi-rsb-745 failed with error -5

I haven't yet looked further into what happens at the RSB bus level.

-- 
Rask Ingemann Lambertsen
