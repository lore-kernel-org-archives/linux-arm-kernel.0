From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 May 2010 10:41:20 +0900
Subject: Samsung SoCs framebuffer re-work
In-Reply-To: <AANLkTinThrLrsxBYHs-1xPqIaRiK1HH-YZkcloKHnzkx@mail.gmail.com>
References: <AANLkTinThrLrsxBYHs-1xPqIaRiK1HH-YZkcloKHnzkx@mail.gmail.com>
Message-ID: <005c01caf62b$3c1d72f0$b45858d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> Hi Ben,
> 
> Currently there's only one fb drivers for samsung SocS. but it's based
> on s3c24xx and a part of s3c64xx.
> As you can see the s5pc110 (aka s5pv210) spec, It has more features
> and interconnection between FIMC and FIMD.
> So current fb driver can't handle these features well. So LSI make a
> own fb drivers and use it. You can see the code at their git repo.
> 
> Now we are re-implement or change it for s5pc110 and for future usages.
> How do you think?

Hi,

As you commented, System LSI has own S5PV210/S5PC110 FB driver which is
different from s3c24xx and s3c64xx.

Samsung S.LSI FB driver for S5PV210/S5PC110 has:
- IRQ support for underrun
- VSYNC interrupt
- Configuration variables for virtual screen support
- Change default window from zero
- Double buffering support
- Private IOCTL support
  => control data sources
  => move window positions
  => alpha blending support
- Direct ioctl for FIMD and 3D
- sysfs files for window control

So S.LSI is modifying it to be relatively easy to merge.
And will be submitted soon.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
