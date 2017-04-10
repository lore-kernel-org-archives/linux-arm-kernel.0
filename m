From: architt@codeaurora.org (Archit Taneja)
Date: Mon, 10 Apr 2017 10:49:18 +0530
Subject: [PATCH 0/2] drm: dw-hdmi: various improvements
In-Reply-To: <20170407141905.14147-1-romain.perier@collabora.com>
References: <20170407141905.14147-1-romain.perier@collabora.com>
Message-ID: <f0ff38c5-46f0-0702-ca68-ccebf5b8c910@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/07/2017 07:49 PM, Romain Perier wrote:
> This set of patches split the stream handling functions in two parts. It
> introduces new callbacks that are specific to each variant, one for I2S
> and one for AHB.
>
> Then, as requested by the datasheet for the I2S variant, it adds support
> for gating the audio sampler clock when the audio stream is enabled and
> disabled.
>
> This patches series is the continuity of the following discussion:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/493550.html

Since these aren't fixes, could you make sure to redo the patches over:

git://anongit.freedesktop.org/drm-misc drm-misc-next

The dw-hdmi driver is now under drivers/gpu/drm/bridge/synopsis/

Thanks,
Archit

>
> Romain Perier (2):
>   drm: dw-hdmi: add specific I2S and AHB functions for stream handling
>   drm: dw-hdmi: Gate audio clock from the I2S enablement callbacks
>
>  drivers/gpu/drm/bridge/dw-hdmi.c | 45 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 37 insertions(+), 8 deletions(-)
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
