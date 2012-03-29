From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 30 Mar 2012 00:09:19 +0800
Subject: [PATCH] ASoC: fsl: enable ssi clock in probe function
In-Reply-To: <4F748751.3020300@freescale.com>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
 <20120329112949.GM3668@opensource.wolfsonmicro.com>
 <4F748751.3020300@freescale.com>
Message-ID: <20120329160916.GG19506@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 11:01:21AM -0500, Timur Tabi wrote:
> Mark Brown wrote:
> > Applied, thanks (though checking return codes would be nice).  
> 
> Speaking of return codes, I can't even get ASoC for-3.5 to compile:
> 
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
> 'soc_bind_dai_link':
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:805:11: error:
> 'EPROBE_DEFER' undeclared (first use in this function)
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:805:11: note: each
> undeclared identifier is reported only once for each function it appears in
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
> 'soc_check_aux_dev':
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:1346:10: error:
> 'EPROBE_DEFER' undeclared (first use in this function)
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
> 'soc_probe_aux_dev':
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:1369:10: error:
> 'EPROBE_DEFER' undeclared (first use in this function)
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c: In function
> 'soc_check_aux_dev':
> /home/b04825/git/linux.ssi-clk/sound/soc/soc-core.c:1347:1: warning:
> control reaches end of non-void function
> 
Yes.  To build the branch, we have to revert the commit below.

d18b63ab0b04af1bad01e59a96b88fc8cda08752
ASoC: core: Use driver core probe deferral

-- 
Regards,
Shawn
