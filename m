From: yao.yuan@freescale.com (Yao Yuan)
Date: Thu, 16 Jul 2015 08:01:38 +0000
Subject: [PATCH] dmaengine: fsl-edma: add PM suspend/resume support
In-Reply-To: <2042080.Y9rzRSQLpW@wuerfel>
References: <1436952778-28000-1-git-send-email-yao.yuan@freescale.com>
 <3074236.7KNCYXgBBY@wuerfel>
 <BL2PR03MB338DF493E475876FF6C6038839A0@BL2PR03MB338.namprd03.prod.outlook.com>
 <2042080.Y9rzRSQLpW@wuerfel>
Message-ID: <BL2PR03MB3380E34F751336BA0C0C5F283990@BL2PR03MB338.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,
Ok, I will remove the #ifdef in the next version.
Thanks.

Hi All,
Is there any others comments?

Thanks for your review.

Best Regards,
Yuan Yao

On Wednesday, July 15, 2015 10:55 PM Arnd wrote:
> On Wednesday 15 July 2015 10:29:55 Yao Yuan wrote:
> > Hi Arnd,
> >
> > Thanks for your review.
> > And can you give me more information?
> > In my opinion, The fsl_edma_pm_state will just be used when CONFIG_PM
> > support. So why not use the #ifdefs to remove the unnecessary code? Since
> the PM will not be selected in many use cases.
> 
> I would consider code readability more important than saving a few instructions,
> and the #ifdef interrupts the reading flow.
> Another aspect is that the compiler does not produce warnings for incorrect
> code in an #ifdef, so we try to use e.g. 'if (IS_ENABLED(CONFIG_FOO))'
> instead of '#ifdef CONFIG_FOO' wherever possible.
> 
> 	Arnd
