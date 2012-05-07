From: r.sricharan@ti.com (R, Sricharan)
Date: Mon, 7 May 2012 19:38:39 +0530
Subject: [PATCH 10/13] ARM: OMAP5: board-generic: Add device tree support.
In-Reply-To: <4FA7CDC1.9050301@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-11-git-send-email-r.sricharan@ti.com>
 <4FA7CDC1.9050301@ti.com>
Message-ID: <CAJ7qFSdBz1ccp0Z-4pWvbq0J0zb6j3Kto4cDz3R0kHT7YfRo0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,
  Thanks for the reviews.

>
>> Adding the minimal support for OMAP5 soc with device tree.
>
>
> You should probably split that patch since you are doing several things that
> are not OMAP5 related.
>
> Do a patch that move the omap_init_irq into the INTC and GIC code first.
>
> Then, you can add a patch to add the OMAP5_DT machine entry.
>
  ok, will split this then accordingly.

[snip]

>> @@ -185,6 +185,8 @@ void omap3_intc_prepare_idle(void);
>> ?void omap3_intc_resume_idle(void);
>> ?void omap2_intc_handle_irq(struct pt_regs *regs);
>> ?void omap3_intc_handle_irq(struct pt_regs *regs);
>> +void omap_of_init_irq(void);
>
>
> In order to be consistent with the GIC function and even the previous ones,
> you should name the exported one:
>
> +void omap_intc_of_init(void);
>
 Ok, will take care of this rename.


>>
>> @@ -279,6 +280,16 @@ int __init omap_intc_of_init(struct device_node
>> *node,
>
>
> And thus rename that one that become a private function without the omap_
> prefix.
>
 ok..

Thanks,
 Sricharan
