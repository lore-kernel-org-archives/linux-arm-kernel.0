From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Sep 2017 12:01:50 +0200
Subject: [PATCH v2 09/13] drm/sun4i: hdmi: Add support for controller
 hardware variants
In-Reply-To: <20170926065919.24446-10-wens@csie.org>
References: <20170926065919.24446-1-wens@csie.org>
 <20170926065919.24446-10-wens@csie.org>
Message-ID: <20170926100150.5rgmraenrriekhna@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 06:59:15AM +0000, Chen-Yu Tsai wrote:
> The HDMI controller found in earlier Allwinner SoCs have slight
> differences between the A10, A10s, and the A31:
> 
>   - Need different initial values for the PLL related registers
> 
>   - Different behavior of the DDC and TMDS clocks
> 
>   - Different register layout for the DDC portion
> 
>   - Separate DDC parent clock on the A31
> 
>   - Explicit reset control
> 
> For the A31, the HDMI TMDS clock has a different value offset for
> the divider. The HDMI DDC block is different from the one in the
> other SoCs. As far as the DDC clock goes, it has no pre-divider,
> as it is clocked from a slower parent clock, not the TMDS clock.
> The divider offset from the register value is different. And the
> clock control register is at a different offset.
> 
> A new variant data structure is created to store pointers to the
> above functions, structures, and the different initial values.
> Another flag notates whether there is a separate DDC parent clock.
> If not, the TMDS clock is passed to the DDC clock create function,
> as before.
> 
> Regmap fields are used to deal with the different register layout
> of the DDC block.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/1040c9b5/attachment.sig>
