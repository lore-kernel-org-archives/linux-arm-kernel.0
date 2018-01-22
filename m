From: david@lechnology.com (David Lechner)
Date: Mon, 22 Jan 2018 11:17:03 -0600
Subject: [PATCH v6 26/41] ARM: da8xx: add new USB PHY clock init using
 common clock framework
In-Reply-To: <1516468460-4908-27-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-27-git-send-email-david@lechnology.com>
Message-ID: <e23bf869-cdbd-bd70-3f43-69c6ec03d95c@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2018 11:14 AM, David Lechner wrote:
> This adds the new USB PHY clock init in mach-davinci/usb-da8xx.c using
> the new common clock framework drivers.
> 
> The #ifdefs are needed to prevent compile errors until the entire
> ARCH_DAVINCI is converted.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v6 changes:
> - rename stuff to match changes in "clk: davinci: New driver for TI DA8XX USB
>    PHY clocks"
> - take advantage of syscon lookup changes in "mfd: syscon: Add syscon_register()
>    function"
> 
>   arch/arm/mach-davinci/usb-da8xx.c | 78 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c

...

> +/**
> + * da8xx_register_usb20_phy_clk - register USB0PHYCLKMUX clock
> + *
> + * @use_usb_refclkin: Selects the parent clock - either "usb_refclkin" if true
> + *	or "pll0_aux_clk" if false.
> + */

Should say "pll0_auxclk" instead of "pll0_aux_clk".
