From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sun, 10 Oct 2010 23:39:33 +0300
Subject: [PATCH 2/3] omap: dsp: fix ioremap() usage
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302342AE533@dbde02.ent.ti.com>
References: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
	<1286732440-28644-3-git-send-email-felipe.contreras@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302342AE533@dbde02.ent.ti.com>
Message-ID: <AANLkTim8HHT3BQSVSZx_2yBo6SZFj+XR-XYrjNZg+ntW@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please remove the chunks you are not replying to.

On Sun, Oct 10, 2010 at 11:17 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -void __init omap_reserve(void)
>> +#if defined(CONFIG_TIDSPBRIDGE) || defined(CONFIG_TIDSPBRIDGE_MODULE)
>
> [sp] I do understand that dspbridge is the only driver accessing dsp in
> ? ? the linux-omap; but there are other known drivers - which would need
> ? ? this feature.

Are you talking about linux-omap the tree? If so, no, the tidspbridge
is part of staging, not linux-omap.

If you are trying to say there are other DSP drivers intended for
OMAP, then I guess you are referring to dsp-link, which uses it's own
tricks for contiguous memory allocation (CMEM).

So, who and how would benefit from this?

> ? ? Can we use a more generic config option viz. CONFIG_RESERVE_DSPMEM
> ? ? (or something similar) so that code is easily (re)usable.

How about CONFIG_OMAP_DSP, and CONFIG_OMAP_DSP_RESERVE_SIZE?

-- 
Felipe Contreras
