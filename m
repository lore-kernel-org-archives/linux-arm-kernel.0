From: broonie@kernel.org (Mark Brown)
Date: Fri, 21 Nov 2014 18:58:56 +0000
Subject: [PATCH] ASoC: rockchip: i2s: Add dependency to I2S device driver
In-Reply-To: <1416594913-30187-1-git-send-email-rupran@einserver.de>
References: <1416594913-30187-1-git-send-email-rupran@einserver.de>
Message-ID: <20141121185856.GJ3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 07:35:13PM +0100, Andreas Ruprecht wrote:
> Currently, CONFIG_SND_SOC_ROCKCHIP_I2S could also be selected
> without having CONFIG_SND_SOC_ROCKCHIP enabled.
> 
> As this makes no sense (and breaks the build, when the option
> CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM - which would be selected by
> CONFIG_SND_SOC_ROCKCHIP - is not enabled), a Kconfig dependency
> is added to CONFIG_SND_SOC_ROCKCHIP_I2S. This will make the item
> visible only if CONFIG_SND_SOC_ROCKCHIP is enabled.

This doesn't seem like an obvious fix - why is the fix not to put the
select on the I2S driver (which is the thing that actually depends on
the dmaengine stuff)?  
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141121/2d6e67dd/attachment.sig>
