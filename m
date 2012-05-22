From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 May 2012 06:44:46 +0000
Subject: [PATCH 09/16] ARM: ux500: Provide regulator support for SMSC911x
 via Device Tree
In-Reply-To: <CACRpkdZKDEcntKqTzowCZku+Nwm3Js53Z71iPRWCnY5kXVi0Dg@mail.gmail.com>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
 <1337330355-17747-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdZKDEcntKqTzowCZku+Nwm3Js53Z71iPRWCnY5kXVi0Dg@mail.gmail.com>
Message-ID: <201205220644.46876.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 May 2012, Linus Walleij wrote:
> On Fri, May 18, 2012 at 10:39 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > This patch adds a fixed regulator for use by the SMSC911x Ethernet
> > chip driver into the db8500 Device Tree. It also references other
> > regulators required by the same device.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >  arch/arm/boot/dts/snowball.dts   |   13 +++++++++++++
> >  arch/arm/configs/u8500_defconfig |    1 +
> >  drivers/mfd/db8500-prcmu.c       |    1 +
> 
> We usually don't mix code and defconfig changes in the same patch.

I think it would be good if we did more often ;-)

> Why can't the snowball Kconfig select the fixed regulator instead,
> so you get rid of the defconfig change?

Is it a build dependency or a run-time dependency? I'd say if the
kernel fails to build without enabling the fixed regulator, it
needs to be selected in Kconfig, otherwise I'd prefer to have it
enabled in the defconfig file.

	Arnd
