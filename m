From: arno@natisbad.org (Arnaud Ebalard)
Date: Mon, 15 Dec 2014 19:00:57 +0100
Subject: [PATCHv0 2/5] ARM: mvebu: ISL12057 rtc chip can be used to wake
 up RN102
In-Reply-To: <20141215135308.GB967@titan.lakedaemon.net> (Jason Cooper's
 message of "Mon, 15 Dec 2014 08:53:08 -0500")
References: <cover.1418519430.git.arno@natisbad.org>
 <b7208bdcd16dbc511d7ae6dd47aee91ab81f54f4.1418519430.git.arno@natisbad.org>
 <20141215135308.GB967@titan.lakedaemon.net>
Message-ID: <877fxskd2e.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Jason Cooper <jason@lakedaemon.net> writes:

> On Sun, Dec 14, 2014 at 02:42:28AM +0100, Arnaud Ebalard wrote:
>> 
>> Now that alarm support for ISL12057 chip is available, let's use a
>> feature of the driver dedicated to NETGEAR ReadyNAS 102 specific
>> routing of RTC IRQ#2 pin; on the device, this pin is not connected
>> to the SoC but to a PMIC, which allows the device to be powered
>> up when RTC alarm rings.
>> 
>> For that to work, the chip needs to be explicitly marked as a
>> device wakeup source using the "can-wakeup-machine" boolean
>> property. This makes 'wakealarm' sysfs entry available to
>> configure the alarm.
>> 
>> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
>> ---
>>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 1 +
>>  1 file changed, 1 insertion(+)
>
> Please group patches 2 - 4 into one patch.

Will do.

a+
