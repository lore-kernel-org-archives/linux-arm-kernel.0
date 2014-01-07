From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 7 Jan 2014 08:23:49 +0000
Subject: [PATCH 1/3] mfd: always assign of_node in mfd_add_device()
In-Reply-To: <52CAF1FF.9090709@wwwdotorg.org>
References: <1386626809-6251-1-git-send-email-swarren@wwwdotorg.org>
 <20131211092435.GC16780@lee--X1> <52B32C05.5010204@wwwdotorg.org>
 <20131220142530.GK3709@lee--X1> <52CAF1FF.9090709@wwwdotorg.org>
Message-ID: <20140107082349.GC3182@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Please let me know if this is suitable and I can keep your Ack.
> 
> This patch doesn't seem to have made it into next-20140106. I assume
> that's just because of the holidays, not because it was forgotten?

Right, it was pushed yesterday morning.

> > ----
> > 
> > mfd: Revert "mfd: Always assign of_node in mfd_add_device()"
> > 
> > This reverts commit 68044bee13770918e0b28dd44aa98c889ec7558f.
> > 
> > We've had confirmed reports of this patch causing unforeseen issues
> > with existing MFD users. It has been agreed by the original author
> > and myself that reversion is the best solution.
> > 
> > Acked-by: Stephen Warren <swarren@nvidia.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index 32e8d47..2676492 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -117,8 +117,6 @@ static int mfd_add_device(struct device *parent, int id,
> >  			}
> >  		}
> >  	}
> > -	if (!pdev->dev.of_node)
> > -		pdev->dev.of_node = parent->of_node;
> >  
> >  	if (cell->pdata_size) {
> >  		ret = platform_device_add_data(pdev,
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
