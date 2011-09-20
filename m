From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Tue, 20 Sep 2011 17:09:26 +0200 (CEST)
Subject: [PATCH 2/5] [media] v4l: Add mt9t111 sensor driver
In-Reply-To: <1316530612-23075-3-git-send-email-deepthy.ravi@ti.com>
References: <1316530612-23075-1-git-send-email-deepthy.ravi@ti.com>
	<1316530612-23075-3-git-send-email-deepthy.ravi@ti.com>
Message-ID: <Pine.LNX.4.64.1109201704190.11274@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 20 Sep 2011, Deepthy Ravi wrote:

> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> The MT9T111 is a 3.1Mp CMOS sensor from Aptina with
> its latest image signal processing (ISP) and 1.75??m
> pixel technology.
> The sensor driver currently supports only VGA
> resolution.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Deepthy Ravi <deepthy.ravi@ti.com>
> ---
>  drivers/media/video/Kconfig       |    7 +
>  drivers/media/video/Makefile      |    1 +
>  drivers/media/video/mt9t111.c     |  793 +++++++++++++++++++++
>  drivers/media/video/mt9t111_reg.h | 1367 +++++++++++++++++++++++++++++++++++++
>  include/media/mt9t111.h           |   45 ++
>  5 files changed, 2213 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/media/video/mt9t111.c
>  create mode 100644 drivers/media/video/mt9t111_reg.h
>  create mode 100644 include/media/mt9t111.h

NAK. The mt9t112 driver claims to also support mt9t111. I'm not sure, 
whether the driver has indeed been tested with mt9t111, but this is 
definitely something to verify. If the chips are indeed similar, please 
use the tree at

http://git.linuxtv.org/gliakhovetski/v4l-dvb.git/shortlog/refs/heads/rc1-for-3.2

which has converted the mt9t112 driver to be also used outside ot the 
soc-camera subsystem, and use that driver instead of adding another one.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
