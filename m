From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 11 Jan 2017 21:55:48 +0100
Subject: [PATCHv3 3/5] pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
In-Reply-To: <CACRpkdaC+USN7YhZo49LAL9sorMxbTfhQbT5NrAu5D=Q1DHnnA@mail.gmail.com>
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
 <20170106041517.9589-1-chris.packham@alliedtelesis.co.nz>
 <20170106041517.9589-4-chris.packham@alliedtelesis.co.nz>
 <CACRpkdaC+USN7YhZo49LAL9sorMxbTfhQbT5NrAu5D=Q1DHnnA@mail.gmail.com>
Message-ID: <95cb4240-e77b-5eaa-1920-4d9e26028038@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2017 03:44 PM, Linus Walleij wrote:
> On Fri, Jan 6, 2017 at 5:15 AM, Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:
>
>> From: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
>>
>> This pinctrl driver supports the 98DX3236, 98DX3336 and 98DX4251 SoCs
>> from Marvell.
>>
>> Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>
> I am waiting for an ACK or comment from the maintainers on
> this patch. Sebastian?

Sorry for the ignorance.

I don't have the patch to reply to inline, but:

- In the driver MPP_MODE2, spi0 there is a typo "csk" instead of "sck".
- MPP_MODE5 binding "dev","bootcs" and driver "dev","bootcs0" differ.
- MPP_MODE6 binding "gpio" and driver "gpo" differ.
- MPP_MODE17 binding "dev","clk" and driver "dev","clkout" differ.
- MPP_MODE19 binding mentiones "dev","rb" but driver does not.
- MPP_MODE20 binding "gpio" and driver "gpo" differ.
- MPP_MODE20 binding "dev","we" and driver "dev","we0" differ.
- MPP_MODE21 through MPP_MODE30 binding "gpio" and driver "gpo" differ.
- remove spaces before "0,     0" in mv98dx3236_mpp_gpio_ranges.

Most of it is cosmetic stuff, so if you fix it feel free to add my

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Sebastian
