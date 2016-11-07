From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 7 Nov 2016 14:42:20 +0100
Subject: [PATCH v4 0/3] ASoC/ARM: tegra: apalis t30/tk1/colibri t30:
 sgtl5000 audio
In-Reply-To: <1471355726.4197.6.camel@toradex.com>
References: <1466298002-12576-1-git-send-email-marcel.ziswiler@toradex.com>
 <1471355726.4197.6.camel@toradex.com>
Message-ID: <20161107134220.GA29676@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 01:55:28PM +0000, Marcel Ziswiler wrote:
> On Sun, 2016-06-19 at 02:59 +0200, Marcel Ziswiler wrote:
> > This series adds/integrates Freescale SGTL5000 analogue audio codec
> > support.
> > 
> > Changes in v4:
> > - simple-audio-card does still not allow for more advanced use cases
> > ? like Tegra SoCs
> > - further platform drivers have been accepted since my last attempt
> > ? (e.g. rt5677 one)
> > - relevance for one further board the new Toradex Apalis TK1
> > - drop unused sound/jack.h include
> > - in tegra_sgtl5000_driver_remove() pass return value of
> > ? snd_soc_unregister_card() on to caller
> > - no longer set owner property in platform_driver to THIS_MODULE
> > - re-based/resend
> > 
> > Changes in v3:
> > - revert to not using simple-audio-card being incompatible with tegra
> > - rebased to for-next
> > 
> > Changes in v2:
> > - using simple-audio-card as suggested by Fabio
> > 
> > Marcel Ziswiler (3):
> > ? ASoC: tegra: add tegra sgtl5000 machine driver
> > ? ARM: tegra: apalis/colibri t30: integrate audio
> > ? ARM: tegra: enable sgtl5000 audio
> > 
> > ?.../bindings/sound/nvidia,tegra-audio-sgtl5000.txt |??42 ++++
> > ?arch/arm/boot/dts/tegra30-apalis.dtsi??????????????|??49 +++++
> > ?arch/arm/boot/dts/tegra30-colibri.dtsi?????????????|??49 +++++
> > ?arch/arm/configs/tegra_defconfig???????????????????|???1 +
> > ?sound/soc/tegra/Kconfig????????????????????????????|??11 ++
> > ?sound/soc/tegra/Makefile???????????????????????????|???2 +
> > ?sound/soc/tegra/tegra_sgtl5000.c???????????????????| 212
> > +++++++++++++++++++++
> > ?7 files changed, 366 insertions(+)
> > ?create mode 100644
> > Documentation/devicetree/bindings/sound/nvidia,tegra-audio-
> > sgtl5000.txt
> > ?create mode 100644 sound/soc/tegra/tegra_sgtl5000.c
> 
> With Mark finally having pulled the first patch of this series (https:/
> /lkml.org/lkml/2016/8/15/297) I'm wondering whether the second and
> third patch are now being pulled via tegra tree? Or should I rather re-
> submit those as a new v5 patch set?

Both patches applied now, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/2eb5a3a1/attachment-0001.sig>
