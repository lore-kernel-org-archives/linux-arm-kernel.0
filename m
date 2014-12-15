From: ykk@rock-chips.com (Kuankuan.Yang)
Date: Mon, 15 Dec 2014 19:52:06 +0800
Subject: [RFC PATCH 0/6] Those patches is used for dw_hdmi audio.
In-Reply-To: <548EC9E1.5040206@rock-chips.com>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
 <20141215103830.GD11285@n2100.arm.linux.org.uk>
 <548EC9E1.5040206@rock-chips.com>
Message-ID: <548ECB66.70004@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi Russell:

      thks for your replay, actually you also have send me those 
dw-hdmi-audio.c patches, and I also agree it's an beautiful way to make 
hdmi-audio works. Beside,
  I try to reuse it into our platform, and actually the system have 
created the DW_HDMI sound card successfully, but i cannot play any 
sound  with this sound card.
      After dump the registers, I found the part of "Audio DMA 
Registers" cannot write and always read with 0x00.  So I searching the 
document  "Designware Core
  HDMI Transmitter Controller Databook", and found that  "Audio DMA 
Registers" only present when the hardware configuration parameter 
AUDIO_IF is set to
  AHBAUDDMA. Than I communicate with our IC colleagues, they told me 
that our cpu rk3288 only support two way to  transmit audio data( I2S & 
SPDIF ), in that
way we do not support AHB_DMA, it's very sad, and this it why i give up 
this way, also it's my bad that i should replay to u first in the before 
mail.


Best Regards.
> ? 2014?12?15? 18:38, Russell King - ARM Linux ??:
>> On Mon, Dec 15, 2014 at 10:11:28AM +0800, Yakir Yang wrote:
>>> rk3288 use Designware HDMI IP, Designware HDMI supports four interfaces to
>>> config hdmi audio(I2S, S/PDIF, Generic Parallel Audio, AHB Audio DMA), but
>>> rk3288 only support two ways to config hdmi audio(I2S, S/PDIF), So we take
>>> I2S as hdmi audio operation interfaces, and then treat hdmi audio as an
>>> standard ALSA devices(only got platback function).
>> There is no need for dw-hdmi audio to be implemented as an ASoC
>> device - as I've already sent patches to Andy with my ALSA driver
>> which has been around for the last two years, and works well, and
>> doesn't require any additional DT description.
>>
>
