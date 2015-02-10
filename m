From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Tue, 10 Feb 2015 14:12:00 +0100
Subject: [PATCH] ARM: EXYNOS: Use platform device name as power domain name
In-Reply-To: <1423573035-21960-1-git-send-email-k.kozlowski@samsung.com>
References: <1423573035-21960-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <54DA03A0.9040305@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello 

Krzysztof,

On 02/10/2015 01:57 PM, Krzysztof Kozlowski wrote:
> The power domain nodes in DTS may be very generic (e.g. "power-domain"
> for Exynos 5420) making it very hard to debug:
> 
> $ cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
>     domain                      status         slaves
> power-domain                    on
> 
> Use platform device name instead so the names will be a little more user
> friendly:
>     domain                      status         slaves
> 100440e0.power-domain           on
> 

I would had preferred to have even more info like 100440e0.mau-power-domain.
Maybe using the OF aliases approach that Sylwester suggested? But in any case
that could be complementary to your patch.

> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Suggested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Suggested-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
