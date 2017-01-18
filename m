From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 18 Jan 2017 11:16:28 +0100
Subject: [PATCH v7 4/8] PWM: add PWM driver for STM32 plaftorm
In-Reply-To: <1483608344-9012-5-git-send-email-benjamin.gaignard@st.com>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-5-git-send-email-benjamin.gaignard@st.com>
Message-ID: <20170118101628.GG18989@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 10:25:40AM +0100, Benjamin Gaignard wrote:
[...]
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index f92dd41..88035c0 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -397,6 +397,15 @@ config PWM_STI
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-sti.
>  
> +config PWM_STM32
> +	tristate "STMicroelectronics STM32 PWM"
> +	depends on (ARCH_STM32 && OF && MFD_STM32_TIMERS) || COMPILE_TEST

One other thing: is the dependency on ARCH_STM32 and OF necessary here?
ARCH_STM32 and OF are both pulled in by MFD_STM32_TIMERS. The dependency
is probably fine for MFD_STM32_TIMERS, though even there && OF seems too
much, since it's already pulled in via ARCH_STM32 -> ARM_SINGLE_ARMV7M
-> USE_OF.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170118/f45a1318/attachment.sig>
