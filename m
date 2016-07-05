From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 5 Jul 2016 09:24:23 +0200
Subject: [linux-sunxi] Re: [PATCH 1/4] ARM: dts: sun5i: Enable otg on the
 auxtex t004
In-Reply-To: <20160705065431.GE7643@lukather>
References: <1467226022-10525-1-git-send-email-hdegoede@redhat.com>
 <20160629203838.GI6095@lukather>
 <dbce3f4a-dbd6-2ee6-292a-6dec71b99d63@redhat.com>
 <20160705065431.GE7643@lukather>
Message-ID: <8533f59e-00db-84b6-f3f6-e7169a7d1488@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05-07-16 08:54, Maxime Ripard wrote:
> On Thu, Jun 30, 2016 at 11:45:00AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 29-06-16 22:38, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Wed, Jun 29, 2016 at 08:46:59PM +0200, Hans de Goede wrote:
>>>> The auxtek t004 has its otg usb vbus hardwired to 5v (likely in case
>>>> people use it to power the board instead of the dedicated power micro
>>>> usb connector), it does have an id pin, so it allows full otg
>>>> functionality.
>>>
>>> I don't really get what you're saying here. Is the VBUS hardcoded to
>>> 5V, without any way to switch it, or it is not wired at all?
>>
>> It is hardwired to 5v, quoting from my commit msg
>> "has its otg usb vbus hardwired to 5v"
>>
>>> In the former case, how can one of the PMIC output be related to the
>>> board power input?
>>
>> I believe it is not wired to the pmic output, but to the pmic 5v input.
>
> Weird.

This is an a10s based hdmi stick, with a axp152 pmic, which does
not have separate ac-in / vbus-in and the matching ips out and
selection logic. So I guess that when using this pmic boards just
wire all the dcdc vin-s to 5v. As said this hdmi dongle has 2 micro-usb
connectors one for power only and one for otg. I believe that also
want to be able to power the dongle from just the otg (e.g. when
connected to a pc), at which point wiring its 5v to the 5v of
the micro-usb power connector aka THE 5v line is pretty much the
only thing they can do. Note this is all based on observation,
no schematics available.

> Ok, I just applied it.

Thanks.

Regards,

Hans
