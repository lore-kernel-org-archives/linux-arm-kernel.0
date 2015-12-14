From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Dec 2015 15:29:55 +0100
Subject: [PATCH 2/2 v2] ARM: mvebu: kirkwood: add PogoPlug series 4 device
 tree
In-Reply-To: <20151211143955.GG12282@lunn.ch>
References: <1449824224-29765-1-git-send-email-linus.walleij@linaro.org>
 <20151211143955.GG12282@lunn.ch>
Message-ID: <CACRpkdZmnnMYnhUcdib8y4M69VF1fExL4har2R8beUKYtMar=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 3:39 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Linus
>
>> +&uart0 {
>> +     status = "okay";
>> +     current-speed = <115200>;
>> +};
>
> You should not need this. There are no other DTS files with it.

git grep 'current-speed' arch/arm/boot/dts

arch/arm/boot/dts/k2l.dtsi:                     current-speed = <115200>;
arch/arm/boot/dts/k2l.dtsi:                     current-speed = <115200>;
arch/arm/boot/dts/keystone.dtsi:                        current-speed
= <115200>;
arch/arm/boot/dts/keystone.dtsi:                        current-speed
= <115200>;
arch/arm/boot/dts/omap-zoom-common.dtsi:                current-speed
= <115200>;
arch/arm/boot/dts/omap-zoom-common.dtsi:                current-speed
= <115200>;
arch/arm/boot/dts/omap-zoom-common.dtsi:                current-speed
= <115200>;
arch/arm/boot/dts/omap-zoom-common.dtsi:                current-speed
= <115200>;

> As far
> as i understand, the bootloader may add this to the DT blob before
> passing it to the kernel, but i doubt the stock bootloader on your
> device is doing it.

Sure I can drop it.

Yours,
Linus Walleij
