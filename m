From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 2 Apr 2015 12:16:58 +0200
Subject: [PATCH] ARM: dts: Use define for s3c-rtc clock id
In-Reply-To: <064c01d06b7f$aed30cf0$0c7926d0$@kernel.org>
References: <1427728889-29158-1-git-send-email-k.kozlowski@samsung.com>
 <551A1D27.6000301@samsung.com>
 <CABxcv=moU4xO=BNj6r4_O-VeL_OuAjCuoWiB9xsKWw9NjFTr9g@mail.gmail.com>
 <064c01d06b7f$aed30cf0$0c7926d0$@kernel.org>
Message-ID: <CAJKOXPf=aia+aeud-7V1YrDA1rhG3eyJrH_tcY-aEKTbVTTUGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-31 8:55 GMT+02:00 Kukjin Kim <kgene@kernel.org>:
> Javier Martinez Canillas wrote:
>>
>> On Tue, Mar 31, 2015 at 6:05 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> > Hi,
>> >
>> > On 03/31/2015 12:21 AM, Krzysztof Kozlowski wrote:
>> >> Use a define instead of raw number as a ID for "rtc_src" clock.
>> >>
>> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> >>
>> >> ---
>> >>
>> >> Patch depends on new file "dt-bindings/clock/samsung,s2mps11.h" from:
>> >> http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg43136.html
>> >> ---
>> >>  arch/arm/boot/dts/exynos3250-rinato.dts | 3 ++-
>> >>  1 file changed, 2 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
>> >> index 3905824cac58..d2cbc95364de 100644
>> >> --- a/arch/arm/boot/dts/exynos3250-rinato.dts
>> >> +++ b/arch/arm/boot/dts/exynos3250-rinato.dts
>> >> @@ -16,6 +16,7 @@
>> >>  #include "exynos3250.dtsi"
>> >>  #include <dt-bindings/input/input.h>
>> >>  #include <dt-bindings/gpio/gpio.h>
>> >> +#include <dt-bindings/clock/samsung,s2mps11.h>
>> >>
>> >>  / {
>> >>       model = "Samsung Rinato board";
>> >> @@ -605,7 +606,7 @@
>> >>  };
>> >>
>> >>  &rtc {
>> >> -     clocks = <&cmu CLK_RTC>, <&s2mps14_osc 0>;
>> >> +     clocks = <&cmu CLK_RTC>, <&s2mps14_osc S2MPS11_CLK_AP>;
>> >>       clock-names = "rtc", "rtc_src";
>> >>       status = "okay";
>> >>  };
>> >>
>> >
>> > Looks good to me.
>> >
>> > Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> >
>>
>> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>
> Thanks for you guys' review. Applied.

Thanks Kukjin! I forgot to do this also for exynos3250-monk board.
I'll send another patch for it but you may squash them if you want.

Best regards,
Krzysztof
