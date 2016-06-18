From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 18 Jun 2016 23:37:31 +0900
Subject: [PATCH] clk: samsung: Suppress unbinding to prevent theoretical
 attacks
In-Reply-To: <1463469974-13340-1-git-send-email-k.kozlowski@samsung.com>
References: <1463469974-13340-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CA+Ln22E13nm4nsgWoi6gNc_Jh+UqqE5MgwANH02GZF7bQye+yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2016-05-17 16:26 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> Although unbinding a driver requires root privileges but it still might
> be used theoretically in certain attacks (by triggering NULL pointer
> exception or memory corruption if driver does not provide proper remove
> callbacks or core does not handle it).
>
> Samsung clock drivers are essential for system operation so their
> removal is not expected. More over, the Exynos3250 ISP clock driver does
> not implement remove() driver callback and it is not buildable as
> modules.
>
> Suppress the unbind interface for Exynos3250 ISP and S3C2410 DCLK clock
> drivers.
>
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos3250.c   | 1 +
>  drivers/clk/samsung/clk-s3c2410-dclk.c | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)

Makes sense. (By the way, I wonder if we ever see a solution for the
unbind problem with .remove implemented and some resources that can't
be released at the time .unbind is attempted...)

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Best regards,
Tomasz
