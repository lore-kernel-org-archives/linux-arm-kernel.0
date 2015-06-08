From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 8 Jun 2015 08:54:44 +0200
Subject: [PATCH] thermal: exynos: Disable the regulator on probe failure
In-Reply-To: <1433727349-23330-1-git-send-email-k.kozlowski@samsung.com>
References: <1433727349-23330-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CABxcv=me__Nor+grdD+GaGJNZT5hRt6Tq7VBN1=yNzj+qw-zww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On Mon, Jun 8, 2015 at 3:35 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> During probe the regulator (if present) was enabled but not disabled in
> case of failure. So an unsuccessful probe lead to enabling the
> regulator which was actually not needed because the device was not
> enabled.
>
> Additionally each deferred probe lead to increase of regulator enable
> count so it would not be effectively disabled during removal of the
> device.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Fixes: 498d22f616f6 ("thermal: exynos: Support for TMU regulator defined at device tree")
> Cc: <stable@vger.kernel.org>
>

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

> ---
>
> I am not entirely convinced that this should go to stable. Leaving a
> regulator enabled in case of probe failure (no exynos TMU device) or
> after deferred probe (regulator won't be disabled during device removal)
> is not a critical issue, just leaks power.


Yes, as you said leaving the regulator enabled is not critical but
OTOH is a very small patch and is fixing a very evident bug so I think
it's OK.

Best regards,
Javier
