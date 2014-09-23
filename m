From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 16:10:09 +0200
Subject: [PATCH v2 4/4] ARM: dts: mt8135: Add pinctrl node for mt8135.
In-Reply-To: <1411480694.21299.18.camel@mtksdaap41>
References: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
 <2770365.r419rjIAOU@wuerfel> <1411480694.21299.18.camel@mtksdaap41>
Message-ID: <7840459.vtELiqVIOL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 21:58:14 Joe. C wrote:
> Thanks for review. 
> The intend for these macros is helpin pinctrl user to write DT node.
> With these macro, we could write like this for i2c0:
> 
> mediatek,pinfunc = <MT8135_PIN_100_SDA0__FUNC_SDA0 
>                         MT8135_PIN_101_SCL0__FUNC_SCL0>;
> 
> We feel this is less error prone and easier to write than this:
> 
> mediatek,pinfunc = <MT_PIN_FUNC(100, 1) MT_PIN_FUNC(101, 1)>

But you don't actually use the same macros in the driver, so in effect
you just move the definitions from the file they are needed in to another
file as a macro.

It is no less error prone to define those macros in mt8135-pinfunc.h
than in the pinctrl node, just less readable.

	Arnd
