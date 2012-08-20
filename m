From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Mon, 20 Aug 2012 18:21:16 +0200
Subject: i.MX27 SLCDC driver
In-Reply-To: <CAKGA1bmuUxiHbkF0n+bOx81EBQujuhu+piDsfHSVo2LejoPmcw@mail.gmail.com>
References: <502DEDCD.9050303@gmail.com>
 <CAKGA1bmuUxiHbkF0n+bOx81EBQujuhu+piDsfHSVo2LejoPmcw@mail.gmail.com>
Message-ID: <503263FC.8040901@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello
On 08/20/2012 05:21 PM, Matt Sealey wrote:
> On Fri, Aug 17, 2012 at 2:07 AM, Ga?tan Carlier <gcembed@gmail.com> wrote:
>> Hello,
>> I would like to write the driver for SmartLCD controller of i.MX27. This
>> kind of interface needs a LCD with an embedded graphic controller partially
>> controlled by GPIO. I want to link it with an OLED DD12832.
>>
>> How have I to write this driver : One driver for SLCDC and one driver for
>> DD12832 ? How to link them together ?
>>
>> Maybe use similar philosophy than soc-camera ?
>
> Please use DRM if you can. That way your SLCDC controller is a "crtc"
> and your OLED panel is a combination "encoder" and "connector". The
> DRM subsystem isn't by far the best solution since it is designed
> around PCI-class graphics cards and the split is intended for those
> and not for more tightly-knit LCDC+display combinations, but it does
> split things the way you're thinking and with a little extra code it
> will do exactly what you want if a little less efficient than your
> attached driver.
>
> I was sure Sascha had a driver for this already;
> http://git.pengutronix.de/?p=imx/linux-2.6.git;a=commit;h=c333f47fa185edfd1c9d889fc8af040dd557b02c
> - it should not be too hard to add your panel and the specific gpio
> control as an encoder/connector. Maybe with a user this can actually
> go upstream.
>
Thanks a lot for your advises. I will study this code.
Regards,
Ga?tan Carlier.
