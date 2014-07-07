From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Jul 2014 11:01:14 +0200
Subject: [PATCH v3 9/9] ARM: sun8i: Add reset controller nodes to the DTSI
In-Reply-To: <1404399349-20237-10-git-send-email-wens@csie.org>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
 <1404399349-20237-10-git-send-email-wens@csie.org>
Message-ID: <20140707090114.GI16262@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 10:55:49PM +0800, Chen-Yu Tsai wrote:
> The A23 has the same MMIO reset controllers matching the clocks gates,
> just like in the A31. This patch adds the reset controller nodes and
> the reset control phandles for the peripherals needing them to the
> DTSI.
> 
> Unlike the sun6i DTSI, this patch uses sun6i-a31-clock-reset for
> ahb1_rst. sun6i-a31-ahb-reset is for early init, and requires some
> additions to the machine code. It is used to support the hstimer.
> However the hstimer on sun8i only has 1 timer, which is somewhat
> useless. Support for it will probably not be added. Hence the
> decision to use sun6i-a31-clock-reset here to avoid the changes to
> sun8i machine code.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140707/96140bc2/attachment.sig>
