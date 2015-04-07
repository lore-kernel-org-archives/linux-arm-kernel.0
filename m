From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 7 Apr 2015 21:41:40 +0200
Subject: [PATCH] ARM: at91/dt: add support for kizbox2.
In-Reply-To: <1428416031-30765-2-git-send-email-g.portay@overkiz.com>
References: <1428416031-30765-1-git-send-email-g.portay@overkiz.com>
 <1428416031-30765-2-git-send-email-g.portay@overkiz.com>
Message-ID: <20150407214140.254f9940@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ga?l,

On Tue,  7 Apr 2015 16:13:51 +0200
Ga?l PORTAY <g.portay@overkiz.com> wrote:

> Add DT file for Kizbox 2 board.
> This board is based on Atmel's SAMA5D31 Cortex-A5 SoC.
> 
> Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
> ---

[...]

> +
> +			pmc: pmc at fffffc00 {
> +				main: mainck {
> +					clock-frequency = <12000000>;

The main clock driver has been reworked in 3.16, and this
clock-frequency property is no longer needed (this value is taken
from the main_xtal definition).

Apart from that this patch looks good to me:

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
