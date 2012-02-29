From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 20:13:26 +0000
Subject: [PATCH] ARM: ux500: solve some Kconfig mess
In-Reply-To: <CACRpkdaqdmB0_Z9FYC97FWZ2+RBSMfErUa62y0icqSOqAo8o1g@mail.gmail.com>
References: <1330536509-13590-1-git-send-email-linus.walleij@stericsson.com>
 <201202291928.49516.arnd@arndb.de>
 <CACRpkdaqdmB0_Z9FYC97FWZ2+RBSMfErUa62y0icqSOqAo8o1g@mail.gmail.com>
Message-ID: <201202292013.26661.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 February 2012, Linus Walleij wrote:
> On Wed, Feb 29, 2012 at 8:28 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > Looks good to me. One thing I still wonder about is whether
> > we should leave the UX500_SOC_DB5500 and UX500_SOC_DB8500
> > options user-visible. It would probably be simpler to just
> > select these whenever a board using them is enabled.
> 
> They are invisible to me atleast?
> 
> config UX500_SOC_DB5500
>         bool
>         select MFD_DB5500_PRCMU
> 
> config UX500_SOC_DB8500
>         bool
>         select MFD_DB8500_PRCMU
>         select REGULATOR_DB8500_PRCMU
>         select CPU_FREQ_TABLE if CPU_FREQ
> 

Ah, I forgot that I had actually done that patch myself and
Mathieu sent it last week, so now it's in your tree but not mine.

Nevermind then.

	Arnd
