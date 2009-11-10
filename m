From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 10 Nov 2009 23:13:28 +0800
Subject: [PATCH 1/3] ezx: Add camera support for A780 and A910 EZX phones
In-Reply-To: <20091110134837.207bb92a.ospite@studenti.unina.it>
References: <1257266734-28673-1-git-send-email-ospite@studenti.unina.it>
	<1257266734-28673-2-git-send-email-ospite@studenti.unina.it>
	<f17812d70911032238i3ae6fa19g24720662b9079f24@mail.gmail.com>
	<20091110134837.207bb92a.ospite@studenti.unina.it>
Message-ID: <f17812d70911100713p3b51aac8k4e59c5df0b58a680@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2009 at 8:48 PM, Antonio Ospite
<ospite@studenti.unina.it> wrote:
> On Wed, 4 Nov 2009 14:38:40 +0800
> Eric Miao <eric.y.miao@gmail.com> wrote:
>
>> Hi Antonio,
>>
>> Patch looks generally OK except for the MFP/GPIO usage...
>
> Eric,
>
> while I was at it I also checked the original code Motorola released.
>
> It has:
> ? ? PGSR(GPIO_CAM_EN) |= GPIO_bit(GPIO_CAM_EN);
> ? ? PGSR(GPIO_CAM_RST)|= GPIO_bit(GPIO_CAM_RST);
>
> After checking PXA manual and arch/arm/mach-pxa/mfp-pxa2xx.c,
> I'd translate this to:
>
> diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
> index 77286a2..6a47a9d 100644
> --- a/arch/arm/mach-pxa/ezx.c
> +++ b/arch/arm/mach-pxa/ezx.c
> @@ -281,8 +281,8 @@ static unsigned long gen1_pin_config[] __initdata = {
> ? ? ? ?GPIO94_CIF_DD_5,
> ? ? ? ?GPIO17_CIF_DD_6,
> ? ? ? ?GPIO108_CIF_DD_7,
> - ? ? ? GPIO50_GPIO, ? ? ? ? ? ? ? ? ? ? ? ? ? ?/* CAM_EN */
> - ? ? ? GPIO19_GPIO, ? ? ? ? ? ? ? ? ? ? ? ? ? ?/* CAM_RST */
> + ? ? ? GPIO50_GPIO | MFP_LPM_DRIVE_HIGH, ? ? ? /* CAM_EN */
> + ? ? ? GPIO19_GPIO | MFP_LPM_DRIVE_HIGH, ? ? ? /* CAM_RST */
>
> ? ? ? ?/* EMU */
> ? ? ? ?GPIO120_GPIO, ? ? ? ? ? ? ? ? ? ? ? ? ? /* EMU_MUX1 */
> @@ -338,8 +338,8 @@ static unsigned long gen2_pin_config[] __initdata = {
> ? ? ? ?GPIO48_CIF_DD_5,
> ? ? ? ?GPIO93_CIF_DD_6,
> ? ? ? ?GPIO12_CIF_DD_7,
> - ? ? ? GPIO50_GPIO, ? ? ? ? ? ? ? ? ? ? ? ? ? ?/* CAM_EN */
> - ? ? ? GPIO28_GPIO, ? ? ? ? ? ? ? ? ? ? ? ? ? ?/* CAM_RST */
> + ? ? ? GPIO50_GPIO | MFP_LPM_DRIVE_HIGH, ? ? ? /* CAM_EN */
> + ? ? ? GPIO28_GPIO | MFP_LPM_DRIVE_HIGH, ? ? ? /* CAM_RST */
> ? ? ? ?GPIO17_GPIO, ? ? ? ? ? ? ? ? ? ? ? ? ? ?/* CAM_FLASH */
> ?};
> ?#endif
>
>
> Is that right?

That's right.

> I am putting also this into the next version I am going to send for
> submission, if you don't object.

No I won't, feel free to.
