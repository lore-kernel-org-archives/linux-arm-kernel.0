From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Tue, 16 Jun 2015 17:03:23 +0000
Subject: [PATCH 1/2] ARM: ep93xx: enable all boards in the EP93xx defconfig
In-Reply-To: <1434441520-18607-1-git-send-email-linus.walleij@linaro.org>
References: <1434441520-18607-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D883D4A3688@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 16, 2015 12:59 AM, Linus Walleij wrote:
> With PATCH_PHYS_TO_VIRT we can support all EP93xx variants
> in a single image, so enable all board variants in the defconfig
> for simplicity and build coverage.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I'm a bit uncertain as this disables the NWFP(E) floating point
> emulation - as we are compiling with EABI for ARMv4T on ARM920T
> for all EP93xx variants I assume the compiler will handle floating
> point emulation, but maybe there are some userspaces using FP
> that I'm not aware of? Suggestions here would be welcome. This
> makes sense as a default for me.

FWIW, my test .config does not have NWFP(E) floating point emulation
enabled.

I'm ok with this change.

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
