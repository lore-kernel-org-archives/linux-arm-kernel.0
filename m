From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 16:29:23 -0700
Subject: [PATCH 3/7] mfd: add support for sun6i PRCM (Power/Reset/Clock
 Management) unit
In-Reply-To: <1398697130-8338-4-git-send-email-boris.brezillon@free-electrons.com>
References: <1398697130-8338-1-git-send-email-boris.brezillon@free-electrons.com>
 <1398697130-8338-4-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140428232923.GR3134@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Mon, Apr 28, 2014 at 04:58:46PM +0200, Boris BREZILLON wrote:
> The PRCM (Power/Reset/Clock Management) block exposes several subdevices
> in different subsystems (clk, reset ...)
> 
> Add basic support for the PRCM unit with clk (AR100, AHB0, and APB0 clks)
> and reset controller subdevices.
> 
> Other subdevices might be added later (if needed).
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
>  drivers/mfd/Kconfig      |   8 +++
>  drivers/mfd/Makefile     |   1 +
>  drivers/mfd/sun6i-prcm.c | 163 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 172 insertions(+)
>  create mode 100644 drivers/mfd/sun6i-prcm.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2d347c9..0a9220d 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -731,6 +731,14 @@ config MFD_STA2X11
>  	select MFD_CORE
>  	select REGMAP_MMIO
>  
> +config MFD_SUN6I_PRCM
> +	bool "Allwinner PRCM controller"

I'd mention the A31 in the prompt

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/d27454ae/attachment-0001.sig>
