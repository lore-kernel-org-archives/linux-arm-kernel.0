From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2016 16:25:11 +0200
Subject: [PATCH 0/8] STMPE fixes/rework and add STMPE1600 support
In-Reply-To: <5716545D.9080006@wwwdotorg.org>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
 <5716545D.9080006@wwwdotorg.org>
Message-ID: <CACRpkdbsMqhXMa7Ug1k61bwXkH2Mfu-F+7bGORM9ivhbzfcxvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 5:53 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/19/2016 06:18 AM, patrice.chotard at st.com wrote:

>> For TEGRA ARCHITECTURE SUPPORT
>>         _ Stephen Warren <swarren@wwwdotorg.org>
>>         _ Thierry Reding <thierry.reding@gmail.com>
>>         _ Alexandre Courbot <gnurou@gmail.com>
>
> I don't know what STMPE is,

ST Microelectronics Multi-Purpose Expander.
Some GPIO and keypad and touchscreen, PWM and what
not.

> and I don't believe it is used on Tegra; what
> makes you think it is?

Probably this:

$ git grep stmpe arch/arm/boot/dts/

arch/arm/boot/dts/tegra30-apalis.dtsi:          stmpe811 at 41 {
arch/arm/boot/dts/tegra30-apalis.dtsi:                  compatible =
"st,stmpe811";
arch/arm/boot/dts/tegra30-apalis.dtsi:                  stmpe_touchscreen {
arch/arm/boot/dts/tegra30-apalis.dtsi:
compatible = "st,stmpe-ts";
arch/arm/boot/dts/tegra30-colibri.dtsi:         stmpe811 at 41 {
arch/arm/boot/dts/tegra30-colibri.dtsi:                 compatible =
"st,stmpe811";
arch/arm/boot/dts/tegra30-colibri.dtsi:                 stmpe_touchscreen {
arch/arm/boot/dts/tegra30-colibri.dtsi:
compatible = "st,stmpe-ts";

Yours,
Linus Walleij
