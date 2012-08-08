From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Aug 2012 16:22:29 +0000
Subject: [PATCH 11/11] pm/drivers: fix use of SIMPLE_DEV_PM_OPS
In-Reply-To: <50228889.5060709@wwwdotorg.org>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
 <1344437248-20560-12-git-send-email-arnd@arndb.de>
 <50228889.5060709@wwwdotorg.org>
Message-ID: <201208081622.29777.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 August 2012, Stephen Warren wrote:
> On 08/08/2012 08:47 AM, Arnd Bergmann wrote:
> > A few drivers use a construct like
> > 
> >  #ifdef CONFIG_PM
> >  static int foo_suspend(struct device *pdev)
> >  {
> >     ...
> >  }
> >  static int foo_resume struct device *pdev)
> >  {
> >     ...
> >  }
> >  #endif
> >  static SIMPLE_DEV_PM_OPS(foo_pm, foo_suspend, foo_resume);
> ...
> > drivers/i2c/busses/i2c-tegra.c:716:12: warning: 'tegra_i2c_suspend' defined but not used [-Wunused-function]
> > drivers/i2c/busses/i2c-tegra.c:727:12: warning: 'tegra_i2c_resume' defined but not used [-Wunused-function]
> 
> Laxman already posted a patch for this, which I'm hoping will make it
> into 3.6, through the I2C tree.
> 
> http://www.spinics.net/lists/linux-i2c/msg09359.html

Ok, dropping this one then.

Thanks,

	Arnd
