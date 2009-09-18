From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 18 Sep 2009 18:27:11 +0200
Subject: [PATCH] arm: fix compilation of entry-common.S for older CPUs
In-Reply-To: <1253285745-4198-1-git-send-email-mad_soft@inbox.ru>
References: <1253285745-4198-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <20090918162711.GA31263@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Sep 18, 2009 at 06:55:45PM +0400, Dmitry Artamonow wrote:
> Commit 181f817eaaca4c1f introduced some new code to entry-common.S
> Sadly, this new code uses 'bx' instruction which is available only on
> ARMv5 and higher CPUs. This causes following compilation errors when
> building kernel for StrongARM (ARMv4):
> 
> arch/arm/kernel/entry-common.S: Assembler messages:
> arch/arm/kernel/entry-common.S:129: Error: selected processor does not
>  support `bx ip'
> arch/arm/kernel/entry-common.S:138: Error: selected processor does not
>  support `bx ip'
> 
> Fix these errors by using 'mov pc' instead of 'bx'.
> 
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

I wonder if newer glibc's have the same problem as the code is taken
more or less from there ...

Thanks
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
