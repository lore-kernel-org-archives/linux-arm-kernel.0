From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 22 Oct 2013 21:13:54 +0200
Subject: [PATCH] ARM: mvebu: Add Netgear ReadyNAS 104 board
In-Reply-To: <52668F35.9050203@free-electrons.com> (Gregory CLEMENT's message
 of "Tue, 22 Oct 2013 15:44:05 +0100")
References: <87txgapcas.fsf@natisbad.org> <52668F35.9050203@free-electrons.com>
Message-ID: <8738ntqft9.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:

> On 21/10/2013 22:02, Arnaud Ebalard wrote:
>> 
>> Main hardware parts of the (Armada 370 based) NETGEAR ReadyNAS 104 are
>> supported by mainline kernel (USB 3.0 rear ports, USB 2.0 front port,
>> Gigabit controller and PHYs, serial port, LEDs, buttons, SATA ports,
>> G762 fan controller) and referenced in provided .dts file. Some additonal
>> work remains for:
>> 
>>  - Intersil ISL12057 I2C RTC and Alarm chip: working driver but needs
>>    to be splitted for submission of RTC part first;
>>  - Front LCD (Winstar 1602G): driver needs to be written
>>  - Armada NAND controller (to access onboard 128MB of NAND): support
>>    being pushed by @free-electrons people
>>  - 4 front SATA LEDs controlled via GPIO brought by NXP PCA9554:
>>    driver is available upstream. Not referenced/tested yet.
>> 
>> but the device is usable w/o those.
>> 
>> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
>> ---
>> Jason and Andrew,
>> 
>> I do not think there is any good way to share much between RN102 and
>> RN104 .dts in a common .dtsi file because MPP are used in a different
>> fashion on the two boards. But if you have ideas ...
>
> It seems to me that you can share at least half of the nodes in a common
> dtsi. But I prefer having two dts files, it remains easier to understand.
> Latter if a 3rd board share the same amount of nodes, then we can
> consider to use a dtsi.

Dully noted. AFAICT, NETGEAR only has 2 Armada 370 based devices at the
moment: the 2-bay RN102 and the 4-bay RN104. FWIW, the only other
ARM-based NAS in their portfolio is the ReadyNAS 2120 (Dual core Armada
XP @1.2GHz).

Cheers,

a+
