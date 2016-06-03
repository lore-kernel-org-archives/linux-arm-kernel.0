From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 3 Jun 2016 13:39:58 +0100
Subject: [PATCH v4 11/18] ARM: multi_v7_defconfig: Enable STi and
 simple-card drivers.
In-Reply-To: <574D5178.5030200@st.com>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
 <1464192412-16386-13-git-send-email-peter.griffin@linaro.org>
 <574D5178.5030200@st.com>
Message-ID: <20160603123958.GA9912@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On Tue, 31 May 2016, Arnaud Pouliquen wrote:

> Hi Peter,
> 
> On 05/25/2016 06:06 PM, Peter Griffin wrote:
> > This patch enables the STi ALSA drivers found on STi platforms
> > as well as the simple-card driver which is a dependency to have
> > working sound.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > Cc: arnaud.pouliquen at st.com
> > Cc: broonie at kernel.org
> > ---
> >  arch/arm/configs/multi_v7_defconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> > index 5eee45b..0ced665 100644
> > --- a/arch/arm/configs/multi_v7_defconfig
> > +++ b/arch/arm/configs/multi_v7_defconfig
> > @@ -589,6 +589,9 @@ CONFIG_SND_SOC_AK4642=m
> >  CONFIG_SND_SOC_SGTL5000=m
> >  CONFIG_SND_SOC_SPDIF=m
> >  CONFIG_SND_SOC_WM8978=m
> > +CONFIG_SND_SOC_STI=m
> > +CONFIG_SND_SOC_STI_SAS=m
> > +CONFIG_SND_SIMPLE_CARD=m
> Simple card config seems enabled by default, at least on 4.7 rc1.

I don't think it is currently, I get the following when greping v4.7-rc1 tag

git grep CONFIG_SND_SIMPLE_CARD
arch/arm/configs/exynos_defconfig:CONFIG_SND_SIMPLE_CARD=y
arch/arm/configs/imx_v6_v7_defconfig:CONFIG_SND_SIMPLE_CARD=y
arch/arm/configs/multi_v5_defconfig:CONFIG_SND_SIMPLE_CARD=y
arch/arm/configs/mvebu_v5_defconfig:CONFIG_SND_SIMPLE_CARD=y
arch/arm/configs/mvebu_v7_defconfig:CONFIG_SND_SIMPLE_CARD=y
arch/arm/configs/omap2plus_defconfig:CONFIG_SND_SIMPLE_CARD=m
arch/arm/configs/pxa_defconfig:CONFIG_SND_SIMPLE_CARD=m
arch/xtensa/configs/audio_kc705_defconfig:CONFIG_SND_SIMPLE_CARD=y
sound/soc/generic/Makefile:obj-$(CONFIG_SND_SIMPLE_CARD)        +=
snd-soc-simple-card.o

Although maybe it should be built-in rather than a module, like multi_v5_defconfig.

regards,

Peter
