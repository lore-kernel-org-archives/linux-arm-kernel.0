From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 21 Jun 2011 18:07:23 +0800
Subject: [PATCH 1/2] ARM: pxa910: correct nand pmu setting
In-Reply-To: <1308650059-27226-1-git-send-email-leiwen@marvell.com>
References: <1308650059-27226-1-git-send-email-leiwen@marvell.com>
Message-ID: <BANLkTi=NZXhzYSTvwC0Rmue9iXyb+e-8VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 5:54 PM, Lei Wen <leiwen@marvell.com> wrote:
> The original pair of <0x01db, 208000000> is invalid.
> Correct to the valid value.
>
> Signed-off-by: Lei Wen <leiwen@marvell.com>

Applied.

> ---
> ?arch/arm/mach-mmp/pxa910.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
> index 8f92ccd..1464607 100644
> --- a/arch/arm/mach-mmp/pxa910.c
> +++ b/arch/arm/mach-mmp/pxa910.c
> @@ -110,7 +110,7 @@ static APBC_CLK(pwm2, PXA910_PWM2, 1, 13000000);
> ?static APBC_CLK(pwm3, PXA910_PWM3, 1, 13000000);
> ?static APBC_CLK(pwm4, PXA910_PWM4, 1, 13000000);
>
> -static APMU_CLK(nand, NAND, 0x01db, 208000000);
> +static APMU_CLK(nand, NAND, 0x19b, 156000000);
> ?static APMU_CLK(u2o, USB, 0x1b, 480000000);
>
> ?/* device and clock bindings */
> --
> 1.7.0.4
>
>
