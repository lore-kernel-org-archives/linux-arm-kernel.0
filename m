From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 21 Oct 2013 15:47:09 +0200
Subject: [PATCH 2/2] spi/s3c64xx: Fix doubled clock disable on suspend
In-Reply-To: <1382362971-16763-2-git-send-email-k.kozlowski@samsung.com>
References: <1382362971-16763-1-git-send-email-k.kozlowski@samsung.com>
 <1382362971-16763-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <5265305D.9040203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/10/13 15:42, Krzysztof Kozlowski wrote:
> Fix doubled clock disable and unprepare during PM suspend which triggered
> the warnings:

> The clocks may be already disabled before suspending. Check PM runtime
> suspend status and disable clocks only if device is not suspended.
> During resume do not enable the clocks if device is runtime suspended.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
