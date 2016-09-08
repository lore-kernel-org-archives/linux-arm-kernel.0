From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 10:15:25 +0200
Subject: [PATCH v3 2/3] hwmon: xgene: Add hwmon driver
In-Reply-To: <20160907222754.GA31475@roeck-us.net>
References: <1469134557-26869-1-git-send-email-hotran@apm.com>
 <13081573.BbD3TmEU5Y@wuerfel> <20160907222754.GA31475@roeck-us.net>
Message-ID: <8664936.LICyesLN7G@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 7, 2016 3:27:54 PM CEST Guenter Roeck wrote:
> On Wed, Sep 07, 2016 at 11:41:44PM +0200, Arnd Bergmann wrote:
> > On Thursday, July 21, 2016 1:55:56 PM CEST Hoan Tran wrote:
> > > +               ctx->comm_base_addr = cppc_ss->base_address;
> > > +               if (ctx->comm_base_addr) {
> > > +                       ctx->pcc_comm_addr =
> > > +                                       acpi_os_ioremap(ctx->comm_base_addr,
> > > +                                                       cppc_ss->length);
> > > 
> > 
> > This causes the arm64 allmodconfig build to fail now, according to
> > kernelci:
> > 
> >       1  ERROR: "memblock_is_memory" [drivers/hwmon/xgene-hwmon.ko] undefined!
> > 
> How do you even get there ? arm64:allmodconfig fails for me in -next with
> 
> drivers/pwm/pwm-berlin.c: In function ?berlin_pwm_suspend?:
> drivers/pwm/pwm-berlin.c:245:35: error: ?struct berlin_pwm_chip? has no member named ?chips?

That was fixed in yesterday's linux-next.

	Arnd
