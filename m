From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 30 Sep 2014 14:38:49 -0300
Subject: [PATCH] ASoC: fsl: fix dependencies for wm8962
In-Reply-To: <20140930164510.GF4273@sirena.org.uk>
References: <1950588.ErdGoiHh8p@wuerfel> <20140930164510.GF4273@sirena.org.uk>
Message-ID: <CAOMZO5B3LztUdafDCo8bzLwbmeBB3N-rpQLxXMvb0pXgtGVugA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 1:45 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 30, 2014 at 01:43:41PM +0200, Arnd Bergmann wrote:
>> The wm8962 driver uses the input subsystem, but is selected by
>> SND_SOC_FSL_ASOC_CARD, which can be built with CONFIG_INPUT disabled,
>> resulting in this link error:
>
> That select shouldn't be there in the first place, I asked Nicolin to
> fix this when I applied the driver but he's not got round to it yet.

Would the below change be a proper fix?

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 6164e78..081e406 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -288,9 +288,6 @@ config SND_SOC_FSL_ASOC_CARD
        select SND_SOC_FSL_ESAI
        select SND_SOC_FSL_SAI
        select SND_SOC_FSL_SSI
-       select SND_SOC_CS42XX8_I2C
-       select SND_SOC_SGTL5000
-       select SND_SOC_WM8962
        help
         ALSA SoC Audio support with ASRC feature for Freescale SoCs that have
         ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888
