From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 11 Nov 2013 08:46:33 +0100
Subject: [PATCH v2] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <1383951632-6090-1-git-send-email-sboyd@codeaurora.org>
References: <1383951632-6090-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20131111074633.GG14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Nov 08, 2013 at 03:00:32PM -0800, Stephen Boyd wrote:
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index bd454b0..38621729 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -15,6 +15,12 @@ lib-y		:= backtrace.o changebit.o csumipv6.o csumpartial.o   \
>  		   io-readsb.o io-writesb.o io-readsl.o io-writesl.o  \
>  		   call_with_stack.o
>  
> +lib-$(CONFIG_CPU_V7) += div-v7.o
CPU_V7M could make use of that, too.
(If you follow Nico's advice to use runtime patching I cannot test it
for you on v7-M though as my machine has to use an XIP kernel.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
