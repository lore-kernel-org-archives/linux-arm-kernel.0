From: edubezval@gmail.com (Eduardo Valentin)
Date: Thu, 28 Aug 2014 10:53:12 -0400
Subject: [PATCHv5 4/4] thermal: exynos: Remove duplicate code when
 reading triminfo register of Exynos5440
In-Reply-To: <53FEAF2A.1080400@samsung.com>
References: <1409016665-3824-1-git-send-email-cw00.choi@samsung.com>
 <1409016665-3824-5-git-send-email-cw00.choi@samsung.com>
 <53FEAF2A.1080400@samsung.com>
Message-ID: <20140828145310.GC18194@developer>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 28, 2014 at 01:25:14PM +0900, Chanwoo Choi wrote:
> Dear Eduardo,
> 
> This patch is wrong. It is my mistake.
> 
> Please ignore only this patch because
> the offset calculation of 'case 0' is different from 'case 2'.


Do patches 1 - 3 are still correct? Patch 1, from Barlomiej, seams to be
a common agreement. 

> 
> Best Regards,
> Chanwoo Choi
> 
> On 08/26/2014 10:31 AM, Chanwoo Choi wrote:
> > This patch remove simply duplicate code when reading triminfo register of Exynos5440.
> > 
> > Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> > Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> > Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> > ---
> >  drivers/thermal/samsung/exynos_tmu.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> > index 64c702a..5888467 100644
> > --- a/drivers/thermal/samsung/exynos_tmu.c
> > +++ b/drivers/thermal/samsung/exynos_tmu.c
> > @@ -187,15 +187,13 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
> >  		 */
> >  		switch (data->id) {
> >  		case 0:
> > +		case 2:
> >  			trim_info = readl(data->base +
> >  			EXYNOS5440_EFUSE_SWAP_OFFSET + reg->triminfo_data);
> >  			break;
> >  		case 1:
> >  			trim_info = readl(data->base + reg->triminfo_data);
> >  			break;
> > -		case 2:
> > -			trim_info = readl(data->base -
> > -			EXYNOS5440_EFUSE_SWAP_OFFSET + reg->triminfo_data);
> >  		}
> >  	} else {
> >  		/* On exynos5420 the triminfo register is in the shared space */
> > 
> 
