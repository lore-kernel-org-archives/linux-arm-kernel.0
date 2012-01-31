From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 31 Jan 2012 20:27:23 +0900
Subject: [PATCH v2] S3C24XX DMA resume regression fix
In-Reply-To: <20120127122537.GF2056@build.ihdev.net>
References: <1327065184-9805-1-git-send-email-dron0gus@gmail.com>
 <20120127122537.GF2056@build.ihdev.net>
Message-ID: <04a201cce00b$4d6aaac0$e8400040$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergey Lapin wrote:
> 
> On Fri, Jan 20, 2012 at 05:13:04PM +0400, Gusakov Andrey wrote:
> > In commit bb072c3cf21d1c9a5a2eeb5a00679ee7bf39675b

Just the first 12 hex digits of the commit id is enough now as Linus said?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> > (Use struct syscore_ops for "core" power management)
> > suspend/resume hooks for each DMA channels were replaced with
> > hooks that suspend/resume all channels. s3c2410_dma_suspend
> > suspends channels from 0 to dma_channels. s3c2410_dma_resume
> > resumes channels in reverse order. So pointer should be
> > decremented insted of being incremented.
> Any news regarding this patch?
> >
> > Signed-off-by: Gusakov Andrey <dron0gus@gmail.com>
> > ---
> >  arch/arm/plat-s3c24xx/dma.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > v2: updated commit message with original commit summary
> >
> 
> All the best,
> S.
