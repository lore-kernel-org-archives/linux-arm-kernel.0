From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 12:30:21 +0000
Subject: [PATCH 05/19] ARM: ux500: Stop registering HREF's SDI devices
 from platform data
In-Reply-To: <1347016499-29354-6-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-6-git-send-email-lee.jones@linaro.org>
Message-ID: <201209071230.21397.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Lee Jones wrote:
> 
> The HREF Device Tree now has support for its four SDIs. So, if we
> continue registering them from platform code when Device Tree is
> enabled we'll cause a double probe of the same devices. To prevent
> that we'll just remove registration.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-ux500/board-mop500.c |    1 -
>  1 file changed, 1 deletion(-)

The change is ok, but I think it should go into the same patch
as the one before, so you can atomically switch from one to the other.

	Arnd
