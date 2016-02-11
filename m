From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Feb 2016 10:53:15 +0100
Subject: [PATCH v4] clk: sunxi: Refactor A31 PLL6 so that it can be reused
In-Reply-To: <20160210180420.0968c2018bf5fbe54a28a505@free.fr>
References: <1454358000-13594-1-git-send-email-maxime.ripard@free-electrons.com>
 <20160204120507.GC4270@lukather>
 <20160204162545.f806fcb64a826d2c3313985b@free.fr>
 <20160210125333.GC31506@lukather>
 <20160210180420.0968c2018bf5fbe54a28a505@free.fr>
Message-ID: <20160211095315.GJ31506@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 10, 2016 at 06:04:20PM +0100, Jean-Francois Moine wrote:
> On Wed, 10 Feb 2016 13:53:33 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > > I don't agree:
> > > - you changed the DTs of many SoCs without any valid reason,
> > 
> > I did give you a significant number of reasons [1]. The fact that you
> > chose to ignore them is up to you.
> 
> Sorry, I don't see any reason for changing the DT definition of the pll6.
> The clock is named "pll6" with "#clock-cells = <1>;" in all DTs,
> and it works as it is.
> If you want an other clock as "pll8", with the same HW description,
> you must add new code for this clock.

That's not how it works. If an hardware block is strictly identical,
then it should use the same compatible.

The PLL8 is exactly the same one than PLL6, therefore it should use
the same compatible.

> > Except that it doesn't match the hardware and that the parenthood
> > relationship is inversed. The pll6 output is 24 MHz * n * k / 2, as
> > seen in any datasheet that uses it. Your clock driver doesn't
> > represent that fact.
> 
> The datasheet says that the pll6x2 output is 24 MHz * n * k, then, if
> I remember correctly my lessons at primary school, defining pll6 as
> (pll6x2 / 2) gives 24 MHz * n * k / 2 as the pll6 output. No?

Or, you could keep the same parenting relationship that we had and use
a simpler model. Ever heard of Occam's razor (and quite literally for
once)?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160211/3ad2c0ce/attachment.sig>
