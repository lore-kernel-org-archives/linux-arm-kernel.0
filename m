From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Jan 2013 00:02:12 -0800
Subject: [PATCH v2] ARM: remove redundant 'select GENERIC_GPIO'
In-Reply-To: <1358499506-9790-1-git-send-email-shawn.guo@linaro.org>
References: <1358499506-9790-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130122080212.GA27384@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 04:58:26PM +0800, Shawn Guo wrote:
> In drivers/gpio/Kcong, ARCH_REQUIRE_GPIOLIB selects GPIOLIB which in
> turn selects GENERIC_GPIO.  So GENERIC_GPIO will be selected
> automatically for those platforms that select ARCH_REQUIRE_GPIOLIB.
> 
> Remove the redundant 'select GENERIC_GPIO' for platforms that already
> select ARCH_REQUIRE_GPIOLIB at either mach or plat level.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes since v1:
>  - Update commit log to better explain why the select is unncessary

Applied to next/cleanup. Thanks!

-Olof
