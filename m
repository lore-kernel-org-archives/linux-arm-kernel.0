From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Oct 2014 11:11:09 +0100
Subject: [PATCH 3/3] ARM: dts: mt8135: Add Reset Controller for MediaTek
 SoC
In-Reply-To: <1414659745.3069.2.camel@pengutronix.de>
References: <1414638733-10080-1-git-send-email-flora.fu@mediatek.com>
 <1414638733-10080-4-git-send-email-flora.fu@mediatek.com>
 <1414659745.3069.2.camel@pengutronix.de>
Message-ID: <2325869.W8YWKQm70A@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 October 2014 10:02:25 Philipp Zabel wrote:
> Since the reset controller driver accesses registers solely through the
> syscon regmap, I'd prefer to keep with the device tree control graph
> concept and make the reset-controller nodes children of the syscon
> nodes. I've brought this up before: https://lkml.org/lkml/2014/5/27/422,
> and I think this is another case where child node support for syscon
> makes sense:
> 
>         infracfg: syscon at 10001000 {
>                 compatible = "mediatek,mt8135-infracfg", "syscon";
>                 reg = <0 0x10001000 0 0x1000>;
>                 
>                 infrarst: reset-controller at 30 {
>                         #reset-cells = <1>;
>                         compatible = "mediatek,mt8135-infracfg-reset", "mediatek,reset";
>                         reg = <0x30 0x8>;
>                 };
>         };
> 

Yes, this looks much better to me too.

	Arnd
