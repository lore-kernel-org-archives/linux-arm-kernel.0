From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Aug 2015 16:35:41 +0100
Subject: [PATCH v5 4/6] drm: bridge/dw_hdmi-i2s-audio: add audio driver
In-Reply-To: <1434731295-11060-1-git-send-email-ykk@rock-chips.com>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
 <1434731295-11060-1-git-send-email-ykk@rock-chips.com>
Message-ID: <20150808153540.GL7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 20, 2015 at 12:28:15AM +0800, Yakir Yang wrote:
> Add ALSA based HDMI I2S audio driver for dw_hdmi. Sound card
> driver could connect to this codec through the codec dai name
> "dw-hdmi-i2s-audio".

I'm applying this patch to my tree with some changes.  I haven't seen
anyone ack it, nor review it any further.  I'm hoping someone can ack
this patch with the following changes below - I'll be posting it as
part of my dw-hdmi devel updates later today.

> +	ret = request_irq(dw->data.irq, snd_dw_hdmi_irq, IRQF_SHARED,
> +			  "dw-dw-audio", dw);

			  DRIVER_NAME, dw);

> +MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
> +MODULE_DESCRIPTION("DW dw Audio ASoC Interface");

Fixing this to be "Synopsis DesignWare HDMI I2S ASoC interface".

> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS(PLATFORM_MODULE_PREFIX DRIVER_NAME);

Replacing PLATFORM_MODULE_PREFIX with the "platform:" string.

> +	if (hdmi_readb(hdmi, HDMI_CONFIG1_ID) & HDMI_CONFIG1_AHB) {
>  		pdevinfo.name = "dw-hdmi-ahb-audio";

Fixing this to be "dw-hdmi-i2s-audio".

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
