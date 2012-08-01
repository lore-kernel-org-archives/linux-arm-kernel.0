From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 01 Aug 2012 10:56:26 +0900
Subject: [PATCH 1/3] Move FIMD register headers to include/video/
In-Reply-To: <033c01cd6ef6$fb514570$f1f3d050$%szyprowski@samsung.com>
References: <1343637905-17764-1-git-send-email-l.krishna@samsung.com>
 <1343637905-17764-2-git-send-email-l.krishna@samsung.com>
 <000001cd6e30$da849520$8f8dbf60$%han@samsung.com>
 <CAL1wa8e7Joghf9S=SgbQLJFWcYOrP5uK6qYXsV_N6rX1MVEALg@mail.gmail.com>
 <000a01cd6eb6$2113a050$633ae0f0$%han@samsung.com>
 <032201cd6ee5$ad4a0d50$07de27f0$%szyprowski@samsung.com>
 <000701cd6ef5$24315c70$6c941550$%han@samsung.com>
 <033c01cd6ef6$fb514570$f1f3d050$%szyprowski@samsung.com>
Message-ID: <02ed01cd6f88$dc91caf0$95b560d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Hello,
> 
Hi all,

[...]

> >  static struct s3c_fb_driverdata s3c_fb_data_exynos5 = {
> >         .variant = {
> >                 .nr_windows     = 5,
> > -               .vidtcon        = VIDTCON0,
> > +               .vidtcon        = FIMD_V8_VIDTCON0,
> 
> Yes, this method looks good imo. Maybe even having something like
> vidtcon_base in
> variant structure will be enough to cover all VIDTCON0-3 registers.
> 
Yes, I agree. And how about changing the name of s3c_fb_drvierdata to
xxx_fimd_v8 not xxx_fimd_exynos5? It's time to use independent from SoC name
because we don't have any guarantee of same address on all of EXYNOS5 SoCs.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
