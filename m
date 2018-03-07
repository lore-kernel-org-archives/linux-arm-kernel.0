From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 7 Mar 2018 08:45:16 +0100
Subject: [PATCH 3/5] pwm: sun4i: Introduce (optional) reset support
In-Reply-To: <20180307020719.6675-4-andre.przywara@arm.com>
References: <20180307020719.6675-1-andre.przywara@arm.com>
 <20180307020719.6675-4-andre.przywara@arm.com>
Message-ID: <20180307074516.dbak7ztkua4p7mr5@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2018 at 02:07:17AM +0000, Andre Przywara wrote:
> While the PWM IP in the Allwinner H6 SoC is fully compatible to those
> used in older SoCs (H3, A64), it features a dedicated reset line which
> needs to be de-asserted.
> Add support for an optional "resets" DT property in our pwm-sun4i probe
> routine, and assert and de-assert the reset line, where needed.
> This allows to enable PWM support on the H6.

This isn't optional then. It's mandatory on the H6, and unneeded on
everything else. This is what we should have.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180307/eef51ad9/attachment.sig>
