From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Oct 2014 18:54:02 +0100
Subject: [PATCH v3 1/3] ASoC: tegra: add tegra sgtl5000 machine driver
In-Reply-To: <74ea4fe20e653d2da555c8d7dd1478746bccd529.1412381377.git.marcel@ziswiler.com>
References: <cover.1412381377.git.marcel@ziswiler.com>
 <74ea4fe20e653d2da555c8d7dd1478746bccd529.1412381377.git.marcel@ziswiler.com>
Message-ID: <20141007175402.GT4609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 04, 2014 at 02:15:43AM +0200, Marcel Ziswiler wrote:
> This binding and driver describe/support playback to headphones, and
> capture from line-in and microphone.
> 
> This driver is useful for the Toradex Apalis T30 and Colibri T30 modules.
> 
> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> ---
> Changes in v3:
> - Revert to not using simple-audio-card being incompatible with tegra.
> - Rebased to for-next.

I can't help but think that't there's still room for a Tegra simple card
here, there doesn't seem to be anything particularly CODEC specific
about the driver here - it *could* use simple-card were it not for the
CPU side.  This also seems like a specific example of the same problem
we see with supporting DPCM in simple-card, we need a way for CPUs to
be able to say that they need some general setup that covers the CPU
internal configuration.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/f251941f/attachment.sig>
