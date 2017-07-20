From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 20 Jul 2017 21:30:38 +0200
Subject: [PATCH 10/12] [v2] ARM: s3c24xx: make H1940BT depend on RFKILL
In-Reply-To: <20170720155410.3251043-1-arnd@arndb.de>
References: <20170720154616.3250481-1-arnd@arndb.de>
 <20170720155410.3251043-1-arnd@arndb.de>
Message-ID: <20170720193038.GA16488@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 05:53:43PM +0200, Arnd Bergmann wrote:
> Bluetooth is only supported when network support is part of the kernel,
> so it is a bit pointless to build the hi1940-bt support without networking.
> If we try anyway, we get a Kconfig warning:
> 
> warning: (TOSA_BT && H1940BT) selects RFKILL which has unmet direct dependencies (NET)
> 
> This turns the 'select' into 'depends on' as Krzysztof suggested when
> I first sent a fix.
> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Link: https://patchwork.kernel.org/patch/8164161/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v1 was sent in Jan 2016, and instead added a dependency on CONFIG_NET
> ---
>  arch/arm/mach-s3c24xx/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied.

Best regards,
Krzysztof
