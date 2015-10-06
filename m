From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 06 Oct 2015 09:28:50 +0900
Subject: [PATCH 0/6] ARM: s3cxxxx: Use PWM lookup table
In-Reply-To: <1444049237-29878-1-git-send-email-thierry.reding@gmail.com>
References: <1444049237-29878-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <561315C2.9040506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.10.2015 21:47, Thierry Reding wrote:
> Back when the PWM framework was introduced the concept of PWM lookup
> tables was added to allow board code to register a table of PWM devices
> and their association with consumers. The goal is to allow drivers to
> use a unified method to request PWM devices. At the same time, since no
> boards were exposing these tables, fallback code was kept in drivers to
> allow old code to remain functional. In order to get rid of the legacy
> fallback code, legacy users need to be updated to register PWM lookup
> tables.
> 
> This series converts all s3c24xx and s3c64xx boards that hook up a pwm-
> backlight device to use the new PWM lookup tables. All patches have been
> compile-tested, but I don't have access to any of these boards, so I
> couldn't verify that they really work.

Unfortunately I can't verify them neither. I don't have these boards. In
that case I would prefer approach "if it ain't broken, don't touch
it"... unless someone tests the patches of course.

Anyone can provide tested-by tag?

Best regards,
Krzysztof


> 
> Thierry
> 
> Thierry Reding (6):
>   ARM: s3c24xx: h1940: Use PWM lookup table
>   ARM: s3c24xx: rx1950: Use PWM lookup table
>   ARM: s3c64xx: smdk6410: Use PWM lookup table
>   ARM: s3c64xx: crag6410: Use PWM lookup table
>   ARM: s3c64xx: hmt: Use PWM lookup table
>   ARM: s3c64xx: smartq: Use PWM lookup table
> 
>  arch/arm/mach-s3c24xx/mach-h1940.c    | 10 +++++++---
>  arch/arm/mach-s3c24xx/mach-rx1950.c   |  8 ++++++--
>  arch/arm/mach-s3c64xx/dev-backlight.c |  4 ----
>  arch/arm/mach-s3c64xx/mach-crag6410.c |  9 +++++++--
>  arch/arm/mach-s3c64xx/mach-hmt.c      |  9 +++++++--
>  arch/arm/mach-s3c64xx/mach-smartq.c   |  9 +++++++--
>  arch/arm/mach-s3c64xx/mach-smdk6410.c |  8 +++++++-
>  7 files changed, 41 insertions(+), 16 deletions(-)
> 
