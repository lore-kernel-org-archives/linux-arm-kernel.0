From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Mon, 19 Nov 2012 11:36:57 +0000
Subject: [PATCH v2 1/4] mfd: tps65217: Set PMIC to shutdowm on PWR_EN
 toggle
In-Reply-To: <87a9udn9xo.fsf@dell.be.48ers.dk>
References: <1353067706-29491-1-git-send-email-anilkumar@ti.com>
 <1353067706-29491-2-git-send-email-anilkumar@ti.com>
 <87a9udn9xo.fsf@dell.be.48ers.dk>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA760FD@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 16:20:27, Peter Korsgaard wrote:
> >>>>> "AnilKumar" == AnilKumar Ch <anilkumar@ti.com> writes:
> 
> s/shutdowm/shutdown/ in the subject.

I will change

> 
>  AnilKumar> From: Colin Foe-Parker <colin.foeparker@logicpd.com>
>  AnilKumar> Set tps65217 PMIC status to OFF if power enable toggle is
>  AnilKumar> supported. Also adds platform data flag, which should be
>  AnilKumar> passed from board init data.
> 
> You're adding dt binding, not platform data.

I will change

> 
>  AnilKumar> Signed-off-by: Colin Foe-Parker <colin.foeparker@logicpd.com>
>  AnilKumar> [anilkumar at ti.com: move the additions to tps65217 MFD driver]
>  AnilKumar> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>  AnilKumar> ---
>  AnilKumar>  .../devicetree/bindings/regulator/tps65217.txt     |    4 ++++
>  AnilKumar>  drivers/mfd/tps65217.c                             |   12 ++++++++++++
>  AnilKumar>  2 files changed, 16 insertions(+)
> 
>  AnilKumar> diff --git a/Documentation/devicetree/bindings/regulator/tps65217.txt b/Documentation/devicetree/bindings/regulator/tps65217.txt
>  AnilKumar> index d316fb8..4f05d20 100644
>  AnilKumar> --- a/Documentation/devicetree/bindings/regulator/tps65217.txt
>  AnilKumar> +++ b/Documentation/devicetree/bindings/regulator/tps65217.txt
>  AnilKumar> @@ -11,6 +11,9 @@ Required properties:
>  AnilKumar>    using the standard binding for regulators found at
>  AnilKumar>    Documentation/devicetree/bindings/regulator/regulator.txt.
>  
>  AnilKumar> +Optional properties:
>  AnilKumar> +- ti,pmic-shutdown-controller: Telling the PMIC to shutdown on PWR_EN toggle.
> 
> Ehh, I don't know the tps65217 particular well, but according to the
> datasheet the REG_STATUS_OFF bit enables/disables the PB_IN pin, not
> PWR_EN. It's also not only about powering down but also powering up
> again.
> 
> I don't feel this property name is very clear. Perhaps something about
> power button or push button monitor as it is called in the datasheet?

Here I am writing "TPS65217_STATUS_OFF" to status register, BIT(7).
Description of this bit field: "OFF bit. Set this bit to 1 to enter OFF state
when PWR_EN pin is pulled low. Bit is automatically reset to 0."

PWR_EN pin pull-down is doing by RTC module.

Regards
AnilKumar
