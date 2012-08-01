From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Aug 2012 13:32:01 +0000
Subject: [PATCH 5/6] ARM: ux500: Ensure probing of Audio devices when
 Device Tree is enabled
In-Reply-To: <5018DBEE.9090203@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <201207312054.13818.arnd@arndb.de> <5018DBEE.9090203@linaro.org>
Message-ID: <201208011332.02500.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 August 2012, Lee Jones wrote:
> > Looks like you're adding the same call to each of the three cases:
> > mop500, snowball and hrefv60+. How about moving it before or after
> > the if/elseif block?
> 
> The Snowball one is different 'mop500_msp_init' -> 'mop500_of_msp_init'.

Ah, I see. Is there a problem in always using mop500_of_msp_init then?
I would guess that this just means you'd have to put the msp into the
device tree files, which don't yet exist for mop500 and hrefv60.

	Arnd
