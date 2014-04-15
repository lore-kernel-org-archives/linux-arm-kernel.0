From: moore@free.fr (Chris Moore)
Date: Tue, 15 Apr 2014 04:59:39 +0200
Subject: [PATCH 24/29] ARM: orion5x: keep TODO list in edmini_v2 DT
In-Reply-To: <534BC3B7.2010603@gmail.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-25-git-send-email-thomas.petazzoni@free-electrons.com>
 <534BC3B7.2010603@gmail.com>
Message-ID: <534CA09B.7090602@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le 14/04/2014 13:17, Sebastian Hesselbarth a ?crit :
> On 04/13/2014 04:40 PM, Thomas Petazzoni wrote:
>> In preparation to the complete removal of non-DT support for
>> edmini_v2, this commit copies the TODO list of things to support from
>> the old-style board file into the Device Tree of edmini_v2.
>>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>   arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git 
>> a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts 
>> b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
>> index 44cc36a..ffa0fc5 100644
>> --- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
>> +++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
>> @@ -6,6 +6,13 @@
>>    * warranty of any kind, whether express or implied.
>>    */
>>
>> +/*
>> + * TODO: add Orion USB device port init when kernel.org support is 
>> added.
>
> I had a great time lately to look up usb phy init for all MVEBU SoCs.
> Expect barebox usb-phy code first, then later proper init for Linux,
> too.
>
>> + * TODO: add flash write support: see below.
>> + * TODO: add power-off support.
>> + * TODO: add I2C EEPROM support.
>
> Have you evaluated, what is blocking i2c eeprom?
>

 From memory:

I2C access from user space is no problem using the generic I2C driver.
I had I2C access from kernel space working in a personal branch but 
unfortunately my way of doing this was very messy.
I therefore never dared submit my version.

I also had power-off working but, to be persistent across a power 
outage, the edmini_v2 driver needs to modify a flag in the I2C EEPROM.
In fact the LaCie EDmini V2 never really powers-off, it starts a reboot 
then loops in U-Boot.
If this flag indicates a power-off state, U-Boot waits for the power-on 
button to be pressed before booting Linux.
This was actually the main reason for needing I2C access from kernel space.

If anyone can show me how to cleanly access the generic I2C driver from 
the edmini_v2 driver, I could try again.

Cheers,
Chris
