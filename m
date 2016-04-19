From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 19 Apr 2016 17:18:33 -0400
Subject: [PATCH v1] ARM: dts: omap3-n900: Specify peripherals LDO
 regulators initial mode
In-Reply-To: <1460903363-2197-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <20160417122933.GA8093@earth>
 <1460903363-2197-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <CABxcv=kT5TM1dtK-GXH+XM-DtWpraReirootKSLddQPz4ft1EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ivaylo,

On Sun, Apr 17, 2016 at 10:29 AM, Ivaylo Dimitrov
<ivo.g.dimitrov.75@gmail.com> wrote:
> Without that, regulators are left in the mode last set by the bootloader or
> by the kernel the device was rebooted from. This leads to various problems,
> like non-working peripherals.
>
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> ---
>  arch/arm/boot/dts/omap3-n900.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index b3c26a9..d9e2d9c 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -329,6 +329,7 @@
>         regulator-name = "V28";
>         regulator-min-microvolt = <2800000>;
>         regulator-max-microvolt = <2800000>;
> +       regulator-initial-mode = <0x0e>; /* RES_STATE_ACTIVE */

As Sebastian said, it would be nice if instead of magic numbers +
comments, we have defines for the modes by moving the definitions from
include/linux/i2c/twl.h to include/dt-bindings/regulator/ so they can
be used by DTS.

But that can be done as a follow-up though, to avoid adding a
dependency between the regulator and arm-soc subsystems to get this
fix applied.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
Javier
