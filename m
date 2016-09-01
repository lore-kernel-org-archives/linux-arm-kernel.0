From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 01 Sep 2016 13:17:13 +0200
Subject: [PATCH 5/6] ARM: dts: s3c2416: Use macros for pinctrl
 configuration
In-Reply-To: <e37fbfa0-f30c-ab34-3428-fb9a66182089@samsung.com>
References: <1472721715-2833-1-git-send-email-k.kozlowski@samsung.com>
 <1608454.1ZuTJsprje@amdc1976>
 <e37fbfa0-f30c-ab34-3428-fb9a66182089@samsung.com>
Message-ID: <5137342.oSWmFr9Y8D@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 1, 2016 1:12:18 PM CEST Krzysztof Kozlowski wrote:
> > 
> > Shouldn't macros that are also used by s3c* be named as
> > SAMSUNG_PIN_FUNC_2 etc. (s3c* SoCs are not Exynos)?
> 
> Right, this is the inconsistency. The problem with "samsung" prefix is
> that there is no guarantee it will be like that for newer SoCs. How
> about one of:
> 1. using the oldest prefix (S3C24XX in this case),
> 2. duplicating them per SoC family (so S3C24XX, S3C64XX, EXYNOS).
> ?

I'd suggest living with the inconsistency and using EXYNOS as the prefix,
as that is the most common one these days, even if the other ones
predate it.

	Arnd
