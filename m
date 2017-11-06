From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 06 Nov 2017 16:05:44 +0100
Subject: Possible bug in Armada-37xx pincontroller
In-Reply-To: <CABQZ+_Qy1ghA3_zMTHGjbfhwmfRNGaGRxUfsgUmayeOKxpEJvQ@mail.gmail.com>
 (Henrik Juul Pedersen's message of "Mon, 6 Nov 2017 15:12:31 +0100")
References: <CABQZ+_Qy1ghA3_zMTHGjbfhwmfRNGaGRxUfsgUmayeOKxpEJvQ@mail.gmail.com>
Message-ID: <87wp3378hj.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Henrik,

 On lun., nov. 06 2017, Henrik Juul Pedersen <hjp@liab.dk> wrote:

> Hi,
>
> After some review of a current Armada 37xx design, we stumbled upon
> some pin numbering, which seems doubly-defined, and doesn't seem to
> follow the documentation available to us.

Thanks for the report, indeed it seems to be a typo.

If you want to provide a patch for it then you will have to give a
proper commit log as well as your Signed-off-by.

Else I can take care of it.

Gregory

>
> We haven't gotten our hardware yet, so we haven't been able to test
> it, but the following patch is as we believe it should be defined.
>
> Best regards,
> Henrik Juul Pedersen
> LIAB ApS
>
> ---
>
> diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> index 71b944748304..e223fac20993 100644
> --- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> +++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> @@ -157,8 +157,8 @@ static struct armada_37xx_pin_group
> armada_37xx_nb_groups[] = {
>         PIN_GRP_GPIO("pwm1", 12, 1, BIT(4), "pwm"),
>         PIN_GRP_GPIO("pwm2", 13, 1, BIT(5), "pwm"),
>         PIN_GRP_GPIO("pwm3", 14, 1, BIT(6), "pwm"),
> -       PIN_GRP_GPIO("pmic1", 17, 1, BIT(7), "pmic"),
> -       PIN_GRP_GPIO("pmic0", 16, 1, BIT(8), "pmic"),
> +       PIN_GRP_GPIO("pmic1", 7, 1, BIT(7), "pmic"),
> +       PIN_GRP_GPIO("pmic0", 6, 1, BIT(8), "pmic"),
>         PIN_GRP_GPIO("i2c2", 2, 2, BIT(9), "i2c"),
>         PIN_GRP_GPIO("i2c1", 0, 2, BIT(10), "i2c"),
>         PIN_GRP_GPIO("spi_cs1", 17, 1, BIT(12), "spi"),
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
