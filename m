From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 17 May 2011 21:21:55 +0800
Subject: [PATCH 1/4] arm: pxa3xx: cm-x300: fix V3020 RTC functionality
In-Reply-To: <1304941309-13288-1-git-send-email-grinberg@compulab.co.il>
References: <1304941309-13288-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <BANLkTikegYHGxWE3dzBXEsaAZ-ffottkZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 9, 2011 at 7:41 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> While in sleep mode the CS# and other V3020 RTC GPIOs must be driven
> high, otherwise V3020 RTC fails to keep the right time in sleep mode.
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Cc: stable at kernel.org

Applied.

> ---
> ?arch/arm/mach-pxa/cm-x300.c | ? ?8 ++++----
> ?1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
> index b2248e7..8a03487 100644
> --- a/arch/arm/mach-pxa/cm-x300.c
> +++ b/arch/arm/mach-pxa/cm-x300.c
> @@ -161,10 +161,10 @@ static mfp_cfg_t cm_x3xx_mfp_cfg[] __initdata = {
> ? ? ? ?GPIO99_GPIO, ? ? ? ? ? ? ? ? ? ?/* Ethernet IRQ */
>
> ? ? ? ?/* RTC GPIOs */
> - ? ? ? GPIO95_GPIO, ? ? ? ? ? ? ? ? ? ?/* RTC CS */
> - ? ? ? GPIO96_GPIO, ? ? ? ? ? ? ? ? ? ?/* RTC WR */
> - ? ? ? GPIO97_GPIO, ? ? ? ? ? ? ? ? ? ?/* RTC RD */
> - ? ? ? GPIO98_GPIO, ? ? ? ? ? ? ? ? ? ?/* RTC IO */
> + ? ? ? GPIO95_GPIO | MFP_LPM_DRIVE_HIGH, ? ? ? /* RTC CS */
> + ? ? ? GPIO96_GPIO | MFP_LPM_DRIVE_HIGH, ? ? ? /* RTC WR */
> + ? ? ? GPIO97_GPIO | MFP_LPM_DRIVE_HIGH, ? ? ? /* RTC RD */
> + ? ? ? GPIO98_GPIO, ? ? ? ? ? ? ? ? ? ? ? ? ? ?/* RTC IO */
>
> ? ? ? ?/* Standard I2C */
> ? ? ? ?GPIO21_I2C_SCL,
> --
> 1.7.3.4
>
>
