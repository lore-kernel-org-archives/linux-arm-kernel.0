From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Dec 2013 21:58:34 +0100
Subject: [PATCH v3 3/6] pinctrl: Make PINCTRL selectable by
 defconfig/menuconfig
In-Reply-To: <CACRpkdY-MM7OoMq_L90YRADy=oaDoV1wAOccVz90LqfRfEh=3Q@mail.gmail.com>
References: <1381174108-25168-1-git-send-email-syin@broadcom.com>
 <20131217001842.GB3840@sonymobile.com>
 <CACRpkdY-MM7OoMq_L90YRADy=oaDoV1wAOccVz90LqfRfEh=3Q@mail.gmail.com>
Message-ID: <201312202158.34805.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 December 2013, Linus Walleij wrote:
> On Tue, Dec 17, 2013 at 1:18 AM, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
> 
> > No matter how we build the individual pinctrl drivers we will always
> > need the pinctrl framework in a multi-soc zImage; so I can't see that
> > we gain anything from being able to compile PINCTRL as a module.
> 
> I discussed this matter with Christian on IRC and I believe we could
> basically do "select PINCTRL" on ARCH_MULTIPLATFORM as the
> vast majority of multiplatforms appear to be using this anyway, this
> would make the submenu for pin control pop up in menuconfig
> for this, and make it possible to move different subdrivers to modules
> if desired.
> 
> MULTIPLATFORM does not seem to be about saving footprint bytes
> on a very fine-granular level anyway, more about doing the module
> loading/unloading approach to footprint.

Let's review the list of platforms that don't select PINCTRL. There
are some platforms that are indeed sensitive about memory footprint,
and I promised people that converting to multiplatform won't cause
a significant increase in kernel binary size as long as no other
platforms are enabled.

	Arnd
