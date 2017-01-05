From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 5 Jan 2017 14:34:10 +0530
Subject: [PATCH v2 4/4] ARM: dts: keystone: Add "ti, da830-uart" compatible
 string
In-Reply-To: <93c4aed0-6faa-2c27-7931-454fc1f48e79@oracle.com>
References: <1483561814-21953-1-git-send-email-david@lechnology.com>
 <1483561814-21953-5-git-send-email-david@lechnology.com>
 <93c4aed0-6faa-2c27-7931-454fc1f48e79@oracle.com>
Message-ID: <824238e0-b710-7146-b67b-b2135c2a8bd2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

On Thursday 05 January 2017 03:30 AM, Santosh Shilimkar wrote:
> On 1/4/2017 12:30 PM, David Lechner wrote:
>> The TI Keystone SoCs have extra UART registers beyond the standard 8250
>> registers, so we need a new compatible string to indicate this. Also, at
>> least one of these registers uses the full 32 bits, so we need to specify
>> reg-io-width in addition to reg-shift.
>>
>> "ns16550a" is left in the compatible specification since it does work as
>> long as the bootloader configures the SoC UART power management
>> registers.
>>
> NAK!!
> We can't break the booting boards with existing boot loaders.

Sorry, but it not clear to me how this breaks booting with older
bootloaders? If older DTB is ROM'ed, it will continue to work because of
match with ns16550a.

I just verified boot on K2E with these patches applied and using 2016.05
based U-Boot from a TI release.

http://pastebin.ubuntu.com/23744719/

> I suggest you to first get the driver updated to take care of
> the UART PM register and then enable the support for it.

Isn't that what patch 2/4 is doing?

Thanks,
Sekhar
