From: balbi@ti.com (Felipe Balbi)
Date: Fri, 19 Aug 2011 00:57:16 +0300
Subject: [PATCH 4/5] ARM: davinci: da850, omapl138: share the
	davinci_uart_config
In-Reply-To: <69e35d4eac3c4a52d7896bc18c69b4578d1b15b3.1313702401.git.bengardiner@nanometrics.ca>
References: <cover.1313702401.git.bengardiner@nanometrics.ca>
	<69e35d4eac3c4a52d7896bc18c69b4578d1b15b3.1313702401.git.bengardiner@nanometrics.ca>
Message-ID: <20110818215715.GD21064@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 18, 2011 at 05:50:50PM -0400, Ben Gardiner wrote:
> diff --git a/arch/arm/mach-davinci/da850-reference.c b/arch/arm/mach-davinci/da850-reference.c
> index 25df6476..e4f5072 100644
> --- a/arch/arm/mach-davinci/da850-reference.c
> +++ b/arch/arm/mach-davinci/da850-reference.c
> @@ -20,3 +20,12 @@ int da850_reference_add_preferred_console(void)
>  {
>  	return add_preferred_console("ttyS", 2, "115200");
>  }
> +
> +static struct davinci_uart_config da850_reference_uart_config __initdata = {
> +	.enabled_uarts = 0x7,
> +};
> +
> +void da850_reference_serial_init(void)
> +{
> +	davinci_serial_init(&da850_reference_uart_config);
> +}

this looks like it could go to that da850_devices.c file (or whatever it
was called, sorry forgot the name)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110819/324ed3da/attachment.sig>
