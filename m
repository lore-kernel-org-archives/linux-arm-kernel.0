From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 31 Jul 2015 16:19:42 +0200
Subject: [linux-sunxi] [PATCH v2 1/3] ARM: dts: sun5i: Enable USB DRC on
 A10s OLinuxIno Micro
In-Reply-To: <CAOMqctQtyBkqfTwHTNfLo+DRg9JvgAUZ0spL_gzyVw_3bsDqaw@mail.gmail.com>
References: <1438347218-8158-1-git-send-email-hdegoede@redhat.com>
 <CAOMqctQtyBkqfTwHTNfLo+DRg9JvgAUZ0spL_gzyVw_3bsDqaw@mail.gmail.com>
Message-ID: <55BB83FE.2010207@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 31-07-15 16:13, Michal Suchanek wrote:
> Hello,
>
> On 31 July 2015 at 14:53, Hans de Goede <hdegoede@redhat.com> wrote:
>> Enable the otg/drc usb controller on the A10s OLinuxIno Micro.
>>
>> Note the A10s OlinuxIno Micro always has some voltage on its otg power
>> pin, even if the usb-vbus0-regulator is disabled, the leaked voltage is
>> enough to make vbus-det always report 1, so we do not use vbus-det on
>> this board.
>
> What board revision do you have?

Rev C.

> Also does this not go down when you connect a device which draws power?

No it does not, the leaked power is enough to fully power some
USB devices (but not others, where as making the Vbus enable pin
high results in enough power for all normal USB devices).

> It is useless for self-powered device detection, though :-s
>
> Still the Olinuxino is not battery powered normally so powering the
> bus at all times is probably ok.

We are note enabling the regulator there is simply some way for 5V
DC to get to the otg connector even with the regulator disabled.

Regards,

Hans
