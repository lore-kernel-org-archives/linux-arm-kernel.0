From: cjb@laptop.org (Chris Ball)
Date: Wed, 13 Jun 2012 12:37:43 -0400
Subject: [PATCH v2 0/5] mmp audio support
In-Reply-To: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
 (Zhangfei Gao's message of "Mon, 11 Jun 2012 18:04:36 +0800")
References: <1339409081-10097-1-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <87y5nrw4ko.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhangfei,

On Mon, Jun 11 2012, Zhangfei Gao wrote:
> v1->v2:
> modify accroingly with suggestion from Vinod and Mark
> remove deprecated chan->private and dma.h
> remove prep_slave_sg
> remove module_init and move operation to probe
> misc change
>
> v0->v1: 
> dmaengine -> soc-dmaengine.
> update according to Mark's suggestion
>
> These patches provide mmp audio support under alsa via dmaengine
> Support platfrom pxa688 and pxa910
> mmp_tdma.c and mmp-pcm.c is shared for pxa688 and pxa910
> pxa688 (mmp2) use mmp2-sspa.c
> pxa910 directly use pxa-ssp.c
> mmp_tdma.c is under dmaengine framework
>
> Verified on brownstone (pxa688) and ttc-dkb

Great, we're looking into adopting this for OLPC XO-1.75 too.

Could you explain how system suspend/resume should work with this
patchset?  You don't seem to be adding any suspend/resume handlers.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
