From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 23 Jul 2015 17:12:50 +0100
Subject: [PATCHv2 0/3] regmap: Use different lockdep class for each
 regmap init call
In-Reply-To: <CANMq1KD8rOHjtWA1Eiw9GATdTeq1Ch4bga4ZAty26auvWyX7Og@mail.gmail.com>
References: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
 <CANMq1KD8rOHjtWA1Eiw9GATdTeq1Ch4bga4ZAty26auvWyX7Og@mail.gmail.com>
Message-ID: <20150723161250.GA19124@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 09:45:53AM +0100, Nicolas Boichat wrote:
> Hi Mark,
> 
> On Wed, Jul 8, 2015 at 2:30 PM, Nicolas Boichat <drinkcat@chromium.org> wrote:
> > Second version. Small fixup in the regmap patch itself [3/3] (the
> > declaration of __devm_regmap_init_ac97 was missing lock_key/name
> > parameters).
> >
> > Also, there are 2 drivers that are using function pointers named
> > "regmap_init", which causes problems as it is now a macro: put these
> > in parentheses to prevent the preprocessor from substituting them.
> >
> > Patches 1+2 should be pushed first to avoid breaking git bissect.
> >
> > Compile tested with allyesconfig on x86_64 and arm.
> >
> > Nicolas Boichat (3):
> >   mfd: vexpress: Add parentheses around bridge->ops->regmap_init call
> >   thermal: sti: Add parentheses around bridge->ops->regmap_init call
> >   regmap: Use different lockdep class for each regmap init call
> 
> What's the status of this series (and the additional documentation
> fix: https://lkml.org/lkml/2015/7/8/385)?
> 
> Do we need acks from the mfd/vexpress and thermal maintainers?
> (mfd/vexpress maintainers are Liviu Dudau, Sudeep Holla, and Lorenzo
> Pieralisi, I'm less clear about thermal, maybe Eduardo Valentin?)

Hi Nicolas,

Me and Lorenzo are currently tied with other tasks this week, hope to be
able to review your patches next week.

Best regards,
Liviu

> 
> Thanks!
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
