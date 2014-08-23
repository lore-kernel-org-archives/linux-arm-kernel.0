From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 23 Aug 2014 10:56:37 -0300
Subject: [PATCH 6/6] ARM: dts: hummingboard: gpio-ir on gpio 3,5
In-Reply-To: <20140823133649.GP30401@n2100.arm.linux.org.uk>
References: <20140823091058.GO30401@n2100.arm.linux.org.uk>
 <E1XL7MR-0002yX-6N@rmk-PC.arm.linux.org.uk>
 <CAOMZO5C=xyYLLBX1PDsJQ9NwzXZxCWTvPMTUWzYcoohOOvA_qA@mail.gmail.com>
 <20140823133649.GP30401@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5DrtrEJxmCZSO6RVZom8kzZhu2dikntRwYZeq5j_QZ9sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 23, 2014 at 10:36 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Aug 23, 2014 at 10:32:23AM -0300, Fabio Estevam wrote:
>> On Sat, Aug 23, 2014 at 6:11 AM, Russell King
>> <rmk+kernel@arm.linux.org.uk> wrote:
>>
>> > -                               MX6QDL_PAD_GPIO_2__GPIO1_IO02 0x80000000
>> > +                               MX6QDL_PAD_EIM_DA5__GPIO3_IO05 0x80000000
>>
>> It would be better to replace the '0x80000000' with the real iomux
>> value (like 0x1b0b0 for example), so that we do not need to rely on
>> the bootloader doing the correct configuration for us.
>
> I'd just end up choosing something which appears to work - I've no idea
> at present what an appropriate value should be here.

In the working system, you could read the register:

IOMUXC_SW_PAD_CTL_PAD_EIM_AD05 (address: 0x20E043C)

Most likely it will return the default value of 0xb0b1 if the
bootloader has not re-configured it.

,and then put this read value into the device tree. This way we
guarantee that the kernel will have this pin correctly configured,
without depending on the bootloader.
