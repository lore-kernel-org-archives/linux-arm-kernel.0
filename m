From: nm@ti.com (Nishanth Menon)
Date: Mon, 21 Jul 2014 06:22:24 -0500
Subject: [RFC PATCH 4/7] ARM: OMAP4+: PRM: register interrupt information
 from DT
In-Reply-To: <20140721105149.GU18374@atomide.com>
References: <1402025761-16831-1-git-send-email-nm@ti.com>
 <1402025761-16831-5-git-send-email-nm@ti.com>
 <20140721105149.GU18374@atomide.com>
Message-ID: <CAGo_u6q2NOxWVG3LOfAyk8qLZss5N6MxCvYkf-yN8c4ec4mftw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 5:51 AM, Tony Lindgren <tony@atomide.com> wrote:
>
>> +static struct of_device_id omap_prm_dt_match_table[] = {
>> +     { .compatible = "ti,omap4-prm" },
>> +     { .compatible = "ti,omap5-prm" },
>> +     { .compatible = "ti,dra7-prm" },
>> +     { }
>> +};
>> +
>
> I'd like to avoid adding more driver like stuff to mach-omap2
> and parsing compatible flags and dealing with interupts sounds
> very driver like.. But maybe just the handling can be moved
> out?

I understand your view, but, Handling of interrupts is already in
place even now in mach-omap2. Currently the prm devices are handled by
mach-omap2 and all this does it to prevent hardcoding of irq numbers
within the current code.
>
> Would a simple driver be doable that parses the compatible
> flags, takes care of the IRQ chaining, and gets some SoC specific
> function pointers as auxdata?

Tero has been trying to move PRM/CM stuff to a separate drivers of
thier own. With that there wont be a need for auxdata even. - this
current logic will get merged with that driver - if and when that is
ready. I am not actually adding any driver logic here - just reusing
the logic and providing glue for using dt description instead of
hardcoded logic that the current mach-omap2 driver does.

>
> That would allow further work later on to remove the auxdata
> dependencies possibly.




-- 
---
Regards,
Nishanth Menon
