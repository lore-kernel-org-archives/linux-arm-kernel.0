From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Mar 2014 15:37:36 +0100
Subject: [PATCH 42/62] ARM: realview: use explicit core tile config options
In-Reply-To: <CACRpkdb2DehqT=KHNAvBpWWPXL5EE+VdAFBDrhTMnbg49h4_+Q@mail.gmail.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-43-git-send-email-arnd@arndb.de>
 <CACRpkdb2DehqT=KHNAvBpWWPXL5EE+VdAFBDrhTMnbg49h4_+Q@mail.gmail.com>
Message-ID: <5495960.YrYnyJeZOK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 March 2014 15:10:31 Linus Walleij wrote:
> On Wed, Mar 19, 2014 at 8:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > The realview platform can be used with numerous core tiles,
> > which have to be enabled in the CPU menu at the moment, and
> > the user has to know at configuration time which CPUs can
> > be enabled in the same kernel.
> >
> > Most importantly, it is not a valid configuration to select
> > both ARMv5 and ARMv6/v7 based CPU cores in the same kernel,
> > and trying that leads to compile errors.
> >
> > To make it possible to use realview on randconfig kernels,
> > and to simplify manual configuration, this lists all
> > supported combinations of machines and core tiles explicitly
> > and ensures that we cannot enable the ARM926T CPU if any
> > ARMv6 or v7 CPU is already enabled.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> 
> Looks good to me, I'd ask Will and/or Marc to have a look at this
> and confirm.

I actually dropped it already, along with the integrator patch
of the same purpose. It will become easier when they are both
multiplatform enabled.

	Arnd
