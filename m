From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 19 Jan 2012 09:13:11 +0100
Subject: [PATCH] ARM: protect usage of cr_alignment by #ifdef
 CONFIG_CPU_CP15
In-Reply-To: <4F173BFC.1040107@gmail.com>
References: <1326732555-17915-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <4F173BFC.1040107@gmail.com>
Message-ID: <20120119081311.GD4066@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ryan,

On Thu, Jan 19, 2012 at 08:39:08AM +1100, Ryan Mallon wrote:
> On 17/01/12 03:49, Uwe Kleine-K?nig wrote:
> There is another reference in this file to cr_alignment:
> 
> #if __LINUX_ARM_ARCH__ >= 4
> #define vectors_high()  (cr_alignment & CR_V)
> #else
> #define vectors_high()  (0)
> #endif
> 
> In our para-virtualised kernel we hardcode the value of vectors_high()
> to 1, however this is might not be the correct thing to do universally
> if !CONFIG_CPU_CP15 && __LINUX_ARM_ARCH__ >= 4.
On Cortex-M3 the concept of high vectors doesn't exist. There is just a
register that gets the address of the vector (that looks quite different
on M3) and is located in the data section. Hm.

Best regards and thanks for the heads up,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
