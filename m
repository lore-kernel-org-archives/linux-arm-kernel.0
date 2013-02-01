From: olof@lixom.net (Olof Johansson)
Date: Thu, 31 Jan 2013 19:46:42 -0800
Subject: [PATCHv2 for soc 1/4] arm: socfpga: Add new device tree source
 for actual socfpga HW
In-Reply-To: <1359651943-21752-2-git-send-email-dinguyen@altera.com>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-2-git-send-email-dinguyen@altera.com>
Message-ID: <20130201034642.GC4838@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 11:05:40AM -0600, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Up to this point, support for socfpga has only been on a virtual
> platform. Now that actual hardware is available, we add the appropriate
> device tree source files.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Tested-by: Pavel Machek <pavel@denx.de>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>

Are you planning on sending us a merge request, or do you want us to apply this
to a branch in arm-soc for you?

(Note comment below though)

> diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dts b/arch/arm/boot/dts/socfpga_cyclone5.dts
> index ab7e4a9..7ad3cc6 100644
> --- a/arch/arm/boot/dts/socfpga_cyclone5.dts
> +++ b/arch/arm/boot/dts/socfpga_cyclone5.dts
> @@ -20,7 +20,7 @@
>  
>  / {
>  	model = "Altera SOCFPGA Cyclone V";
> -	compatible = "altr,socfpga-cyclone5";
> +	compatible = "altr,socfpga-cyclone5", "altr,socfpga";
>  
>  	chosen {
>  		bootargs = "console=ttyS0,57600";

[...]

> diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
> new file mode 100644
> index 0000000..a0c6c65
> --- /dev/null
> +++ b/arch/arm/boot/dts/socfpga_vt.dts
[...]
> +
> +/ {
> +	model = "Altera SOCFPGA VT";
> +	compatible = "altr,socfpga-vt", "altr,socfpga";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,57600";
> +	};
> +
[...]
> diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
> index 6732924..198f491 100644
> --- a/arch/arm/mach-socfpga/socfpga.c
> +++ b/arch/arm/mach-socfpga/socfpga.c
> @@ -99,6 +99,7 @@ static void __init socfpga_cyclone5_init(void)
>  static const char *altera_dt_match[] = {
>  	"altr,socfpga",
>  	"altr,socfpga-cyclone5",
> +	"altr,socfpga-vt",
>  	NULL
>  };

Since you have altr,socfpga in the compatible for the new board, you don't need
to add an explicit check for the more specific one here. Same for cyclone5, you
should even be able to remove that.


-Olof
