From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 24 May 2016 12:22:22 +0200
Subject: [PATCH 0/3] [media] s5p-mfc: Fixes for issues when module is
 removed
In-Reply-To: <1462307238-21815-1-git-send-email-javier@osg.samsung.com>
References: <1462307238-21815-1-git-send-email-javier@osg.samsung.com>
Message-ID: <a64533b5-9af2-5f15-0ed3-28015b695ee0@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


On 2016-05-03 22:27, Javier Martinez Canillas wrote:
> Hello,
>
> This patch series fixes some issues that I noticed when trying to remove
> the s5p-mfc driver when built as a module.
>
> Some of these issues will be fixed once Marek's patches to convert the
> custom memory region reservation code is replaced by a generic one that
> supports named memory region reservation [0]. But the fixes are trivial
> so we can fix the current code until his rework patch lands.

For the whole series:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Please queue it as fixes to v4.7-rcX.

>
> [0]: https://patchwork.linuxtv.org/patch/32287/
>
> Best regards,
> Javier
>
>
> Javier Martinez Canillas (3):
>    [media] s5p-mfc: Set device name for reserved memory region devs
>    [media] s5p-mfc: Add release callback for memory region devs
>    [media] s5p-mfc: Fix race between s5p_mfc_probe() and s5p_mfc_open()
>
>   drivers/media/platform/s5p-mfc/s5p_mfc.c | 50 ++++++++++++++++++++------------
>   1 file changed, 32 insertions(+), 18 deletions(-)
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
