From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 Feb 2016 21:17:54 +0100
Subject: [PATCH v3 2/2] clk: sunxi: Refactor A31 PLL6 so that it can be
 reused
In-Reply-To: <20160130185714.7abcf1de9ef8108c2f48c7fe@free.fr>
References: <1454008958-12655-1-git-send-email-maxime.ripard@free-electrons.com>
 <1454008958-12655-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160130185714.7abcf1de9ef8108c2f48c7fe@free.fr>
Message-ID: <20160201201754.GI4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Jan 30, 2016 at 06:57:14PM +0100, Jean-Francois Moine wrote:
> On Thu, 28 Jan 2016 20:22:38 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > Remove the fixed dividers from the PLL6 driver to be able to have a
> > reusable driver that can be used across several SoCs that share the same
> > controller, but don't have the same set of dividers for this clock, and to
> > also be reused multiple times in the same SoC, since we're droping the
> > clock name.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> > Changes from v2
> >   - Rebased and converted over to the new factors refactoring. Fixed the
> >     retrieved rate
> > 
> >  arch/arm/boot/dts/sun6i-a31.dtsi     | 36 ++++++++++++++++++------------------
> >  arch/arm/boot/dts/sun8i-a23-a33.dtsi | 25 +++++++++++++++++--------
> >  arch/arm/boot/dts/sun8i-a23.dtsi     |  2 +-
> >  arch/arm/boot/dts/sun8i-a33.dtsi     |  4 ++--
> >  arch/arm/boot/dts/sun8i-h3.dtsi      | 36 ++++++++++++++++++------------------
> >  drivers/clk/sunxi/clk-sunxi.c        | 32 ++++++++++++++++----------------
> >  6 files changed, 72 insertions(+), 63 deletions(-)
> 
> Hi Maxime,
> 
> Do you know that the DT definitions cannot be changed when they are in
> the mainline kernel?

AFAIK, the only ARM platform that ever had such a policy was mvebu,
and they finally gave up on it. So, as far as I'm concerned, the DT
ABI simply doesn't exist.

> Also, for the H3 PLL periph1 (aka PLL8), why didn't you create a
> 'pll8x2' clock with 'pll8' as a divider?

No one seems to use it. We can always add it later in a separate
patch when someone will.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160201/8832850c/attachment.sig>
