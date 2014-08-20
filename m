From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Aug 2014 07:36:16 +0200
Subject: [PATCH v2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <53F3C5FD.4050808@wwwdotorg.org>
References: <1407957267-3258-1-git-send-email-dgreid@chromium.org>
 <53EF76CF.9050808@suse.de> <53F2255E.7090208@wwwdotorg.org>
 <CAL1qeaH-WfA-DLKwuXA_hBPHYuXksAibLq__zisrT9ALaRGdAw@mail.gmail.com>
 <53F28F90.3000004@wwwdotorg.org>
 <CAL1qeaFnfLDOXq07fY4xLfdRpG8FQ63ya+-0Hk+ewA1wXkLOLw@mail.gmail.com>
 <53F3C5FD.4050808@wwwdotorg.org>
Message-ID: <20140820053614.GB13793@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 03:47:41PM -0600, Stephen Warren wrote:
> On 08/18/2014 06:11 PM, Andrew Bresticker wrote:
> >On Mon, Aug 18, 2014 at 4:43 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >>On 08/18/2014 05:24 PM, Andrew Bresticker wrote:
> >>>
> >>>On Mon, Aug 18, 2014 at 9:10 AM, Stephen Warren <swarren@wwwdotorg.org>
> >>>wrote:
> >>>>
> >>>>On 08/16/2014 09:20 AM, Andreas F?rber wrote:
> >>>>>
> >>>>>
> >>>>>Hi,
> >>>>>
> >>>>>Am 13.08.2014 21:14, schrieb Dylan Reid:
> >>>>>>
> >>>>>>
> >>>>>>The Acer Chromebook 13, codenamed Big, contains an NVIDIA tegra124
> >>>>>>processor and is similar to the Venice2 reference platform.
> >>>>>>
> >>>>>>The keyboard, USB 2, audio, HDMI, sdcard, and emmc have been tested
> >>>>>>and work on the 1266x768 models.  The HD models haven't yet been
> >>>>>>tested.
> >>>>>>
> >>>>>>WiFi does not work yet, it needs at least some PMIC changes to enable
> >>>>>>the 32k clock.
> >>>>>>
> >>>>>>The elan trackpad is not yet functional but hopefully will be soon as
> >>>>>>there are patches under review.
> >>>>>>
> >>>>>>There is also an issue on reboot because the TPM isn't reset.  It will
> >>>>>>cause the stock firmware to enter recovery mode.  This can be worked
> >>>>>>around by an EC-reset, press the refresh and power keys at the same
> >>>>>>time.
> >>>>
> >>>>
> >>>>
> >>>>>>diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts
> >>>>>>b/arch/arm/boot/dts/tegra124-nyan-big.dts
> >>>>>>new file mode 100644
> >>>>>>index 0000000..79f1852
> >>>>>>--- /dev/null
> >>>>>>+++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
> >>>>>>@@ -0,0 +1,1136 @@
> >>>>>>+/dts-v1/;
> >>>>>>+
> >>>>>>+#include <dt-bindings/input/input.h>
> >>>>>>+#include "tegra124.dtsi"
> >>>>>>+
> >>>>>>+/ {
> >>>>>>+       model = "Acer Chromebook 13";
> >>>>>>+       compatible = "google,nyan-big", "nvidia,tegra124";
> >>>>>
> >>>>>
> >>>>>
> >>>>>In light of v1 and the above commit message referring to this as Google
> >>>>>Big, shouldn't this be "google,big", "nvidia,tegra124" and optionally
> >>>>>"google,nyan" as secondary string, independent of the new file name?
> >>>>
> >>>>
> >>>>
> >>>>Despite this board having been derived from Nyan, it isn't Nyan, so I
> >>>>don't
> >>>>think Nyan should be part of any compatible value, nor a separate
> >>>>compatible
> >>>>value.
> >>>
> >>>
> >>>"google,nyan-big" is the compatible string that the bootloader on
> >>>these devices looks for.  It's also the convention we are now using
> >>>for our ARM devices, as Olof has already mentioned.
> >>
> >>I don't understand "that the bootloader looks for"; why is the bootloader
> >>doing anything w.r.t the compatible value in the DT that's passed to the
> >>kernel.
> >
> >The ChromeOS bootloader ("depthcharge") boots FIT images and selects
> >the appropriate device-tree from the image based on the compatible
> >string.  On Big boards, it looks for "google,nyan-big".  This only
> >becomes an issue if there are multiple device-trees in the FIT image.
> >If there's only a single configuration (or you chain-load U-Boot),
> >then the bootloader will boot with that configuration.  If you build a
> >kernel image in the ChromiumOS environment, however, you'll end up
> >with multiple device-trees (all those built by the kernel config at
> >least) in the FIT image - this is what allows us to boot the same
> >binary on different boards.
> 
> This just makes me dislike FIT (and DT ABIs) even more, although I suppose
> the same issue would arise if the DTBs were stored in separate files and
> looked up by filename.
> 
> I have to say this sucks, because it means that a downstream bootloader is
> imposing an ABI on the mainline kernel without a chance to fix things during
> upstreaming. For all other boards, we've concentrated on mainline U-Boot as
> the bootloader precisely so that strange behaviour of our downstream product
> kernels don't force the hand of the mainline kernel design.
> 
> Still, I suppose I have no choice but to drop my objection here.

Do you? We reject things all the time if they're considered not good
enough during upstreaming. The whole DT ABI debate in fact explicitly
resulted in the decision not to take any of the downstream components
into consideration when upstreaming. ABI stability only counts for
things that we've supported in one of the final releases.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140820/c073fc53/attachment-0001.sig>
