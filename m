From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 May 2015 10:00:12 -0600
Subject: [PATCH] ARM: tegra: add "nor-jedec" flash compatible binding
In-Reply-To: <1431066098-19821-1-git-send-email-zajec5@gmail.com>
References: <1431066098-19821-1-git-send-email-zajec5@gmail.com>
Message-ID: <554CDD8C.7050000@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/08/2015 12:21 AM, Rafa? Mi?ecki wrote:
> Starting with commits
> 8ff16cf ("Documentation: devicetree: m25p80: add "nor-jedec" binding")
> 1103b85 ("mtd: m25p80: bind to "nor-jedec" ID, for auto-detection")
> we have "nor-jedec" binding indicating support for JEDEC identification.

The documentation looks quite incomplete. "nor-jedec" sounds like it's 
intended to be something generic. As such, it should be documented in 
e.g. Documentation/devicetree/bindings/mtd/nor-jedec.txt, not buried in 
one particular flash device's binding. If it's not intended to be 
generic, why isn't the existing "winbond,w25q32dw" enough?

Equally, "nor-jedec" doesn't sound like the right name. It doesn't 
differentiate between SPI and parallel NOR flash, which presumably need 
different compatible values, since the programming model is quite 
different, and the compatible value is supposed to define/imply the 
SW-visible programming model.
