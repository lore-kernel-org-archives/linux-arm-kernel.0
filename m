From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2016 16:52:26 +0200
Subject: [PATCH V2 4/4] ARM64 LPC: support earlycon for UART connected to
 LPC
In-Reply-To: <1473255233-154297-5-git-send-email-yuanzhichang@hisilicon.com>
References: <1473255233-154297-1-git-send-email-yuanzhichang@hisilicon.com>
 <1473255233-154297-5-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <4291379.IHAA72aKCk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 7, 2016 9:33:53 PM CEST Zhichang Yuan wrote:
> From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
> 
> This patch support the earlycon for UART connected to LPC on Hip06.
> This patch is depended on the LPC driver.
> 
> Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
> 

I'm skeptical about this too. Is this just needed because the 8250
earlycon support comes before the lpc bus initialization?

Could we start the LPC driver earlier to work around that?

	Arnd
