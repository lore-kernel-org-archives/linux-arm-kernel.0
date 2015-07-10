From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 10 Jul 2015 09:17:39 +0200
Subject: musb-hdrc: "Vbus off, timeout 1100 msec" message does not belong
 in sysfs
In-Reply-To: <20150709214610.GA20890@amd>
References: <20150709213922.GA32698@amd> <20150709214610.GA20890@amd>
Message-ID: <559F7193.7090508@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2015 11:46 PM, Pavel Machek wrote:
> On Thu 2015-07-09 23:39:22, Pavel Machek wrote:
>> Hi!

Hi,

>>
>> sysfs should contain one value per file. This one has at least two,
>> with nice english sentence as a bonus.
>>
>> root at n900:/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto#
>> cat vbus
>> Vbus off, timeout 1100 msec
>>
>> :-(.
> 
> Plus, documentation for this is nowhere to be seen:
> 
> pavel at amd:/data/l/linux-n900$ grep -ri musb Documentation/ABI/
> pavel at amd:/data/l/linux-n900$

that is a shame indeed. It is part of the driver since TUSB support was
merged via commit 550a7375f ("USB: Add MUSB and TUSB support") about 7
years ago.
The parameter expects the timeout values which is used to poll the port
for mode changes (host/device mode) since it can not be detected on its
own.
Felipe knows best if it is better to document it or remove it. I can't
remember that I needed it on am335x.

> 									Pavel
> 
Sebastian
