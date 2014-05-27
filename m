From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 27 May 2014 14:01:49 +0200
Subject: [PATCH 1/1] ARM: mvebu: Staticize local variables
In-Reply-To: <CAK9yfHxm27Rg3YcXTfSff7LAmYsj-VFBgBKXBXiD8SXGGYfFzQ@mail.gmail.com>
References: <1401190629-24559-1-git-send-email-sachin.kamat@linaro.org>
 <20140527135108.1642833b@free-electrons.com>
 <CAK9yfHxm27Rg3YcXTfSff7LAmYsj-VFBgBKXBXiD8SXGGYfFzQ@mail.gmail.com>
Message-ID: <20140527140149.177dc810@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sachin Kamat,

On Tue, 27 May 2014 17:24:10 +0530, Sachin Kamat wrote:

> >>       unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
> >>       u32 reg;
> >> @@ -263,7 +263,7 @@ static struct notifier_block
> >> armada_370_xp_cpu_pm_notifier = { .notifier_call =
> >> armada_370_xp_cpu_pm_notify, };
> >>
> >> -int __init armada_370_xp_cpu_pm_init(void)
> >> +static int __init armada_370_xp_cpu_pm_init(void)
> >
> > Indeed, this one needs to be fixed.
> 
> How do you want me to handle this?

Maybe send a new patch that fixes just that one?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
