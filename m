From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Jul 2014 09:00:33 +0200
Subject: [PATCH v4 5/6] serial: 8250_dw: Add support for deferred probing
In-Reply-To: <1404892479-12222-6-git-send-email-wens@csie.org>
References: <1404892479-12222-1-git-send-email-wens@csie.org>
 <1404892479-12222-6-git-send-email-wens@csie.org>
Message-ID: <20140715070033.GF3745@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 03:54:38PM +0800, Chen-Yu Tsai wrote:
> The 8250_dw driver fails to probe if the specified clock isn't
> registered at probe time. Even if a clock frequency is given,
> the required clock might be gated because it wasn't properly
> enabled.
> 
> This happened to me when the device is registered through DT,
> and the clock was part of an MFD, the PRCM found on A31 and A23
> SoCs. Unlike core clocks that are registered with OF_CLK_DECLARE,
> which happen almost immediately after the kernel starts, the
> clocks are registered as sub-devices of the PRCM MFD platform
> device. Even though devices are registered in the order they are
> found in the DT, the drivers are registered in a different,
> arbitrary order. It is possible that the 8250_dw driver is
> registered, and thus associated with the device and probed, before
> the clock driver is registered and probed.
> 
> 8250_dw then reports unable to get the clock, and fails. Without
> a working console, the kernel panics.
> 
> This patch adds support for deferred probe handling for the clock
> and reset controller.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140715/e8219f36/attachment.sig>
