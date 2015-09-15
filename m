From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 16 Sep 2015 08:35:50 +0900
Subject: [PATCH v2] ARM: dts: Fix LEDs on exynos5422-odroidxu3
In-Reply-To: <1442136736-28672-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1442136736-28672-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <55F8AB56.1010900@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/15 18:32, Krzysztof Kozlowski wrote:
> The LEDs on Odroid XU3 family boards could not properly probe because PWM
> outputs were reduced only to PWM for fan. Fix it for Odroid XU3 and
> XU3-Lite boards by switching to usage of all 4 outputs (although the PWM
> for MIPI probably is redundant because board does not have MIPI
> connector available).
> 
> This fixes warnings on dmesg:
> [    4.838712] samsung-pwm 12dd0000.pwm: tried to request PWM channel 1 without output
> [    4.838725] leds_pwm pwmleds: unable to request PWM for green:mmc0: -22
> [    4.838767] leds_pwm: probe of pwmleds failed with error -22
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> 
> ---
> 
> Changes since v1:
> 1. Do not rebase on patchset adding support for Odroid XU4 board. Rebase
>    just on current next.
> ---

Applied, thanks.

- Kukjin
