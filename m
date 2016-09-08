From: stefan@agner.ch (Stefan Agner)
Date: Thu, 08 Sep 2016 15:15:57 -0700
Subject: [PATCHv6 0/3] pwm: imx: support output polarity inversion
In-Reply-To: <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
References: <20141009151605.GA8818@ulmo.nvidia.com>
 <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <6c896634c4d6446df0388da2c0228232@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On 2014-10-10 07:22, Lothar Wa?mann wrote:
> This patch series adds support for polarity inversion to the pwm-imx
> driver. The patches have been tested on i.MX6, i.MX53 and with the
> ti-ehrpwm.c driver.

Do you know what prevented this patchset from getting merged?

We are looking for Polarity support in PWM for too, this is especially
useful for backlight control.

--
Stefan

> 
> Changes wrt. v2:
> - make the use of '#pwm-cells = <3>' optional, so that the change does
>   not break existing DT blobs as suggested by Arnd Bergmann and Sascha
>   Hauer.
> 
> Changes wrt. v3:
> - implemented the approach suggested by Sascha Hauer 
> - don't modify struct pwm_ops in the imx_pwm probe function
> 
> Changes wrt. v4:
> - rebased onto current linux-next
> - dropped cleanup patch which is not necessary any more
> - resent with ACK from Shawn Guo and Reviewed-By tag from Sascha Hauer
> 
> Changes wrt. v5:
> - don't remove of_pwm_n_cells to keep sanity checks for #pwm-cells as
>   suggested by Thierry Reding
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
