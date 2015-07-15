From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jul 2015 16:54:33 +0200
Subject: [PATCH] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <BL2PR03MB338DF493E475876FF6C6038839A0@BL2PR03MB338.namprd03.prod.outlook.com>
References: <1436952778-28000-1-git-send-email-yao.yuan@freescale.com>
 <3074236.7KNCYXgBBY@wuerfel>
 <BL2PR03MB338DF493E475876FF6C6038839A0@BL2PR03MB338.namprd03.prod.outlook.com>
Message-ID: <2042080.Y9rzRSQLpW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 July 2015 10:29:55 Yao Yuan wrote:
> Hi Arnd,
> 
> Thanks for your review.
> And can you give me more information?
> In my opinion, The fsl_edma_pm_state will just be used when CONFIG_PM support. So why not use the #ifdefs to remove the 
> unnecessary code? Since the PM will not be selected in many use cases.

I would consider code readability more important than saving a
few instructions, and the #ifdef interrupts the reading flow.
Another aspect is that the compiler does not produce warnings
for incorrect code in an #ifdef, so we try to use e.g. 'if (IS_ENABLED(CONFIG_FOO))'
instead of '#ifdef CONFIG_FOO' wherever possible.

	Arnd
