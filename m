From: broonie@kernel.org (Mark Brown)
Date: Fri, 26 Jul 2013 15:27:24 +0100
Subject: XCLKOUT in exynos5250 clock driver
In-Reply-To: <51F2695B.8020109@gmail.com>
References: <20130725145158.GI9858@sirena.org.uk> <51F247B6.9010902@linaro.org>
 <51F2695B.8020109@gmail.com>
Message-ID: <20130726142724.GG9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 02:19:39PM +0200, Sylwester Nawrocki wrote:
> On 07/26/2013 11:56 AM, Tushar Behera wrote:
> >On 07/25/2013 08:21 PM, Mark Brown wrote:

> >>I appear to be missing something in the clock driver for the exynos5250.
> >>I'm looking at the Arndale schematic and I see that the audio master

> This is something that's not yet supported in the mainline kernels I'm
> afraid.

I was trying to be polite :)

> I suspect that the same, you can easily verify that by checking what ball
> identifier corresponds to XCLKOUT pin and how the routing looks like on
> the schematics.

Right, for what it's worth it's ball AJ27 marked as XCLKOUT/ETC6_1

> We have a bit hackish patch that adds support for the CLKOUT at the
> Exynos4 clocks driver to enable the audio codec. An issue here is that the
> CLKOUT mux and divider control bitfield is in the PMU registers (as opposed
> to CMU where the clock  control registers normally are) and additionally
> single register contains the clock mux/divider bitfield as well as couple
> other unrelated control bits. Depending if those other bits are considered
> really important or not it it might another reason to expose (part of ?)
> PMU registers through syscon-like interface. There are registers in PMU

Sounds like it'd be a good idea to do that if only for the purpose of
describing things clearly in the DT.

> It can be seen in the Galaxy S3 kernel code how the Exynos5 CLKOUT handling
> might look like. See enum xclkout_select [1], exynos5_pmu_xclkout_set [2].
> It would be good someone who has access to the datasheet come up with at
> with some patch so the audio works are not blocked. I'm not working right
> now on Exynos5 :P.

I suspect I can reverse engineer something from this, though it would be
much easier for someone with the datasheet.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130726/e93d2ce4/attachment-0001.sig>
