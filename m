From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 27 Dec 2017 09:19:03 +0100
Subject: [PATCH 10/11 v3] ARM: s3c24xx/s3c64xx: constify gpio_led
In-Reply-To: <adb77ba31b66d391a49a12434dfe7811e8a8ba0f.1514267721.git.arvind.yadav.cs@gmail.com>
References: <de0879ef47b96776e3f18a1889c41d976a677b21.1514267721.git.arvind.yadav.cs@gmail.com>
 <adb77ba31b66d391a49a12434dfe7811e8a8ba0f.1514267721.git.arvind.yadav.cs@gmail.com>
Message-ID: <CAJKOXPf3izR2nquBds3gvhXRRh=hx4JvAgC+XrJ=sUnq3tjexQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 26, 2017 at 7:50 PM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> gpio_led are not supposed to change at runtime.
> struct gpio_led_platform_data working with const gpio_led
> provided by <linux/leds.h>. So mark the non-const structs
> as const.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> changes in v2:
>               The GPIO LED driver can be built as a module, it can
>               be loaded after the init sections have gone away.
>               So removed '__initconst'.
> changes in v3:
>              Description was missing.
>
>  arch/arm/mach-s3c24xx/mach-h1940.c    | 2 +-
>  arch/arm/mach-s3c24xx/mach-rx1950.c   | 2 +-
>  arch/arm/mach-s3c64xx/mach-hmt.c      | 2 +-
>  arch/arm/mach-s3c64xx/mach-smartq5.c  | 2 +-
>  arch/arm/mach-s3c64xx/mach-smartq7.c  | 2 +-
>  arch/arm/mach-s3c64xx/mach-smdk6410.c | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

There were few build errors reported by kbuild for your patches. Are
you sure that you compiled every file you touch?

Best regards,
Krzysztof
