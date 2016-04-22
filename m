From: huangtao@rock-chips.com (Huang, Tao)
Date: Fri, 22 Apr 2016 12:23:06 +0800
Subject: [PATCH] ARM64: dts: rockchip: add core dtsi file for RK3399 SoCs
In-Reply-To: <CAD=FV=X9S4z2WLEJ-KaaCZxfkdO4+-i2hUd3dsYJi5qXEvpVBQ@mail.gmail.com>
References: <1461122150-9042-1-git-send-email-jay.xu@rock-chips.com>
 <1461211092-26331-1-git-send-email-jay.xu@rock-chips.com>
 <3937420.4aN2rRBlcO@diego>
 <CAD=FV=X9S4z2WLEJ-KaaCZxfkdO4+-i2hUd3dsYJi5qXEvpVBQ@mail.gmail.com>
Message-ID: <5719A72A.4070603@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Doug:
On 2016?04?22? 06:38, Doug Anderson wrote:
>
>>> +     i2c1: i2c at ff110000 {
>>> +             compatible = "rockchip,rk3399-i2c";
>> David respun the rk3399 i2c-support on tuesday, so this and the others below
>> are waiting on Wolfram to take a look.
> I think it can work with the rk3288-i2c as a fallback, at least for
> low speed stuff, right?  Should this be:
>
> compatible = "rockchip,rk3399-i2c", "rockchip,rk3288-i2c"
>
> Looks like that was done for rk3368.
No. For RK3399 I2C controller:
The I2C controller uses the APB clock/clk_i2c as the working clock. The
APB clock will determine the I2C bus clock, clk_i2c is the function clk,
up to 200MHz.
Chips such as RK3288/3368 only uses APB clock. So old driver do not work
on RK3399.

Thanks,
Huang, Tao
