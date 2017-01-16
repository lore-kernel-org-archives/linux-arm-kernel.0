From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 16 Jan 2017 21:23:45 +0200
Subject: [PATCH 00/12] Move pad retention control to Exynos pin
 controller driver
In-Reply-To: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20170116064523eucas1p161a8e060b2883c076fc470ce7b522332@eucas1p1.samsung.com>
 <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20170116192345.4cywkpzsswitgclp@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 07:44:55AM +0100, Marek Szyprowski wrote:
> Hello,
> 
> This patchset is a follow-up of my work on adding runtime PM support
> to Exynos pin controller driver:
> http://www.spinics.net/lists/arm-kernel/msg550161.html
> 
> Runtime PM support itself needs a bit more discussion, so lets first focus on
> the prerequisites.
> 
> In case of Exynos pin controller driver it is a pad retention control. In
> current code it was handled by machine and PMU code and had no relation to
> what pin controller driver does. This patch series moves pad retention
> control to pin controller driver. While implmenting it, I also did a little
> cleanup of both Exynos PMU and pin controller drivers.
> 
> Patches are based on linux-next from 2017.01.16 with Exynos4415 support
> removal patch applied: https://lkml.org/lkml/2017/1/14/137

I didn't find explicit statement for dependency between the patches in
the patchset itself and also I could not find the usage of
EXYNOS_PMU_DEV_NAME by pinctrl driver.

Do the pinctrl changes depend on soc/samsung patches? If not, then
probably your future work will depend on this?

Best regards,
Krzysztof
