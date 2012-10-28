From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 29 Oct 2012 01:45:01 +0300
Subject: [PATCH v2 1/5] ARM: PXA: Add z2-usb-switch driver
In-Reply-To: <201210282338.03505.marex@denx.de>
References: <CA+E=qVc1MGPQoWZWQAcv-NEh8WpLoqeTYLQz4iFjiOyfc9CX5w@mail.gmail.com>
 <201210282257.48770.marex@denx.de>
 <CA+E=qVdEPcBobVDODcyjZkbhZD6KXmGR7Fo5T40GRSPWNhujsQ@mail.gmail.com>
 <201210282338.03505.marex@denx.de>
Message-ID: <CA+E=qVccYJApm=zx7XvS5gbi0w3=HgKxRJQfXoStSMVhuVy9cQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 1:38 AM, Marek Vasut <marex@denx.de> wrote:
> Dear Vasily Khoruzhick,
>
>> On Mon, Oct 29, 2012 at 12:57 AM, Marek Vasut <marex@denx.de> wrote:
>> > Dear Vasily Khoruzhick,
>>
>> Dear Marek Vasut,
>>
>> >> This driver controls mode of USB port #2 pins - device or host.
>> >
>> > Please supply proper commit message. This short message describes
>> > nothing.
>>
>> OK, "This driver allows user to choose USB port #2 mode between device
>> and host" - that would be OK?
>
> Please describe why is this needed at all and what it does.

Because one might need USB device and USB host functionality provided
by USB port #2?
It switches pins mode from device to host and backwards.

> [...]
>
>> > I wonder if we have no better means to control enforcement of mode.
>>
>> Why? sysfs fits nicely.
>
> Because if there is already an API to implement this OTG in kernel, you should
> use that and not reinvent wheel.

One needs to select USB mode manually (btw, Z2 can't even power USB
device properly, only 3.3v or external 5v).
There's no way to determine what type of device (device/host)
connected to Z2 at the moment.

> [...]
>
> Best regards,
> Marek Vasut

Regards
Vasily
