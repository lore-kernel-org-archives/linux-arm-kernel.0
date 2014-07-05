From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 05 Jul 2014 02:34:07 +0200
Subject: [PATCH] thermal: Add missing cpumask_clear
In-Reply-To: <000101cf97e0$f9ba7a50$ed2f6ef0$@samsung.com>
References: <000001cf9771$e2f465c0$a8dd3140$@samsung.com>
 <CAK5sBcHDTgyj67xVWgtNH-Z7XU1Ykp6m650_mWBVp=Az2P6f=Q@mail.gmail.com>
 <000101cf97e0$f9ba7a50$ed2f6ef0$@samsung.com>
Message-ID: <53B747FF.5010604@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonghwan,

On 05.07.2014 01:37, Jonghwan Choi wrote:
> On Fri, Jul 4, 2014 at 8:23 PM, Sachin Kamat <spk.linux@gmail.com> wrote:
> 
>>> Cpumasks should be cleared before using.
>>
>> Please explain why and what is issue observed without this.
>>
> 
> -> When I checked the mask value, I knew that unwanted bit is set.
> 
> Test code without cpumask_clear.
> 
> +       cpumask_set_cpu(0, &mask_val);
> +       cpulist_scnprintf(buf, 64, &mask_val);
> +       printk("--ID [ %d] = %s \n", id, buf);
> +       th_zone->cool_dev[id] = cpufreq_cooling_register(&mask_val);
> 
> 
> Console message-> 4.861157] [c6] --ID [ 1] = 0,4-5,7 (4,5,7 cpu bit was set.)
> 
> And when I tried to register two cooling devices with cpumask_set_cpu(0, &mask_val) and cpumask_set_cpu(4, &mask_val). 
> 
> I found that cpu 0 bit is also set in latter cpumask. (I hope latter cpumask has a cpu 4 bit.)
> 
> So I think that cpumask_clear should be inserted.

I believe Sachin's concern was related to your patch description. A good
description should say what the patch changes and what is the rationale
behind this change. Also for fixes it is a good practice to specify
observed issues in patch description as well.

Best regards,
Tomasz
