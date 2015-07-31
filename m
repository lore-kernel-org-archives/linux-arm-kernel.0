From: hramrach@gmail.com (Michal Suchanek)
Date: Fri, 31 Jul 2015 16:13:24 +0200
Subject: [linux-sunxi] [PATCH v2 1/3] ARM: dts: sun5i: Enable USB DRC on
 A10s OLinuxIno Micro
In-Reply-To: <1438347218-8158-1-git-send-email-hdegoede@redhat.com>
References: <1438347218-8158-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAOMqctQtyBkqfTwHTNfLo+DRg9JvgAUZ0spL_gzyVw_3bsDqaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 31 July 2015 at 14:53, Hans de Goede <hdegoede@redhat.com> wrote:
> Enable the otg/drc usb controller on the A10s OLinuxIno Micro.
>
> Note the A10s OlinuxIno Micro always has some voltage on its otg power
> pin, even if the usb-vbus0-regulator is disabled, the leaked voltage is
> enough to make vbus-det always report 1, so we do not use vbus-det on
> this board.

What board revision do you have?

Also does this not go down when you connect a device which draws power?

It is useless for self-powered device detection, though :-s

Still the Olinuxino is not battery powered normally so powering the
bus at all times is probably ok.

Thanks

Michal
