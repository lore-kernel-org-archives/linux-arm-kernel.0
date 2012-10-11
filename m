From: mturquette@ti.com (Mike Turquette)
Date: Thu, 11 Oct 2012 15:21:07 -0700
Subject: [RFC][PATCH v4? 0/7] Adaptive Body-Bias for OMAP
In-Reply-To: <20121011133304.GA19170@kahuna>
References: <1349313974-5473-1-git-send-email-mturquette@ti.com>
 <20121011133304.GA19170@kahuna>
Message-ID: <20121011222107.2941.62545@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Nishanth Menon (2012-10-11 06:33:04)
> On 18:26-20121003, Mike Turquette wrote:
> > From: Mike Turquette <mturquette@linaro.org>
> [...]
> > 
> >  arch/arm/mach-omap2/Makefile                  |    8 +-
> >  arch/arm/mach-omap2/abb.c                     |  322 +++++++++++++++++++++++++
> >  arch/arm/mach-omap2/abb.h                     |   94 ++++++++
> [...]
> >  arch/arm/plat-omap/include/plat/voltage.h     |    1 +
> >  18 files changed, 699 insertions(+), 37 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/abb.c
> >  create mode 100644 arch/arm/mach-omap2/abb.h
> >  create mode 100644 arch/arm/mach-omap2/abb36xx_data.c
> >  create mode 100644 arch/arm/mach-omap2/abb44xx_data.c
> 
> dumb question: with the request to move everything out of mach-omap2
> directory, do we still want to add more files into mach-omap2?
> 

Not a dumb question at all.  I approached this problem by modeling it
after existing voltage layer code (in particular the vp and vc drivers).

My hope is to get it merged as-is and then bundle the abb code up with
the vp/vc migration to drivers/* when that happens some day.  People
using omap36xx and above need this code now, so it seems prudent to take
this approach today.

Regards,
Mike

> Regards,
> NM
