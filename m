From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Dec 2014 12:00:13 +0000
Subject: [RFC PATCH 0/6] Those patches is used for dw_hdmi audio.
In-Reply-To: <548ECB66.70004@rock-chips.com>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
 <20141215103830.GD11285@n2100.arm.linux.org.uk>
 <548EC9E1.5040206@rock-chips.com> <548ECB66.70004@rock-chips.com>
Message-ID: <20141215120013.GH11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 07:52:06PM +0800, Kuankuan.Yang wrote:
>  Hi Russell:
> 
>      thks for your replay, actually you also have send me those
> dw-hdmi-audio.c patches, and I also agree it's an beautiful way to make
> hdmi-audio works. Beside,
>  I try to reuse it into our platform, and actually the system have created
> the DW_HDMI sound card successfully, but i cannot play any sound  with this
> sound card.
>      After dump the registers, I found the part of "Audio DMA Registers"
> cannot write and always read with 0x00.  So I searching the document
> "Designware Core
>  HDMI Transmitter Controller Databook", and found that  "Audio DMA
> Registers" only present when the hardware configuration parameter AUDIO_IF
> is set to
>  AHBAUDDMA. Than I communicate with our IC colleagues, they told me that our
> cpu rk3288 only support two way to  transmit audio data( I2S & SPDIF ), in
> that
> way we do not support AHB_DMA, it's very sad, and this it why i give up this
> way, also it's my bad that i should replay to u first in the before mail.

Okay, that means there is some work to be done to figure out how to
support this correctly so that both the iMX and Rockchip code can
co-exist together in the mainline kernel - that means we _both_ need
to work together on this problem _before_ this code gets merged, so
that we have a common approach between the two code bases.

I really don't want to end up in another cocked up situation like
what happened with the Dove audio, where it became politically
impossible for the SolidRun platform to be properly supported by
mainline kernels.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
