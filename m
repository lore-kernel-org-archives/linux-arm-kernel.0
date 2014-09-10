From: nicoleotsuka@gmail.com (Nicolin Chen)
Date: Wed, 10 Sep 2014 11:07:36 -0700
Subject: [PATCH 2/5] ASoC: fsl: add imx-tlv320aic3x machine driver
In-Reply-To: <1410356809-26179-3-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410356809-26179-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410356809-26179-3-git-send-email-d.lavnikevich@sam-solutions.com>
Message-ID: <20140910180735.GB4628@Asurada>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,
   
On Wed, Sep 10, 2014 at 04:46:46PM +0300, Dmitry Lavnikevich wrote:
> This is driver for i.MX6 boards with tlv320aic3x audio codecs.
> 
> Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
> ---
>  .../bindings/sound/fsl,imx-audio-tlv320aic3x.txt   |  27 ++++
>  sound/soc/fsl/Kconfig                              |  13 ++
>  sound/soc/fsl/Makefile                             |   2 +
>  sound/soc/fsl/imx-tlv320aic3x.c                    | 177 +++++++++++++++++++++
>  4 files changed, 219 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio-tlv320aic3x.txt
>  create mode 100644 sound/soc/fsl/imx-tlv320aic3x.c

This whole single patch looks pretty clean. So I suggest it may be merged
into fsl-asoc-card.c driver whose DT binding is almost identical to yours
so that we don't need to add a machine driver with duplicated code. And
you can feel free to enable fsl-asoc-card in the defconfig as well -- I
was about to do it and to replace imx-wm8962 and imx-sgtl5000 with it.

The only extra trivia you need to tackle is to add a clock binding into
your dts for CODEC side.

Thanks
Nicolin
