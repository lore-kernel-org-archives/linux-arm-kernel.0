From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 27 Apr 2012 12:20:43 +0800
Subject: [PATCH] ARM: pxa: hx4700: Enable ASIC3 GPIO as a wakeup source
In-Reply-To: <1334607388.30492.1.camel@flow>
References: <1334105051.49438.YahooMailClassic@web29020.mail.ird.yahoo.com>
 <1334607388.30492.1.camel@flow>
Message-ID: <CAN1soZwjj7mrO1F+tGDgx+y+6OmAfrFis=xn1xVebPXCahFkeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 4:16 AM, Philipp Zabel <philipp.zabel@gmail.com> wrote:
> Am Mittwoch, den 11.04.2012, 01:44 +0100 schrieb Paul Parsons:
>> This patch enables the ASIC3 GPIO (12) as a wakeup source:
>> 1. Set the WAKEUP_ON_EDGE_RISE MFP config bits for GPIO12 in
>> hx4700_pin_config[].
>> 2. Call gpio_set_wake() for GPIO12.
>
> Acked-by: Philipp Zabel <philipp.zabel@gmail.com>
>
>

This patch enables the ASIC3 GPIO (12) as a wakeup source:=0A1. Set the WAK=
EUP_ON_EDGE_RISE MFP config bits for GPIO12 in=0Ahx4700_pin_config[].=0A2. =
Call gpio_set_wake() for GPIO12.=0A=0AWith GPIO12 thus enabled, the mfd/asi=
c3 driver can enable its own GPIOs=0Aas wakeup sources by implementing a ir=
q_set_wake() handler.=0A=0ASigned-off-by: Paul Parsons <lost.distance@yahoo=
.com>=0ACc: Philipp Zabel <philipp.zabel@gmail.com>=0A---=0A arch/arm/mach-=
pxa/hx4700.c |    3 ++-=0A 1 files changed, 2 insertions(+), 1 deletions(-)=
=0A=0Adiff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c=
=0Aindex de01277..00a00a9 100644=0A--- a/arch/arm/mach-pxa/hx4700.c=0A+++ b=
/arch/arm/mach-pxa/hx4700.c=0A@@ -129,7 +129,7 @@ static unsigned long hx47=
00_pin_config[] __initdata =3D {=0A =09GPIO88_GPIO,=0A =0A =09/* HX4700 spe=
cific input GPIOs */=0A-=09GPIO12_GPIO,=09/* ASIC3_IRQ */=0A+=09GPIO12_GPIO=
 | WAKEUP_ON_EDGE_RISE,=09/* ASIC3_IRQ */=0A =09GPIO13_GPIO,=09/* W3220_IRQ=
 */=0A =09GPIO14_GPIO,=09/* nWLAN_IRQ */=0A =0A@@ -863,6 +863,7 @@ static v=
oid __init hx4700_init(void)=0A =09int ret;=0A =0A =09pxa2xx_mfp_config(ARR=
AY_AND_SIZE(hx4700_pin_config));=0A+=09gpio_set_wake(GPIO12_HX4700_ASIC3_IR=
Q, 1);=0A =09ret =3D gpio_request_array(ARRAY_AND_SIZE(global_gpios));=0A =
=09if (ret)=0A =09=09pr_err ("hx4700: Failed to request GPIOs.\n");=0A-- =
=0A1.7.3.4=0A

Need to re-format this patch.

Regards
Haojian
