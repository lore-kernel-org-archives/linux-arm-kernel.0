From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 27 Mar 2013 11:58:26 +0100
Subject: [PATCH v9 3/3] ARM: ARMv7-M: Allow the building of new kernel port
In-Reply-To: <5152CBEA.1070209@arm.com>
References: <1363901310-9474-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1363901310-9474-4-git-send-email-u.kleine-koenig@pengutronix.de>
 <5152CBEA.1070209@arm.com>
Message-ID: <20130327105826.GJ20530@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonny,

On Wed, Mar 27, 2013 at 10:37:30AM +0000, Jonathan Austin wrote:
> >+# ARMv7M
> >+config CPU_V7M
> >+	bool
> >+	select CPU_32v7M
> >+	select CPU_ABRT_NOMMU
> >+	select CPU_CACHE_NOP
> >+	select CPU_CACHE_VIPT
> 
> What's the deal with VIPT here? I presume something left over?
Right, this was dropped for v10 (as you already pointed it out via irc).

> >+	select CPU_PABRT_LEGACY
> >+	select CPU_THUMBONLY
> >+
> >  config CPU_THUMBONLY
> >  	bool
> >  	# There are no CPUs available with MMU that don't implement an ARM ISA:
> >@@ -441,6 +451,9 @@ config CPU_32v6K
> >  config CPU_32v7
> >  	bool
> >
> >+config CPU_32v7M
> >+	bool
> >+
> 
> What is this config option for?
Just for completeness. There is no use for it (yet).
 
> >  # The abort model
> >  config CPU_ABRT_NOMMU
> >  	bool
> >@@ -494,6 +507,9 @@ config CPU_CACHE_V6
> >  config CPU_CACHE_V7
> >  	bool
> >
> >+config CPU_CACHE_NOP
> >+	bool
> >+
> >  config CPU_CACHE_VIVT
> >  	bool
> >
> >@@ -616,7 +632,11 @@ config ARCH_DMA_ADDR_T_64BIT
> >
> >  config ARM_THUMB
> >  	bool "Support Thumb user binaries" if !CPU_THUMBONLY
> >-	depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V6K || CPU_V7 || CPU_FEROCEON
> >+	depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || \
> >+		CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || \
> >+		CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
> >+		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V6K || \
> >+		CPU_V7 || CPU_FEROCEON || CPU_V7M
> 
> It looks like there has been a rough attempt to order this list...
> 
> Can V7M go before FEROCEON please?
I missed that because I only saw your mail when I sent out v10. :-\

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
