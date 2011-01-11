From: rabin@rab.in (Rabin Vincent)
Date: Tue, 11 Jan 2011 21:38:07 +0530
Subject: [PATCH] ux500: Add Rohm BH1780GLI Light Sensor to i2c_board_info
In-Reply-To: <1294751426-3472-1-git-send-email-lee.jones@linaro.org>
References: <1294751426-3472-1-git-send-email-lee.jones@linaro.org>
Message-ID: <AANLkTimvS9rmrn86-veK3KwP31bqN7mzp2bEiwPEt_RR@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 18:40, Lee Jones <lee.jones@linaro.org> wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ?arch/arm/mach-ux500/board-mop500.c | ? 11 +++++++++++
> ?1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
> index 2635bb7..ff67408 100644
> --- a/arch/arm/mach-ux500/board-mop500.c
> +++ b/arch/arm/mach-ux500/board-mop500.c
> @@ -134,6 +134,15 @@ static struct i2c_board_info mop500_i2c0_devices[] = {
> ? ? ? ?},
> ?};
>
> +static struct i2c_board_info mop500_i2c2_devices[] = {
> +#if defined(CONFIG_SENSORS_BH1780)
> + ? ? ? {
> + ? ? ? ? ? ? ? /* Light sensor Rohm BH1780GLI */
> + ? ? ? ? ? ? ? I2C_BOARD_INFO("bh1780", 0x29),
> + ? ? ? },
> +#endif
> +};

You need to take care of the case where the driver is built as a module
(by adding a || defined(..._MODULE)).  It would actually be better if
you instead get rid of the ifdef entirely, since they get really ugly if
you add them for every device here.
