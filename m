From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 May 2012 10:49:58 +0800
Subject: [alsa-devel] [PATCH 5/6] ASoC: mxs: add device tree support for
 mxs-sgtl5000
In-Reply-To: <20120511023302.GN6622@shlinux2.ap.freescale.net>
References: <1336639333-11561-1-git-send-email-shawn.guo@linaro.org>
 <1336639333-11561-6-git-send-email-shawn.guo@linaro.org>
 <20120510111646.GL6622@shlinux2.ap.freescale.net>
 <20120510122001.GM17875@S2101-09.ap.freescale.net>
 <20120511023302.GN6622@shlinux2.ap.freescale.net>
Message-ID: <20120511024956.GR17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 10:33:03AM +0800, Dong Aisheng wrote:
> Hmm, even we need to do sanity check, i guess this could be done in
> core since the core will take these nodes as parameter.
> However, after checking the core a bit, i guess the core has already
> done this:
> 
> /* no, then find CPU DAI from registered DAIs*/
> list_for_each_entry(cpu_dai, &dai_list, list) {
> 	if (dai_link->cpu_dai_of_node) {
> 		if (cpu_dai->dev->of_node != dai_link->cpu_dai_of_node)
> 			continue;
> 	} else {
> 		if (strcmp(cpu_dai->name, dai_link->cpu_dai_name))
> 			continue;
> 	}
> 
> 	rtd->cpu_dai = cpu_dai;
> 	goto find_codec;
> }
> 
> It looks if the phandles are not correctly represented, the dai binding
> will fail, right?
> 
Yes, the core will have the sanity check and fail out without reporting
what's exactly going wrong, unless you turn on ASoC core debug option.
So what's harm to have the check in driver to fail out as early as
possible and with the exact message reporting failure cause?

-- 
Regards,
Shawn
