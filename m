From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Feb 2017 19:32:28 +0100
Subject: [PATCH v6 5/5] ARM: dts: sun9i: Initial support for the Sunchip
 CX-A99 board
In-Reply-To: <20170214233538.enkffjiw3kkfromu@localhost>
References: <cover.1486592470.git.rask@formelder.dk>
 <d4211c5d57f80b0281d7d332edc7d69e66202d3d.1486592471.git.rask@formelder.dk>
 <20170210085920.7l7gswm6yjuqgdfx@lukather>
 <CAGb2v64AfBW+CHHkFvvNzCGBG09UK-sPcAZi2QgCR9wM=jguxw@mail.gmail.com>
 <20170214233538.enkffjiw3kkfromu@localhost>
Message-ID: <20170216183228.3xgsy3idjgyw2boe@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 12:35:39AM +0100, Rask Ingemann Lambertsen wrote:
> On Fri, Feb 10, 2017 at 05:22:21PM +0800, Chen-Yu Tsai wrote:
> > On Fri, Feb 10, 2017 at 4:59 PM, Maxime Ripard
> > <maxime.ripard@free-electrons.com> wrote:
> > > Hi,
> > >
> > > On Thu, Feb 09, 2017 at 12:34:06AM +0100, Rask Ingemann Lambertsen wrote:
> [...]
> > >> diff --git a/arch/arm/boot/dts/sun9i-a80-cx-a99.dts b/arch/arm/boot/dts/sun9i-a80-cx-a99.dts
> > >> new file mode 100644
> > >> index 0000000..f5496d2
> > >> --- /dev/null
> > >> +++ b/arch/arm/boot/dts/sun9i-a80-cx-a99.dts
> [...]
> > >> +     pmic at 745 {
> > >> +             compatible = "x-powers,axp808", "x-powers,axp806";
> > 
> > As you mentioned elsewhere, they are not really compatible.
> > You should drop the latter compatible.
> 
> The compatibility is good enough that it works fine with the driver that
> went into kernel 4.9 and 4.10. Using this device tree file, I have built and
> booted 4.9.9 and 4.10-rc7 kernels as per the instructions here;
> https://linux-sunxi.org/Sunchip_CX-A99#Linux_kernel
> Likewise any other AXP806 driver which doesn't touch the register at address
> 0xff will work fine.
>
> So, the disadvantage of removing the "x-powers,axp806" compatible is that
> it breaks on two kernel versions where it works fine with the compatible.
> What is the advantage of removing the "x-powers,axp806" compatible?

This works fine for the features you tested, which are the
regulators. All the other features of the PMIC are untested, and might
or might not change, so you really don't know about the overall
capability of the PMIC with another model.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170216/e378788b/attachment-0001.sig>
