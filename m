From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 12 Jun 2015 14:57:01 +0900
Subject: [PATCH v2 1/1] irqchip: exynos-combiner: Save IRQ enable set on
 suspend
In-Reply-To: <1434087795-13990-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1434087795-13990-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <557A74AD.6040305@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.06.2015 14:43, Javier Martinez Canillas wrote:
> The Exynos interrupt combiner IP loses its state when the SoC enters
> into a low power state during a Suspend-to-RAM. This means that if a
> IRQ is used as a source, the interrupts for the devices are disabled
> when the system is resumed from a sleep state so are not triggered.
> 
> Save the interrupt enable set register for each combiner group and
> restore it after resume to make sure that the interrupts are enabled.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 
> Hello,
> 
> I noticed this issue because after a S2R, IRQs for some devices didn't
> trigger anymore but others continued working and all of them had lines
> from a GPIO chip as their interrupt source.
> 
> The only difference was that the GPIO pins that were not working after
> a resume, were the ones that had the interrupt combiner as interrupt
> parent.
> 
> With this patch now all perhiperals are working correctly after a resume.
> Tested on an Exynos5250 Snow, Exynos5420 Peach Pit and Exynos5800 Peach Pi
> Chromebooks.
> 
> Best regards,
> Javier
> 
> Changes since v1:
>  - Clear masking bits before of the COMBINER_ENABLE_CLEAR register before
>    restore IRQ enable set the Suggested by Chanho Park.
>  - Fixes a typo in the commit message. Suggested by Peter Chubb.

Looks okay,
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
