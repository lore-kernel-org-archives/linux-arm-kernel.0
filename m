From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 21 Jun 2016 13:16:24 +0200
Subject: [[PATCH v2] 03/11] ARM: EXYNOS: fixups for big-endian operation
In-Reply-To: <1466504432-24187-4-git-send-email-ben.dooks@codethink.co.uk>
References: <1466504432-24187-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466504432-24187-4-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <57692208.9000405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2016 12:20 PM, Ben Dooks wrote:
> If the kernel is built big endian, then using the __raw read and write IO
> accessors is not going to work as they end up writing big-endian data to
> little-endian IO registers. Fix this by using the readl and writel relaxed
> versions which ensure little endian IO.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/mach-exynos/firmware.c | 16 ++++++++--------
>  arch/arm/mach-exynos/headsmp.S  |  3 +++
>  arch/arm/mach-exynos/platsmp.c  |  4 ++--
>  3 files changed, 13 insertions(+), 10 deletions(-)


Thanks, applied for v4.8.

Best regards,
Krzysztof
