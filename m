From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Tue, 25 Feb 2014 08:54:22 +0100
Subject: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
In-Reply-To: <CABxcv=kKxidVJWcMrueB+edW=g_6gcucvi6=7p=EZ_WooCpbMA@mail.gmail.com>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>	<1393261669-32039-3-git-send-email-florian.vaussard@epfl.ch>	<20140224180336.GU27282@n2100.arm.linux.org.uk>
 <CABxcv=kKxidVJWcMrueB+edW=g_6gcucvi6=7p=EZ_WooCpbMA@mail.gmail.com>
Message-ID: <530C4C2E.8040606@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, Javier,

On 02/24/2014 09:22 PM, Javier Martinez Canillas wrote:
> Hi Russell,
> 
> On Mon, Feb 24, 2014 at 3:03 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Mon, Feb 24, 2014 at 06:07:49PM +0100, Florian Vaussard wrote:
>>> +     hdmi0: connector at 0 {
>>> +             compatible = "hdmi-connector";
>>
>> This looks way to generic a compatible string.  Are you sure it's
>> correct?
>>
> 
> That compatible string is correct according to the latest series
> posted by Tomi Valkeinen to add DT bindings for the OMAP Display
> SubSystem (DSS) [0].
> 

Indeed, this compatible string comes from the DSS series.

> The property is added on this patch [1] and as far as I understood the
> idea is that it could be a generic DT binding that can be used by
> platform specific HDMI connectors like the omap dss HDMI connector
> [2].
> 

On the other side, looking at
drivers/video/omap2/displays-new/connector-hdmi.c from the DSS series
[1], the compatible string is "omapdss,hdmi-connector", which makes me
wonder which one should be used :) BTW, "omapdss" seems a strange
prefix, isn't it?

Tomi, any inputs?

Regards,
Florian

[1]
https://git.kernel.org/cgit/linux/kernel/git/tomba/linux.git/tree/drivers/video/omap2/displays-new/connector-hdmi.c?h=work/dss-dt-review-3
