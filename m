From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 23 Aug 2016 22:00:19 +0200
Subject: [PATCH v4 3/7] clk: sunxi: add generic multi-parent bus clock
 gates driver
In-Reply-To: <20160808172149.30861-4-andre.przywara@arm.com>
References: <20160808172149.30861-1-andre.przywara@arm.com>
 <20160808172149.30861-4-andre.przywara@arm.com>
Message-ID: <20160823200019.GQ2598@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 08, 2016 at 06:21:45PM +0100, Andre Przywara wrote:
> The Allwinner H3 SoC introduced bus clock gates with potentially
> different parents per clock gate register. The H3 driver chose to
> hardcode the actual parent clock relation in the code.
> Add a new driver (which has the potential to drive the H3 and also
> the simple clock gates as well) which uses the power of DT to describe
> this relationship in an elegant and flexible way.
> Using one subnode for every parent clock we get away with a single
> DT compatible match, which can be used as a fallback value in the
> actual DTs without the need to add specific compatible strings to the
> code.  This avoids adding a new driver or function for every new SoC.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Jean-Francois Moine <moinejf@free.fr>
> ---
>  drivers/clk/sunxi/Makefile          |   1 +
>  drivers/clk/sunxi/clk-multi-gates.c | 105 ++++++++++++++++++++++++++++++++++++

Aside from my initial objections (that I still have),
drivers/clk/sunxi is in maintainance-only mode, we won't merge any new
drivers there.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160823/16609d16/attachment.sig>
