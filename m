From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Oct 2014 10:22:22 +0200
Subject: [PATCH v5 1/6] ARM: cygnus: Initial support for Broadcom Cygnus
 SoC
In-Reply-To: <5446F61C.8060400@broadcom.com>
References: <1413341936-17606-2-git-send-email-sbranden@broadcom.com>
 <38587325.kaAxCWAsmL@wuerfel> <5446F61C.8060400@broadcom.com>
Message-ID: <12157660.uOkg5nk8Dq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 October 2014 17:11:08 Scott Branden wrote:
> OK, I will remove the "iProc SoC based Machine types".  This was 
> grouping all iProc based SoCs under one menu and parallels what the 
> existing "Broadcom Mobile Soc Support" menu does.
>
> I can create another patch removing the "Broadcom Mobile SoC Support" 
> menu if the ARM Maintainer now want all Broadcom devices are supposed to 
> be contained in a single level?

Sounds good, I missed that other menu going in.

It can make sense to add 'comment' statements if you want to separate the
families.

I also noticed that there are a few configuration options that at first
seem pointless: ARCH_BCM_MOBILE_L2_CACHE and ARCH_BCM_MOBILE_SMP. I wonder
if it ever makes sense to disable these when the common options (CACHE_L2X0
and SMP) are enabled for another SoC. I'd normally like to see these as
hidden options that are always on whenever the core support for those
features is enabled, to avoid confusing users as well as bugs from the
combinatorial explosion.

	Arnd
