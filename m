From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 22 Jul 2014 13:08:14 +0100
Subject: [PATCH 03/19] mfd: tps80031: Fix 'missing break or fall-through
 comment' warning
In-Reply-To: <5230900.iFlbGceLXl@wuerfel>
References: <1406027485-15657-1-git-send-email-lee.jones@linaro.org>
 <1406027485-15657-4-git-send-email-lee.jones@linaro.org>
 <5230900.iFlbGceLXl@wuerfel>
Message-ID: <20140722120814.GA16065@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Jul 2014, Arnd Bergmann wrote:

> On Tuesday 22 July 2014 12:11:09 Lee Jones wrote:
> > --- a/drivers/mfd/tps80031.c
> > +++ b/drivers/mfd/tps80031.c
> > @@ -334,6 +334,7 @@ static bool rd_wr_reg_id1(struct device *dev, unsigned int reg)
> >         case TPS80031_PREQ1_RES_ASS_A ... TPS80031_PREQ3_RES_ASS_C:
> >         case TPS80031_SMPS_OFFSET ... TPS80031_BATDEBOUNCING:
> >         case TPS80031_CFG_INPUT_PUPD1 ... TPS80031_CFG_SMPS_PD:
> > +               /* Fall through */
> >         case TPS80031_BACKUP_REG:
> >                 return true;
> >         default:
> 
> This one seems to make the code look worse: You are only adding the comment
> to one case, not all of them, and it was perfectly understandable
> before.
> 
> Further, there are a couple of other functions following this one that
> also don't have that comment.
> 
> It seems checkpatch missed all the other cases because they contain '...'
> lists, whereas the one above does not. I think it's better left alone.

You're right.  I forgot to remove this patch from the set.

Please see: https://lkml.org/lkml/2014/7/21/223

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
