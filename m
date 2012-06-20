From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Jun 2012 21:30:17 +0200
Subject: [PATCH 07/15] i2c: Add Device Tree support to the Nomadik I2C
 driver
In-Reply-To: <1340197011-5435-8-git-send-email-lee.jones@linaro.org>
References: <1340197011-5435-1-git-send-email-lee.jones@linaro.org>
 <1340197011-5435-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbi7vmJE9LPmiu2NGM4b_SZ-Hi=a_xgrCOQX9ofKsLFew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 2:56 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we apply the bindings required for successful Device Tree
> probing of the i2c-nomadik driver. We also apply a fall-back
> configuration in case either one is not provided, or a required
> element is missing from the one supplied.
>
> Cc: linux-i2c at vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Pls Cc Srinidhi on these patches, and I would prefer to get his ACK on this.

Srinidhi, could you propose a patch to MAINTAINERS adding yourself as
explicit maintainer for this driver?

> +static struct nmk_i2c_controller u8500_i2c = {
> + ? ? ? /*
> + ? ? ? ?* Slave data setup time; 250ns, 100ns, and 10ns, which
> + ? ? ? ?* is 14, 6 and 2 respectively for a 48Mhz i2c clock.
> + ? ? ? ?*/
> + ? ? ? .slsu ? ? ? ? ? = 0xe,
> + ? ? ? .tft ? ? ? ? ? ?= 1, ? ? ?/* Tx FIFO threshold */
> + ? ? ? .rft ? ? ? ? ? ?= 8, ? ? ?/* Rx FIFO threshold */
> + ? ? ? .clk_freq ? ? ? = 100000, /* std. mode operation */

As per earlier discussion, change this default value to 400000.

> + ? ? ? .timeout ? ? ? ?= 200, ? ?/* Slave response timeout(ms) */
> + ? ? ? .sm ? ? ? ? ? ? = I2C_FREQ_MODE_FAST,
> +};

Thanks,
Lmims Walleij
