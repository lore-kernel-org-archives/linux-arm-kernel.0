From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jul 2011 10:36:16 +0100
Subject: [PATCH 10/17] mach-ebsa110: retire custom LED code
In-Reply-To: <1309955687-19365-11-git-send-email-bryan.wu@canonical.com>
References: <1309955687-19365-1-git-send-email-bryan.wu@canonical.com>
	<1309955687-19365-11-git-send-email-bryan.wu@canonical.com>
Message-ID: <20110710093616.GW4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 08:34:40PM +0800, Bryan Wu wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 066009a..2a37079 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -350,6 +350,10 @@ config ARCH_EBSA110
>  	select ISA
>  	select NO_IOPORT
>  	select ARCH_USES_GETTIMEOFFSET
> +	select NEW_LEDS
> +	select LEDS_CLASS
> +	select LEDS_TRIGGERS
> +	select LEDS_TRIGGER_HEARTBEAT

Same comment about forcing.

> -static int __init leds_init(void)
> +static int __init ebsa110_leds_init(void)
>  {
> -	if (machine_is_ebsa110())
> -		leds_event = ebsa110_leds_event;
> +
> +	struct led_classdev *cdev;
> +	int ret;

Same comment about initialization.  This seems to be a common theme.

As a whole, this patch set seems to result in a net step backwards to
the goal of a single kernel image.
