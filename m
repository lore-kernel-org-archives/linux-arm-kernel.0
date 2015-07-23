From: drinkcat@chromium.org (Nicolas Boichat)
Date: Thu, 23 Jul 2015 16:45:53 +0800
Subject: [PATCHv2 0/3] regmap: Use different lockdep class for each regmap
 init call
In-Reply-To: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
References: <1436337018-32464-1-git-send-email-drinkcat@chromium.org>
Message-ID: <CANMq1KD8rOHjtWA1Eiw9GATdTeq1Ch4bga4ZAty26auvWyX7Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Jul 8, 2015 at 2:30 PM, Nicolas Boichat <drinkcat@chromium.org> wrote:
> Second version. Small fixup in the regmap patch itself [3/3] (the
> declaration of __devm_regmap_init_ac97 was missing lock_key/name
> parameters).
>
> Also, there are 2 drivers that are using function pointers named
> "regmap_init", which causes problems as it is now a macro: put these
> in parentheses to prevent the preprocessor from substituting them.
>
> Patches 1+2 should be pushed first to avoid breaking git bissect.
>
> Compile tested with allyesconfig on x86_64 and arm.
>
> Nicolas Boichat (3):
>   mfd: vexpress: Add parentheses around bridge->ops->regmap_init call
>   thermal: sti: Add parentheses around bridge->ops->regmap_init call
>   regmap: Use different lockdep class for each regmap init call

What's the status of this series (and the additional documentation
fix: https://lkml.org/lkml/2015/7/8/385)?

Do we need acks from the mfd/vexpress and thermal maintainers?
(mfd/vexpress maintainers are Liviu Dudau, Sudeep Holla, and Lorenzo
Pieralisi, I'm less clear about thermal, maybe Eduardo Valentin?)

Thanks!
