From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Apr 2014 19:41:20 +0200
Subject: [PATCH v3 1/3] pinctrl: Rename Broadcom Capri pinctrl driver
In-Reply-To: <20140410165626.GB23695@beef>
References: <1390509887-19278-1-git-send-email-syin@broadcom.com>
 <1396478439-16586-1-git-send-email-syin@broadcom.com>
 <1396478439-16586-2-git-send-email-syin@broadcom.com>
 <CACRpkdZ1Lt2JsMMWVMBgfS8ktkpeYzA3MiGmWB27Jwhw16UYYg@mail.gmail.com>
 <CACRpkdbY58J7GcQnYcUVTkfVO3VNCyJa0zVTKV4ibF8khxD8EA@mail.gmail.com>
 <20140410165626.GB23695@beef>
Message-ID: <CACRpkdZaMcSjy+-15y4kNsBgLZrThwxzJQr7SEy59AVm3yuM_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 6:56 PM, Matt Porter <matt.porter@linaro.org> wrote:
> On Thu, Apr 10, 2014 at 06:51:12PM +0200, Linus Walleij wrote:
>> On Thu, Apr 10, 2014 at 6:49 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> > On Thu, Apr 3, 2014 at 12:40 AM, Sherman Yin <syin@broadcom.com> wrote:
>> >
>> >> To be consistent with other Broadcom drivers, the Broadcom Capri pinctrl
>> >> driver and its related CONFIG option are renamed to bcm281xx.
>> >>
>> >> Devicetree compatible string and binding documentation use
>> >> "brcm,bcm11351-pinctrl" to match the machine binding here:
>> >> Documentation/devicetree/bindings/arm/bcm/bcm11351.txt
>> >>
>> >> This driver supports pinctrl on BCM11130, BCM11140, BCM11351, BCM28145
>> >> and BCM28155 SoCs.
>> >>
>> >> Signed-off-by: Sherman Yin <syin@broadcom.com>
>> >> Reviewed-by: Matt Porter <mporter@linaro.org>
>> >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>> >> ---
>> >>  drivers/pinctrl/Kconfig                            |    8 +-
>> >>  drivers/pinctrl/Makefile                           |    2 +-
>> >>  .../{pinctrl-capri.c => pinctrl-bcm281xx.c}        | 1519 ++++++++++----------
>> >
>> > This last version from apr 7 does not change
>> > arch/arm/configs/bcm_defconfig:CONFIG_PINCTRL_CAPRI=y
>> >
>> > Doesn't this mean that you render this platform without a pin
>> > control driver and thus broken?
>>
>> Bah I see that it's a separate patch now, sorry...
>>
>> Looking closer.
>
> I can take that one through mach-bcm for 3.16 to keep these changes
> in one place.

Nah I might as well take all of it through the pin control tree.
Can I have your ACK on the defconfig change?

Yours,
Linus Walleij
