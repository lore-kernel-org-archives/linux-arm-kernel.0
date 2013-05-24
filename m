From: jp.francois@cynove.com (jean-philippe francois)
Date: Fri, 24 May 2013 09:31:52 +0200
Subject: [PATCH 0/1] ARM: omap3: Fix regression in dpll4 child clock frequency
 setting.
Message-ID: <CAGGh5h2qtc4CdAeupzZBz2OPoqy3h3Tw8__fR1w1PBwd7vFeGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following patch fixes a wrong container_of usage for omap3630.
CAM_MCLK is 216 MHz instead of the asked 172,8 MHz
Any user of this clock is affected. This is the case for instance if
CAM_XCLKA is used to provide clock for an external camera.

All sub clock of dpll4 that do not use a reset value as divider are
also affected.

Beyond wrong frequency setting, this is also a potential oops waiting
to bite any omap3isp user, since a wrong pointer is dereferenced, and
content of this pointer is used to do __raw_writel / __raw_readl.

Regards,
Jean-Philippe Fran?ois
