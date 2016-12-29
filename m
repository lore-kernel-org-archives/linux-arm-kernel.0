From: lilja.magnus@gmail.com (Magnus Lilja)
Date: Thu, 29 Dec 2016 19:41:47 +0100
Subject: [PATCH 4/6] ARM: mach-mx35_3ds: Remove camera support
In-Reply-To: <1482756987-12414-4-git-send-email-festevam@gmail.com>
References: <1482756987-12414-1-git-send-email-festevam@gmail.com>
 <1482756987-12414-4-git-send-email-festevam@gmail.com>
Message-ID: <CAM=E1R64X6o0o604gGiU4+uQ6W_PUSbzgpaAYWSYEiSz_D8uGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 26 December 2016 at 13:56, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> Since commit c93cc61475ebbe6e66 ("[media] staging/media: remove deprecated
> mx3 driver") the mx3 camera driver has been removed, so remove the camera
> support from the board file as well.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/mach-imx/mach-mx35_3ds.c | 88 ---------------------------------------
>  1 file changed, 88 deletions(-)
>
> diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
> index c8c2e09..64fc161 100644
> --- a/arch/arm/mach-imx/mach-mx35_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx35_3ds.c

...
> @@ -321,10 +260,6 @@ static struct regulator_consumer_supply vcam_consumers[] = {
>         REGULATOR_SUPPLY("VDDA", "0-000a"),
>  };
>
> -static struct regulator_consumer_supply vaudio_consumers[] = {
> -       REGULATOR_SUPPLY("cmos_vio", "soc-camera-pdrv.0"),
> -};
> -
>  static struct regulator_init_data sw1_init = {
>         .constraints = {
>                 .name = "SW1",
> @@ -405,18 +340,6 @@ static struct regulator_init_data vvideo_init = {
>         }
>  };
>
> -static struct regulator_init_data vaudio_init = {
> -       .constraints = {
> -               .name = "VAUDIO",
> -               .min_uV = 2300000,
> -               .max_uV = 3000000,
> -               .valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> -               .boot_on = 1
> -       },
> -       .num_consumer_supplies = ARRAY_SIZE(vaudio_consumers),
> -       .consumer_supplies = vaudio_consumers,
> -};
> -
>  static struct regulator_init_data vcam_init = {
>         .constraints = {
>                 .name = "VCAM",
> @@ -460,7 +383,6 @@ static struct mc13xxx_regulator_init_data mx35_3ds_regulators[] = {
>         { .id = MC13892_VDIG, .init_data = &vdig_init },
>         { .id = MC13892_VUSB2, .init_data = &vusb2_init },
>         { .id = MC13892_VVIDEO, .init_data = &vvideo_init },
> -       { .id = MC13892_VAUDIO, .init_data = &vaudio_init },
>         { .id = MC13892_VCAM, .init_data = &vcam_init },

Umm, did you really mean to remove VAUDIO/vaudio_init stuff in this
camera related patch?

Regards, Magnus
