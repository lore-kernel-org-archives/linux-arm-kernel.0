From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Apr 2012 11:32:07 +0100
Subject: linux-next: "amba: Remove AMBA level regulator support" commit.
In-Reply-To: <CAAQ0ZWReL=+bm9UOnt2=Dfy0zeWbJe3=y3pPzUKRzm2y277kFQ@mail.gmail.com>
References: <20120413012230.GA30438@windriver.com>
 <CAAQ0ZWReL=+bm9UOnt2=Dfy0zeWbJe3=y3pPzUKRzm2y277kFQ@mail.gmail.com>
Message-ID: <20120413103207.GL24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 13, 2012 at 10:01:52AM +0800, Shawn Guo wrote:
> On 13 April 2012 09:22, Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> > Hi Mark,
> >
> > The commit in linux-next:
> >
> > -----------------
> > commit b2bc9e0ee349db84035d8141e85babc7986594d7
> > Author: Mark Brown <broonie@sirena.org.uk>
> > Date: ? Mon Apr 2 12:30:35 2012 +0100
> >
> > ? ?ARM: 7366/1: amba: Remove AMBA level regulator support
> > -----------------
> >
> > is pointed at by git bisect for the u8500_defconfig build failure:
> >
> > drivers/dma/ste_dma40.c:2708:3: error: implicit declaration of function
> > 'regulator_disable' [-Werror=implicit-function-declaration]
> > drivers/dma/ste_dma40.c:2747:3: error: implicit declaration of function
> > 'regulator_enable' [-Werror=implicit-function-declaration]
> > drivers/dma/ste_dma40.c:3260:3: error: implicit declaration of function
> > 'regulator_get' [-Werror=implicit-function-declaration]
> > drivers/dma/ste_dma40.c:3271:4: error: implicit declaration of function
> > 'regulator_put' [-Werror=implicit-function-declaration]
> >
> That's because Mark's patch removes "#include
> <linux/regulator/consumer.h>" included indirectly by
> drivers/dma/ste_dma40.c from linux/amba/bus.h.  The ste_dma40.c should
> really directly includes consumer.h.

Okay, I'll drop this patch because it's causing regressions, so it can't
be pushed as a 'fix' during -rc.
