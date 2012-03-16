From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Mar 2012 16:12:26 +0800
Subject: [PATCH v4 09/10] pwm: Add PXA support
In-Reply-To: <1331740593-10807-10-git-send-email-thierry.reding@avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-10-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20120316081222.GE7758@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2012 at 04:56:32PM +0100, Thierry Reding wrote:
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> Changes in v3:
>   - update PWM ops for changes in patch 2
> 
>  arch/arm/plat-pxa/Makefile |    1 -
>  arch/arm/plat-pxa/pwm.c    |  304 --------------------------------------------
>  drivers/pwm/Kconfig        |    9 ++
>  drivers/pwm/Makefile       |    1 +
>  drivers/pwm/pwm-pxa.c      |  244 +++++++++++++++++++++++++++++++++++
>  5 files changed, 254 insertions(+), 305 deletions(-)
>  delete mode 100644 arch/arm/plat-pxa/pwm.c
>  create mode 100644 drivers/pwm/pwm-pxa.c
> 
The patch should be generated with "git format-patch -M", so that we
can see the diff like below. 

--- a/arch/arm/plat-pxa/pwm.c
+++ b/drivers/pwm/pwm-pxa.c

-int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+static int pxa_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+                         int duty_ns, int period_ns)
 {
+       struct pxa_pwm_chip *pc = to_pxa_pwm_chip(chip);
        unsigned long long c;
        unsigned long period_cycles, prescale, pv, dc;
+       unsigned long offset;

-       if (pwm == NULL || period_ns == 0 || duty_ns > period_ns)
+       if (period_ns == 0 || duty_ns > period_ns)
                return -EINVAL;

Then I will have a question why "pwm == NULL" check is removed?

Regards,
Shawn
