From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Wed, 30 Sep 2015 14:15:22 +0100
Subject: [PATCH] drm/exynos: Avoid NULL pointer dereference in resume
 if bind failed
In-Reply-To: <560BC6ED.3090205@samsung.com>
References: <1443370306-15429-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <560BC6ED.3090205@samsung.com>
Message-ID: <20150930131522.GK5432@ck-lbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 08:26:37PM +0900, Inki Dae wrote:
> Hi,
> 
> On 2015? 09? 28? 01:11, Charles Keepax wrote:
> > If binding failed calling exynos_dp_enable in exynos_dp_resume will
> > result in several NULL pointer dereferences. It is much better to
> > simply skip suspend/resume handling if bind has failed, do so by
> > checking if a drm_dev exists.
> 
> Thanks for your patch. However, the pm interfaces of KMS drivers aren't
> required because these are controlled by top of Exynos drm driver and
> connector dpms. So I posted a patch that it removes pm interfaces of dp
> driver.

No problems at all, as long as my Arndale starts resuming without
a NULL pointer I am happy :-)

Had a quick test of your patch it appears to fix my issue as well
so totally fine with that.

Thanks,
Charles
