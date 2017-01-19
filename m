From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Jan 2017 10:08:41 +0100
Subject: [PATCH v8 4/8] PWM: add PWM driver for STM32 plaftorm
In-Reply-To: <1484749251-14445-5-git-send-email-benjamin.gaignard@st.com>
References: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
 <1484749251-14445-5-git-send-email-benjamin.gaignard@st.com>
Message-ID: <20170119090841.GB28834@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 03:20:47PM +0100, Benjamin Gaignard wrote:
> This driver adds support for PWM driver on STM32 platform.
> The SoC have multiple instances of the hardware IP and each
> of them could have small differences: number of channels,
> complementary output, auto reload register size...
> 
> version 8:
> - fix comments done by Thierry on version 7
> 
> version 6:
> - change st,breakinput parameter to make it usuable for stm32f7 too.
> 
> version 4:
> - detect at probe time hardware capabilities
> - fix comments done on v2 and v3
> - use PWM atomic ops
> 
> version 2:
> - only keep one comptatible
> - use DT parameters to discover hardware block configuration
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/pwm/Kconfig     |   9 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-stm32.c | 398 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 408 insertions(+)
>  create mode 100644 drivers/pwm/pwm-stm32.c

Similar nit than for 3/8. The canonical prefix for PWM subsystem patches
is "pwm: ". One other thing that I had missed earlier...

> +MODULE_ALIAS("platform: stm32-pwm");

I don't think there should be a space after ':'.

With those two fixed:

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170119/886f7f40/attachment-0001.sig>
