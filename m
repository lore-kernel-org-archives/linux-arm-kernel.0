From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 08 Nov 2012 13:52:24 +0900
Subject: [PATCH] ARM: EXYNOS: Make s3c_device_i2c0 always use id 0
In-Reply-To: <509AA23C.6000704@gmail.com>
References: <4039915.8GOx0SKq2B@amdc1227> <509AA23C.6000704@gmail.com>
Message-ID: <0ced01cdbd6c$d81f9b00$885ed100$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> On 11/07/2012 02:00 PM, Tomasz Figa wrote:
> > This patch removes compatibility definitions added long time ago when
> > clock ids were used instead of devnames that were needed for platforms
> > with only one i2c controller with id -1 (some s3c24xx's).
> >
> > Because currently devname field is used for matching device instances to
> > clocks and if no devname is provided (as in clock-s3c2412.c and
> > common-s3c2443.c for i2c clock, both in arch/arm/mach-s3c24xx) the clock
> > is being matched only by name, so s3c_device_i2c0 can always have id 0.
> >
> > This patch solves the issue with i2c0 broken on boards where its the
> > only i2c controller used, tested on Origen.
> >
> > Signed-off-by: Tomasz Figa<t.figa@samsung.com>
> > Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
> 
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
Applied, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
