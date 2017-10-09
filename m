From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 09 Oct 2017 15:22:50 +0800
Subject: [PATCH 0/2] Add a regmap to Allwinner R40 CCU to export GMAC
 register
In-Reply-To: <20171009071809.jte47cd2mt4iv6y7@flea.lan>
References: <20171006063333.12345-1-icenowy@aosc.io>
 <20171009071809.jte47cd2mt4iv6y7@flea.lan>
Message-ID: <14505033-D960-4287-92F2-554E2EDDFC59@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?10?9? GMT+08:00 ??3:18:09, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
>On Fri, Oct 06, 2017 at 06:33:31AM +0000, Icenowy Zheng wrote:
>> In the CCU of the Allwinner R40 SoC, there's a GMAC configuration
>register,
>> which is intended to be accessed by the dwmac-sun8i driver. On SoCs
>already
>> supported by the driver the register is placed in the syscon rather
>than
>> the CCU.
>> 
>> As CCU is a critical part of the SoC, so write to it should be
>strictly
>> limited. A regmap with restricted write permission is created by the
>R40
>> CCU driver, and can be get with dev_get_regmap. In order to tie the
>regmap
>> to the CCU device, the R40 CCU is now a platform driver, so a
>platform
>> device is created for it (and then tied with the regmap).
>> 
>> The first patch does the conversion of the driver to a platform
>driver,
>> and the second patch adds the regmap.
>
>I'd like to see first what you want to do with it.

Export the GMAC configuration register to dwmac-sun8i.

>
>Maxime
