From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 24 Dec 2015 09:35:52 -0600
Subject: [PATCH 05/12] tty: amba-pl011: add register lookup table
In-Reply-To: <20151224150552.GF8644@n2100.arm.linux.org.uk>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
 <E1ZyNlS-0003jg-46@rmk-PC.arm.linux.org.uk>
 <20151224065437.GA18445@robwan01-pc.asiapac.arm.com>
 <CAOZdJXWmBYrjgC2GcY2NSeuJ2MAuwvtYVLP9AvTMkLUWsi9DhQ@mail.gmail.com>
 <20151224150552.GF8644@n2100.arm.linux.org.uk>
Message-ID: <CAOZdJXXdMHG7c9yDTo+oh7uNPCmH_Mc08s5YCoL3j--7uj5Mow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 24, 2015 at 9:05 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 24, 2015 at 09:03:12AM -0600, Timur Tabi wrote:
>> On Thu, Dec 24, 2015 at 12:54 AM, Huang Shijie <shijie.huang@arm.com> wrote:
>> > My kernel cmdline:
>> >   console=ttyAMA0,115200 earlycon=pl011,0x7ff80000 root=/dev/sda1 rootwait verbose debug sky2.mac_address=0x00,0x02,0xF7,0x00,0x63,0x3C dtb=r1a57.dtb
>>
>> earlycon is broken with Russell's patches.  My patch fixes it, but
>> only for standard pl011 devices.
>
> No, it shouldn't be.  Earlycon uses pl011_putc() which remains exactly
> the same as it was before these patches.

        while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)

is broken because REG_FR is equal to 1.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
