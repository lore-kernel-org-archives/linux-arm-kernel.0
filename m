From: olof@lixom.net (Olof Johansson)
Date: Tue, 3 Oct 2017 18:07:30 -0700
Subject: [PATCH] ARM: defconfig: FRAMEBUFFER_CONSOLE can no longer be =m
In-Reply-To: <20170918154827.1654377-1-arnd@arndb.de>
References: <20170918154827.1654377-1-arnd@arndb.de>
Message-ID: <20171004010730.rnlweo4p4wko6e4h@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 05:47:50PM +0200, Arnd Bergmann wrote:
> It is no longer possible to load this at runtime, so let's
> change the few remaining users to have it built-in all
> the time.
> 
> arch/arm/configs/zeus_defconfig:115:warning: symbol value 'm' invalid for FRAMEBUFFER_CONSOLE
> arch/arm/configs/viper_defconfig:116:warning: symbol value 'm' invalid for FRAMEBUFFER_CONSOLE
> arch/arm/configs/pxa_defconfig:474:warning: symbol value 'm' invalid for FRAMEBUFFER_CONSOLE
> 
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Fixes: 6104c37094e7 ("fbcon: Make fbcon a built-time depency for fbdev")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to fixes.


-Olof
