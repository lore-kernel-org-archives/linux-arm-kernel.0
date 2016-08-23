From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 23 Aug 2016 10:05:26 +0800
Subject: [PATCH 4/8] ARM: dts: sun8i: Add touchscreen node for
 sun8i-a23-gt90h
In-Reply-To: <cf0186a0-f4ea-173c-4f93-df8798941199@redhat.com>
References: <1470685398-14568-1-git-send-email-hdegoede@redhat.com>
 <1470685398-14568-4-git-send-email-hdegoede@redhat.com>
 <20160822183009.GX7104@lukather>
 <cf0186a0-f4ea-173c-4f93-df8798941199@redhat.com>
Message-ID: <106521471917926@web29g.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



23.08.2016, 03:08, "Hans de Goede" <hdegoede@redhat.com>:
> Hi,
>
> On 22-08-16 20:30, Maxime Ripard wrote:
>> ?On Mon, Aug 08, 2016 at 09:43:14PM +0200, Hans de Goede wrote:
>>> ?The gt90h tablet has a gsl3675 touchscreen, add a dt node describing it.
>>>
>>> ?Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ?---
>>> ??arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts | 8 ++++++++
>>> ??1 file changed, 8 insertions(+)
>>>
>>> ?diff --git a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
>>> ?index f27ebbb..da55b5a 100644
>>> ?--- a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
>>> ?+++ b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
>>> ?@@ -53,6 +53,14 @@
>>> ??????????status = "okay";
>>> ??};
>>>
>>> ?+&gsl1680 {
>>> ?+ compatible = "silead,gsl3675";
>>> ?+ touchscreen-fw-name = "silead/gsl3675-gt90h.fw";
>>
>> ?That's not documented anywhere, and looks really suspicious.
>
> Ugh, that should have been in:
>
> Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>
> But somehow it is not (I believe it was there in earlier revisions of
> the patch), I'll send a patch to fix this.
>
> About it being suspicious, this is not really firmware it is a bunch
> of configuration data / lookup tables for the controller which tell
> it in which order the touchscreen horizontal / vertical sensor
> lines are connected to its sense pins, and what values to send
> for finger x% between line z and line z+1, which differs per
> tablet model, since not all tablets use the same digitizer.

I do think it's a mixture of executable MCU codes and data.
The GSL1680 datasheet indicates that there's a 32-bit MCU in it.

>
> Regards,
>
> Hans
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
