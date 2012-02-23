From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 23 Feb 2012 07:10:39 +0100
Subject: [PATCH v3 09/10] pwm: Add PXA support
In-Reply-To: <201202221540.16897.arnd@arndb.de>
References: <1329923841-32017-1-git-send-email-thierry.reding@avionic-design.de>
 <1329923841-32017-10-git-send-email-thierry.reding@avionic-design.de>
 <201202221540.16897.arnd@arndb.de>
Message-ID: <20120223061039.GB21091@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann wrote:
> On Wednesday 22 February 2012, Thierry Reding wrote:
> > 
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> > Changes in v3:
> >   - update PWM ops for changes in patch 2
> > 
> >  arch/arm/plat-pxa/Makefile |    1 -
> >  arch/arm/plat-pxa/pwm.c    |  304 --------------------------------------------
> >  drivers/pwm/Kconfig        |    9 ++
> >  drivers/pwm/Makefile       |    1 +
> >  drivers/pwm/pwm-pxa.c      |  244 +++++++++++++++++++++++++++++++++++
> >  5 files changed, 254 insertions(+), 305 deletions(-)
> >  delete mode 100644 arch/arm/plat-pxa/pwm.c
> >  create mode 100644 drivers/pwm/pwm-pxa.c
> 
> Since most of this patch is a move of one file, it would help to use the -M
> flag to git-format-patch so we can see the actual change.

Okay, I'll make a note and see how that works out in the next version.

> To make it even more explicit, you could separate the patches that move the
> files around from the ones that convert the drivers to the new API.

Sascha already mentioned that he has all of the in-tree drivers converted to
the PWM framework, so if it is acceptable I'll leave that up to him. This
series ports the Blackfin and PXA drivers merely as reference drivers to test
the framework.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120223/2ca01bd4/attachment.sig>
