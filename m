From: broonie@kernel.org (Mark Brown)
Date: Sat, 16 Nov 2013 09:44:12 +0000
Subject: [PATCH 15/31] ASoC: dmaengine: add custom DMA config to
 snd_dmaengine_pcm_config
In-Reply-To: <1384548866-13141-16-git-send-email-swarren@wwwdotorg.org>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-16-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131116094412.GD15393@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 01:54:10PM -0700, Stephen Warren wrote:

> - DMA device

>   This allows requesting DMA channels for a device other than the device
>   which is registering the "PCM" driver. This is quite unusual, but is
>   currently useful on Tegra. In much HW, and in Tegra20, each DAI HW

Acked-by: Mark Brown <broonie@linaro.org>

but this one especially I'd like to get into ASoC as soon as possible
since this one should be being used by other things.

I'm a bit concerned about anything actually using dma_dev since it
indicates that something is being worked around, it'd be a bit nicer to
print a warning when doing this to give people a hint that they might
not be doing the right thing if they use it (unless someone comes up
with a system that has a clear use case for it).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131116/5a376f34/attachment.sig>
