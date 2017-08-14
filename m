From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Mon, 14 Aug 2017 21:56:08 +0200
Subject: [PATCH 0/5] s5p-jpeg fixes
In-Reply-To: <1502191352-11595-1-git-send-email-andrzej.p@samsung.com>
References: <CGME20170808112254eucas1p20aacd5bb0737ff85ba4756724af189aa@eucas1p2.samsung.com>
 <1502191352-11595-1-git-send-email-andrzej.p@samsung.com>
Message-ID: <253fafa5-8403-b098-ccb3-d5cd3ccb1c23@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej,

Thanks for the patch set.

On 08/08/2017 01:22 PM, Andrzej Pietrasiewicz wrote:
> Hi All,
> 
> This series contains a number of fixes to the s5p-jpeg driver.
> 
> There are two patches from Tony K Nadackal, which got lost long time ago.
> 
> @Thierry:
> The patch changing the software reset routine you sent recently was
> actually a resend of Tony's patch. I investigated the question why
> this patch is needed. The encoder/decoder should be disabled as soon
> as possible, in the interrupt service routine; please see the commit message.
> I am resending Tony's patch again, with updated commit message.
> Thank you for reminding about the patch in question!
> 
> There are also three patches from me, please see appropriate commit
> messages.
> 
> Rebased onto Mauro's master.
> 
> Andrzej Pietrasiewicz (3):
>   media: platform: s5p-jpeg: disable encoder/decoder in exynos4-like
>     hardware after use
>   media: platform: s5p-jpeg: fix number of components macro
>   media: platform: s5p-jpeg: directly use parsed subsampling on 5433
> 
> Tony K Nadackal (2):
>   media: platform: s5p-jpeg: Fix crash in jpeg isr due to multiple
>     interrupts.
>   media: platform: s5p-jpeg: Clear JPEG_CODEC_ON bits in sw reset
>     function
> 
>  drivers/media/platform/s5p-jpeg/jpeg-core.c       | 8 +++++++-
>  drivers/media/platform/s5p-jpeg/jpeg-core.h       | 1 +
>  drivers/media/platform/s5p-jpeg/jpeg-hw-exynos4.c | 9 ++++++++-
>  drivers/media/platform/s5p-jpeg/jpeg-regs.h       | 2 +-
>  4 files changed, 17 insertions(+), 3 deletions(-)
> 

For the whole series:

Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

-- 
Best regards,
Jacek Anaszewski
