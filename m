From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 23 Mar 2017 21:14:30 +0200
Subject: [PATCH v4 1/6] pinctrl: samsung: Ensure that pad retention is
 disabled on driver init
In-Reply-To: <1490256207-10061-2-git-send-email-m.szyprowski@samsung.com>
References: <1490256207-10061-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170323080347eucas1p2d0340709543b3ce128281e5a490216d4@eucas1p2.samsung.com>
 <1490256207-10061-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170323191430.tdu33hh5ojwffb2e@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 09:03:22AM +0100, Marek Szyprowski wrote:
> When pin controller device is a part of power domain, there is no guarantee
> that the power domain was not turned off and then on during boot process
> before probing of the pin control driver. If it happened, then pin control
> driver should ensure that pad retention is turned off during its probe call.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/pinctrl/samsung/pinctrl-exynos.c | 5 +++++
>  1 file changed, 5 insertions(+)
>

Thanks, applied.

Let it settle for one day so auto-builders will catch up and then I will
provide a stable tag for Lee (MFD).

Best regards,
Krzysztof
