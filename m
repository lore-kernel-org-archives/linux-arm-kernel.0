From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 11 May 2012 13:00:55 -0600
Subject: [PATCH] gpio: samsung: refactor gpiolib init for exynos4/5
In-Reply-To: <4F846C53.1070407@samsung.com>
References: <1333913007-16032-1-git-send-email-olof@lixom.net>
 <4F846C53.1070407@samsung.com>
Message-ID: <20120511190055.4ED363E0791@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Apr 2012 10:22:27 -0700, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Olof Johansson wrote:
> > Only code move, no functional change.
> >
> > Main reason to do this was to get rid of the warnings:
> >
> > drivers/gpio/gpio-samsung.c: In function 'samsung_gpiolib_init':
> > drivers/gpio/gpio-samsung.c:2974:1: warning: label 'err_ioremap4' defined but not used [-Wunused-label]
> > drivers/gpio/gpio-samsung.c:2722:47: warning: unused variable 'gpio_base4' [-Wunused-variable]
> >
> > without adding more ifdef mess.
> >
> > I think this whole file would do well being coverted over to a platform
> > driver and moving most of the tables out to SoC code and/or device trees,
> > but since that changes init ordering it needs to be done with some care,
> > i.e. not at this time.
> >
> > Signed-off-by: Olof Johansson<olof@lixom.net>
> 
> Looks ok to me :)
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Applied, thanks.

g.
