From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 23 Jun 2016 19:51:12 +0200
Subject: [RESEND PATCH v2 0/5] ir-rx51 driver fixes
In-Reply-To: <1466623341-30130-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1466623341-30130-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <201606231951.12788@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 June 2016 21:22:16 Ivaylo Dimitrov wrote:
> ir-rx51 is a driver for Nokia N900 IR transmitter. The current series
> fixes the remaining problems in the driver:
> 
>  - replace GP timer 9 with PWM framework usage
>  - replace pulse width timer dmtimer usage with hrtimer
>  - add DT support to the driver
>  - add driver to the board DTS
> 
> Patch 2 is needed so the driver to function correctly, without it PWM
> refuses to set the needed carrier frequency.
> 
> Changes compared to v1:
>  - removed [PATCH 5/7] ARM: OMAP: dmtimer: Do not call PM runtime
>    functions when not needed.
>  - DT compatible string changed to "nokia,n900-ir"
> 
> Ivaylo Dimitrov (5):
>   ir-rx51: Fix build after multiarch changes broke it
>   pwm: omap-dmtimer: Allow for setting dmtimer clock source
>   ir-rx51: use PWM framework instead of OMAP dmtimer
>   ir-rx51: add DT support to driver
>   ir-rx51: use hrtimer instead of dmtimer
> 
>  .../devicetree/bindings/media/nokia,n900-ir        |  20 ++
>  .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   |   4 +
>  arch/arm/mach-omap2/board-rx51-peripherals.c       |   5 -
>  arch/arm/mach-omap2/pdata-quirks.c                 |  10 +-
>  drivers/media/rc/Kconfig                           |   2 +-
>  drivers/media/rc/ir-rx51.c                         | 229
> +++++++-------------- drivers/pwm/pwm-omap-dmtimer.c                
>     |  12 +- include/linux/platform_data/media/ir-rx51.h        |  
> 3 -
>  8 files changed, 111 insertions(+), 174 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/media/nokia,n900-ir

Looks good, you can add my Acked-by.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160623/8b4ef065/attachment-0001.sig>
