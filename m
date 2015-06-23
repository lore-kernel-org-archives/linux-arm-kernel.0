From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 23 Jun 2015 10:19:10 +0200
Subject: [linux-sunxi] [PATCH 1/4] ARM: dts: sunxi: Add regulator-boot-on
 to usb host port regulator nodes
In-Reply-To: <20150623071646.GL2266@lukather>
References: <1434814810-26285-1-git-send-email-hdegoede@redhat.com>
 <1434814810-26285-2-git-send-email-hdegoede@redhat.com>
 <CAGRGNgU7179K408=PekziP9ZzzG7+rvhm=e7TWjZk1UhkAnVZQ@mail.gmail.com>
 <5587C720.9040007@redhat.com> <20150623071646.GL2266@lukather>
Message-ID: <5589167E.4020905@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23-06-15 09:16, Maxime Ripard wrote:
> On Mon, Jun 22, 2015 at 10:28:16AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 22-06-15 02:30, Julian Calaby wrote:
>>> Hi Hans,
>>>
>>> On Sun, Jun 21, 2015 at 1:40 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> u-boot will have turned on the power to the usb host ports, so mark them
>>>> as regulator-boot-on, this stops the power on the ports from temporarily
>>>> getting turned off during boot, causing issues with e.g. usb powered
>>>> harddisks.
>>>
>>> Stupid question: shouldn't u-boot set this property?
>>
>> We could make u-boot set this property but that will require a lot of code on
>> u-boot's side which is simply not there atm. And traditionally this property
>> is is simply a part of the dts files as shipped with the kernel.
>
> What happens if the property is set but the regulator is not actually
> enabled?

Then its gets enabled when the regulator loads, so assuming that the usb driver
is enabled in the kernel config 0.5 (built-in) - 3 (module) seconds earlier then
it otherwise would.

This is not a problem since usb-ports are normally always powered anyways, the only
reason they can be turned off on embedded systems like sunxi is for powersaving
during suspend (which actually goes against the usb spec, but usually works so
most tablets / laptops do this).

Regards,

Hans
