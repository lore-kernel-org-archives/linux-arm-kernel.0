From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Tue, 23 Sep 2014 21:58:14 +0800
Subject: [PATCH v2 4/4] ARM: dts: mt8135: Add pinctrl node for mt8135.
In-Reply-To: <2770365.r419rjIAOU@wuerfel>
References: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
 <1411443545-24951-5-git-send-email-srv_hongzhou.yang@mediatek.com>
 <2770365.r419rjIAOU@wuerfel>
Message-ID: <1411480694.21299.18.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 2014-09-23 at 15:03 +0200, Arnd Bergmann wrote: 
> On Tuesday 23 September 2014 11:39:05 Hongzhou. Yang wrote:
> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_GPIO0 (MT_PIN_NO(0) | 0)
> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_MSDC0_DAT7 (MT_PIN_NO(0) | 1)
> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_EINT49 (MT_PIN_NO(0) | 2)
> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_I2SOUT_DAT (MT_PIN_NO(0) | 3)
> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_DAC_DAT_OUT (MT_PIN_NO(0) | 4)
> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_PCM1_DO (MT_PIN_NO(0) | 5)
> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_SPI1_MO (MT_PIN_NO(0) | 6)
> > +#define MT8135_PIN_0_MSDC0_DAT7__FUNC_NALE (MT_PIN_NO(0) | 7)
> > +
> 
> This list looks like it just describes the hardware, I think it would
> be better to put the values directly into the DT, rather than
> using such macros.

Hi, 

Thanks for review. 
The intend for these macros is helpin pinctrl user to write DT node.
With these macro, we could write like this for i2c0:

mediatek,pinfunc = <MT8135_PIN_100_SDA0__FUNC_SDA0 
			MT8135_PIN_101_SCL0__FUNC_SCL0>;

We feel this is less error prone and easier to write than this:

mediatek,pinfunc = <MT_PIN_FUNC(100, 1) MT_PIN_FUNC(101, 1)>

Joe.C
