From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Wed, 07 Dec 2016 12:58:16 -0500
Subject: [PATCH 3/3] pwm: lpc32xx: remove handling of PWM channels
In-Reply-To: <20161205014308.1741-2-vz@mleia.com>
References: <20161205014237.1689-1-vz@mleia.com>
 <20161205014308.1741-2-vz@mleia.com>
Message-ID: <1481133496.9248.3.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-12-05 at 03:43 +0200, Vladimir Zapolskiy wrote:
> Because LPC32xx PWM controllers have single output which is registered as
> the only PWM device/channel per controller, it is known in advance that
> pwm->hwpwm value is always 0. On basis of this fact simplify the code
> by removing operations with pwm->hwpwm, there is no controls which require
> channel number as input.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  drivers/pwm/pwm-lpc32xx.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
Reviewed-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
