From: xiechao.mail@gmail.com (Chao Xie)
Date: Thu, 2 Aug 2012 15:24:44 +0800
Subject: [PATCH 2/5] clk: mmp: add clock definition for pxa168
In-Reply-To: <201207311154.42866.arnd@arndb.de>
References: <1343716792-10399-1-git-send-email-xiechao.mail@gmail.com>
 <1343716792-10399-2-git-send-email-xiechao.mail@gmail.com>
 <201207311154.42866.arnd@arndb.de>
Message-ID: <CADApbegvdRQ5swDrO-Y631K4AhsTigAG4=Mm82mT-smSA7XzJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 7:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 31 July 2012, Chao Xie wrote:
>> +#define APBC_RTC       APBC_REG(0x28)
>> +#define APBC_TWSI0     APBC_REG(0x2c)
>> +#define APBC_KPC       APBC_REG(0x30)
>> +#define APBC_UART0     APBC_REG(0x00)
>> +#define APBC_UART1     APBC_REG(0x04)
>> +#define APBC_GPIO      APBC_REG(0x08)
>> +#define APBC_PWM0      APBC_REG(0x0c)
>> +#define APBC_PWM1      APBC_REG(0x10)
>> +#define APBC_PWM2      APBC_REG(0x14)
>> +#define APBC_PWM3      APBC_REG(0x18)
>> +#define APBC_SSP0      APBC_REG(0x81c)
>> +#define APBC_SSP1      APBC_REG(0x820)
>> +#define APBC_SSP2      APBC_REG(0x84c)
>> +#define APBC_SSP3      APBC_REG(0x858)
>> +#define APBC_SSP4      APBC_REG(0x85c)
>> +#define APBC_TWSI1     APBC_REG(0x6c)
>> +#define APBC_UART2     APBC_REG(0x70)
>> +
>> +#define APMU_SDH0      APMU_REG(0x54)
>> +#define APMU_SDH1      APMU_REG(0x58)
>> +#define APMU_USB       APMU_REG(0x5c)
>> +#define APMU_DISP0     APMU_REG(0x4c)
>> +#define APMU_CCIC0     APMU_REG(0x50)
>> +#define APMU_DFC       APMU_REG(0x60)
>
> Same comment as for patch 1: get the address from the device tree and just
> define those macros to the offset, like:
>
> #define APBC_RTC       0x28
>
> apbc_clks[rtc_clk] = mmp_clk_register_apbc(rtc_clk, clk32k, APBC_RTC, 10, APBC_POWER_CTRL, mmp_clk_lock);
> clk_register_clkdev(apbc_clks[rtc_clk], NULL, "sa1100-rtc");
>
>         Arnd
>
hi
I would like to keep the mmp_clk_register_apbc to receive the "reg
base" not "reg offset".
It will be aligned with other kind of clock register APIs.
To read out APBC base register from device tree can be added at the
clock-pxa168.c, and it can map the registers and pass to the
mmp_clk_register_apbc.
Now, i have talked to Haojian who is doing device tree maintainer in
pxa/mmp. This kind of support is not added.
I suggest that after device tree support in clock can be added later
after other functionality of the clock framework is fine.
