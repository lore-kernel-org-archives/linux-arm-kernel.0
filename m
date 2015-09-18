From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Fri, 18 Sep 2015 16:30:08 +0200
Subject: [PATCH 2/4] s5p-jpeg: add support for 5433
In-Reply-To: <1442586060-23657-3-git-send-email-andrzej.p@samsung.com>
References: <1442586060-23657-1-git-send-email-andrzej.p@samsung.com>
 <1442586060-23657-3-git-send-email-andrzej.p@samsung.com>
Message-ID: <55FC1FF0.7080506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej,

On 09/18/2015 04:20 PM, Andrzej Pietrasiewicz wrote:
> JPEG IP found in Exynos5433 is similar to what is in Exynos4, but
> there are some subtle differences which this patch takes into account.
>
> The most important difference is in what is processed by the JPEG IP and
> what has to be provided to it. In case of 5433 the IP does not parse
> Huffman and quantisation tables, so this has to be performed with the CPU
> and the majority of the code in this patch does that.
>
> A small but important difference is in what address is passed to the JPEG
> IP. In case of 5433 it is the SOS (start of scan) position, which is
> natural, because the headers must be parsed elsewhere.
>
> There is also a difference in how the hardware is put to work in
> device_run.
>
> Data structures are extended as appropriate to accommodate the above
> changes.
>
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> ---
>   .../bindings/media/exynos-jpeg-codec.txt           |   3 +-
>   drivers/media/platform/s5p-jpeg/jpeg-core.c        | 378 +++++++++++++++++++--
>   drivers/media/platform/s5p-jpeg/jpeg-core.h        |  31 ++
>   drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c  |  80 ++++-
>   drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.h  |  11 +-
>   drivers/media/platform/s5p-jpeg/jpeg-regs.h        |  85 +++--
>   6 files changed, 522 insertions(+), 66 deletions(-)

Reviewed-by: Jacek Anaszewski <j.anaszewski@samsung.com>

-- 
Best Regards,
Jacek Anaszewski
