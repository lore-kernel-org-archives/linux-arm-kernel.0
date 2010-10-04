From: eric@eukrea.com (=?UTF-8?B?RXJpYyBCw6luYXJk?=)
Date: Mon, 04 Oct 2010 14:07:32 +0200
Subject: I.MX35 GPIO IRQ + Preempt -> Oops
In-Reply-To: <4CA98B8C.4010106@eukrea.com>
References: <4CA739B4.1020506@eukrea.com>	<20101003114103.GC32736@n2100.arm.linux.org.uk>	<4CA8A06B.3070103@eukrea.com>	<20101003162021.GD32736@n2100.arm.linux.org.uk>	<4CA8BA29.5060600@eukrea.com>	<20101004073920.GM28679@pengutronix.de>
	<4CA98B8C.4010106@eukrea.com>
Message-ID: <4CA9C384.2070208@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

Le 04/10/2010 10:08, Eric B?nard a ?crit :
 > Le 04/10/2010 09:39, Uwe Kleine-K?nig a ?crit :
 >> On Sun, Oct 03, 2010 at 07:15:21PM +0200, Eric B?nard wrote:
 >>> Le 03/10/2010 18:20, Russell King - ARM Linux a ?crit :
 >>> the FIQ is used for the imx-ssi driver.
 >>>
 >>> It seems that removing the cpu_do_idle() call in
 >>> plat-mxc/include/mach/system.h "fix" the problem.
 >> hmmm
 >>
 >> Does deselecting imx-ssi "fixes" the problem, too?
 >>
 > not tested yet.
 >
same problem with audio layer (and thus FIQ) disabled.

Also : same problem with Freescale's BSP (2.6.31 based) and same "fix" 
(removing the WFI).

Eric
