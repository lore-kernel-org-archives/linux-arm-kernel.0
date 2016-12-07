From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed, 07 Dec 2016 12:57:31 -0500
Subject: [PATCH 2/3] pwm: lpc32xx: switch driver to one phandle
 argument for PWM consumers
In-Reply-To: <20161205014308.1741-1-vz@mleia.com>
References: <20161205014237.1689-1-vz@mleia.com>
 <20161205014308.1741-1-vz@mleia.com>
Message-ID: <1481133451.9248.2.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-12-05 at 03:43 +0200, Vladimir Zapolskiy wrote:
> NXP LPC32xx SoCs have two simple independent PWM controllers with a single
> output each, in this case there is no need to specify PWM channel argument
> on client side, one cell for setting PWM output frequency is sufficient.
> 
> The change adds private of_xlate() handling of a single cell value given
> with a PWM phandle on client side, the handling is taken from the PXA PWM
> driver.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  drivers/pwm/pwm-lpc32xx.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
Reviewed-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
