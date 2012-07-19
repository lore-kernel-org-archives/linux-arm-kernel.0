From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 20 Jul 2012 07:47:34 +0900
Subject: [PATCH v3 0/6] mmc: dw_mmc: add support for device tree based
 instantiation
In-Reply-To: <CAJuYYwQBgpJ1wiS3fSDS2cMi6kanuO47rc8SmniAqjRPuBGJHg@mail.gmail.com>
References: <1342097668-25243-1-git-send-email-thomas.abraham@linaro.org>
 <5008279B.4000001@samsung.com>
 <CAJuYYwQBgpJ1wiS3fSDS2cMi6kanuO47rc8SmniAqjRPuBGJHg@mail.gmail.com>
Message-ID: <195201cd6600$7cb089f0$76119dd0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> On 19 July 2012 20:58, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> > Hi Thomas,
> >
> > I think not good that added the samsung specific code into dw_mmc-
> pltfm.c
> > How about separating to dw-mmc-exynos.c?
> 
> I am not sure of this. The only samsung specific code in
> dw_mmc-pltfm.c file is the data for of_device_id instances. The clock
> lookup added into this file in the 3rd patch does not cause any harm
> on non-samsung SoC's which might not define those clocks (on clock
> lookup failure, there are only warning printed, the driver's probe
> does not fail.
> 
I agree with Thomas' opinion, in addition, the dw_mmc-pltfm.c file can
support that, so adding dw-mmc-exynos.c is not needed now.

> I would prefer not to add separate file for Exynos SoC's for now.
> Splitting into different files will need to defined new callbacks
> which I fell is not really required.
> 
Yes.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
