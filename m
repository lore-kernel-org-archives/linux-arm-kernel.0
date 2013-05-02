From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 May 2013 18:24:20 +0200
Subject: [PATCH, RFC 10/22] mfd: ab8500: debugfs code depends on gpadc
In-Reply-To: <20130502153624.GN25256@gmail.com>
References: <1367507786-505303-1-git-send-email-arnd@arndb.de>
 <1367507786-505303-11-git-send-email-arnd@arndb.de>
 <20130502153624.GN25256@gmail.com>
Message-ID: <201305021824.20548.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 02 May 2013, Lee Jones wrote:
> > @@ -580,7 +580,7 @@ config AB8500_CORE
> >  
> >  config AB8500_DEBUG
> >         bool "Enable debug info via debugfs"
> > -       depends on AB8500_CORE && DEBUG_FS
> > +       depends on AB8500_GPADC && DEBUG_FS
> >         default y if DEBUG_FS
> >         help
> >           Select this option if you want debug information using the debug
> 
> Did you find this with ALLCONFIG out of interest.

I used "make randconfig" with this KCONFIG_ALLCONFIG file:

CONFIG_MMU=y
CONFIG_ARCH_MULTI_V7=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_PROC_FS=y
 
> Applied by the way.

Thanks!

	Arnd
