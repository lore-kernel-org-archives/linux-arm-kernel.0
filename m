From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Oct 2015 11:53:40 +0200
Subject: [PATCH] staging/wilc: fix Kconfig dependencies, second try
In-Reply-To: <4253270.hGxaSY0VLA@wuerfel>
References: <5446980.8Rmykv9Tt3@wuerfel> <5624A1AF.8080607@atmel.com>
 <4253270.hGxaSY0VLA@wuerfel>
Message-ID: <4095810.4Q9e8Lc4je@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 October 2015 11:39:31 Arnd Bergmann wrote:
> On Monday 19 October 2015 16:54:23 Tony Cho wrote:
> > Hi Arnd Bergmann,
> > 
> > When I apply this patch, I cannot make WILC1000 module (wilc1000.ko) because CONFIG_WILC1000 is y and also I can see some link errors for the cfg80211 APIs.
> > 
> > Can you consider this patch?
> 
> Ah, you are right. I see the same thing now and don't know what caused me
> to send the patch in an incomplete state.
> 
> I hope this snippet is the last missing piece:
> 

No, that was not it either, I'll start over to think this through.

The real solution of course is to make it possible to load both the
SPI and MMC front-ends at the same time and have a common base driver,
which I might have to do, in order to clear myself of the shame of sending
not one but two incorrect fixes for this problem ;-)

	Arnd
