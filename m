From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 21 Jul 2016 11:18:51 +0200
Subject: [PATCH 3/3] mmc: sunxi: Add support to the Allwinner A83T
In-Reply-To: <20160721085838.GH5993@lukather>
References: <cover.1469082481.git.moinejf@free.fr>
 <0ddc5f7d9a42515f901c95b8c0c1f5a5e4d575e9.1469082481.git.moinejf@free.fr>
 <20160721085838.GH5993@lukather>
Message-ID: <20160721111851.133a3f16d6e9de1ee45b3654@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Jul 2016 10:58:38 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Wed, Jul 20, 2016 at 08:28:47PM +0200, Jean-Francois Moine wrote:
> > The rate of the PLL-PERIPH clock is usually set to 1.2GHz in the A83T.
> 
> Uh? The datasheet says to set it to 600MHz.

Right. But the driver of the SDK for the Banana Pi M3 (A83T) sets it
to 1.2GHz.

> > This patch sets the phase delays of the output and sample clocks
> > accordingly.
> > 
> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > ---
> > Note: The impacted phase delays are only for 50MHz.
> > The phase delays are not used in 50MHz 8 bits DDR (new timing mode).
> 
> Actually, they seem to be, in the new timing mode register.

In the SDK driver, nothing is set in the new timing mode register.
Anyway, the eMMC works fine in both the Banana Pis M2+ and M3
with no delay.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
