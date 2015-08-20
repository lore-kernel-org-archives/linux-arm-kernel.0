From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 20 Aug 2015 09:36:33 +0200
Subject: [linux-sunxi] Re: [PATCH 4/6] ARM: dts: sun7i: Enable USB DRC on
 pcDuino 3
In-Reply-To: <20150820064545.GM30520@lukather>
References: <1439563477-12295-1-git-send-email-hdegoede@redhat.com>
 <1439563477-12295-5-git-send-email-hdegoede@redhat.com>
 <20150820064545.GM30520@lukather>
Message-ID: <55D58381.7040801@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/20/2015 08:45 AM, Maxime Ripard wrote:
> On Fri, Aug 14, 2015 at 04:44:35PM +0200, Hans de Goede wrote:
>> From: Jelle van der Waa <jelle@vdwaa.nl>
>>
>> Enable the otg/drc usb controller on the pcDuino 3.
>>
>> Note this board has the otg-vbus connected directly to the 5v-dcc of
>> the board, so there is no vbus0 regulator, nor vbus0-det.
>
> Can it do OTG then?

Yes.

> If VBUS is tied to the 5v, there's no way for the
> board to shut it down when acting as peripheral, right?

Correct, the idea is to power it over otg when using it
as a peripheral, or at least power it from a usb port of
the machine for which it is a peripheral. Note that the
original cubieboard (both A10 and A20 versions) have the
same issue.

Regards,

Hans
