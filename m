From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 20 Jul 2015 09:47:39 +0200
Subject: [RFC PATCH 01/15] pwm: add the pwm_is_enabled() helper
In-Reply-To: <1435738921-25027-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150720074738.GB29614@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 01, 2015 at 10:21:47AM +0200, Boris Brezillon wrote:
> Some PWM drivers are testing the PWMF_ENABLED flag. Create an helper
> function to hide the logic behind enabled test.
> This will allow us to smoothly move from the current approach to an atomic
> PWM update approach.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/core.c            |  4 ++--
>  drivers/pwm/pwm-atmel-tcb.c   |  2 +-
>  drivers/pwm/pwm-atmel.c       |  6 +++---
>  drivers/pwm/pwm-bcm-kona.c    |  4 ++--
>  drivers/pwm/pwm-ep93xx.c      |  4 ++--
>  drivers/pwm/pwm-imx.c         |  2 +-
>  drivers/pwm/pwm-mxs.c         |  4 ++--
>  drivers/pwm/pwm-renesas-tpu.c |  2 +-
>  drivers/pwm/pwm-tegra.c       |  6 +++---
>  drivers/pwm/pwm-tiecap.c      | 10 +++++-----
>  drivers/pwm/pwm-tiehrpwm.c    |  6 +++---
>  drivers/pwm/sysfs.c           |  2 +-
>  include/linux/pwm.h           |  5 +++++
>  13 files changed, 31 insertions(+), 26 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/31685259/attachment.sig>
