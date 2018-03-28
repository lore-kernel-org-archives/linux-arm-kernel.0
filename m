From: s-anna@ti.com (Suman Anna)
Date: Wed, 28 Mar 2018 17:44:10 -0500
Subject: [PATCH v4 0/8] ARM: davinci: complete the conversion to using the
 reset framework
In-Reply-To: <44218403-5e7f-dd12-6d01-a52987fc4cc8@ti.com>
References: <20180323130455.11470-1-brgl@bgdev.pl>
 <152182378792.178046.3747112581117251857@swboyd.mtv.corp.google.com>
 <CAMRc=MfEebDk4D=t-ybRgbn+HaY7RUfOFCDAf9H8F3cZRchJmA@mail.gmail.com>
 <152182490783.178046.1191965992600877708@swboyd.mtv.corp.google.com>
 <CAMRc=MdmTAwPAAnL1+n+OXSycnyjuQ1hKmts158mPcgat1NUYQ@mail.gmail.com>
 <c78817f9-02fd-0ded-609e-5014efdd4a77@ti.com>
 <0683b11c-fefa-5fc7-793e-1a662a5f0480@ti.com>
 <44218403-5e7f-dd12-6d01-a52987fc4cc8@ti.com>
Message-ID: <5576cb08-6a95-53fb-e905-96371c3b8465@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2018 12:24 AM, Sekhar Nori wrote:
> Hi Suman,
> 
> On Tuesday 27 March 2018 06:12 AM, Suman Anna wrote:
>> I tried booting your tree [3] on the OMAPL138-LCDK board. I am using
>> NFS, and I am unable to get to the console. I don't have any issues
>> booting latest -next branch (next-20180326) which only has the reset and
>> clock driver related changes.
>>
>> Here's the log towards the end of the boot..
>> ---
>> pinctrl-single 1c14120.pinmux: 160 pins, size 80
>> Serial: 8250/16550 driver, 3 ports, IRQ sharing disabled
>> console [ttyS2] disabled
>> 1d0d000.serial: ttyS2 at MMIO 0x1d0d000 (irq = 61, base_baud = 8250000)
>> is a TI DA8xx/66AK2x
>> console [ttyS2] enabled
>> brd: module loaded
>> libphy: Fixed MDIO Bus: probed
>> davinci_mdio 1e24000.mdio: davinci mdio revision 1.5, bus freq 2200000
>> davinci_mdio 1e24000.mdio: no live phy, scanning all
>> davinci_mdio: probe of 1e24000.mdio failed with error -5
>> i2c /dev entries driver
>> <nothing after this>
> 
> This is because of a bug in bootloader PLL configuration which got
> uncovered only with CCF conversion. The bootloader that comes
> pre-flashed with the board or the latest U-Boot master should work fine.
> 
> Here is the log with latest U-Boot master:
> https://pastebin.ubuntu.com/p/HkwY9g4YDc/

Thanks Sekhar, able to boot and test after using the latest u-boot.

regards
Suman
