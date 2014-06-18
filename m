From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 18 Jun 2014 14:24:38 +0200
Subject: [PATCH v2 16/20] mfd: sun6i-prcm: Add support for Allwinner A23
 PRCM
In-Reply-To: <20140618082953.GO21030@lee--X1>
References: <1403016777-15121-1-git-send-email-wens@csie.org>
 <1403016777-15121-17-git-send-email-wens@csie.org>
 <20140618082953.GO21030@lee--X1>
Message-ID: <20140618122438.GR19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 09:29:53AM +0100, Lee Jones wrote:
> > The Allwinner A23 SoC has a PRCM unit like the previous A31 SoC.
> > The differences are the AR100 clock can no longer be modified,
> > the APB0 clock has different divisors, and some clock gates are
> > gone.
> > 
> > This patch adds a compatible with a modified subdevice list for
> > the A23.
> > 
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  .../devicetree/bindings/mfd/sun6i-prcm.txt         |  2 +-
> >  drivers/mfd/sun6i-prcm.c                           | 30 ++++++++++++++++++++++
> >  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> The patch looks fine to me, but I'm concerned about the size of the
> patch set and the amount of subsystems it touches.
> 
> I am guessing that this patch can just be taken independently though.
> Please correct me if I'm wrong.

I have a bit of the same concern. We have several comments on the
previous patches, so I'm not even sure this patch can go as is.

It would be much easier if you (ChenYu) could introduce first a very
basic with just the UART support, and then, as separate series,
clocks, PRCM, MMC, and so on.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140618/e3250f99/attachment-0001.sig>
