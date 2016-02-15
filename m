From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Feb 2016 11:58:34 +0100
Subject: [PATCH] dma: mv_xor_v2: new driver
In-Reply-To: <56C1A17F.9030206@arm.com>
References: <1455523083-25506-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201602151735.BaFwBMOn%fengguang.wu@intel.com>
 <20160215105008.74aa7869@free-electrons.com>
 <56C1A17F.9030206@arm.com>
Message-ID: <20160215115834.60f4e559@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 15 Feb 2016 09:59:27 +0000, Marc Zyngier wrote:

> Seems like something is selecting GENERIC_MSI_IRQ_DOMAIN on a system
> that doesn't implement the required bits.
> 
> It may be that we need to implement something like
> HAS_GENERIC_MSI_IRQ_DOMAIN, and make GENERIC_MSI_IRQ_DOMAIN conditional
> on that. Or just whitelist the architectures that do implement this.
> 
> Any chance you could have a closer look?

I'll have a look. However, in the mean time, I will probably make this
new driver depend on ARM64 so that it does not depend on other patches
touching the MSI mechanism.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
