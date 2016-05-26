From: zhengxing@rock-chips.com (Xing Zheng)
Date: Thu, 26 May 2016 17:04:39 +0800
Subject: [RESEND PATCH v2] ASoC: rockchip: Add machine driver for
 MAX98357A/RT5514/DA7219
In-Reply-To: <20160525173246.GA5125@rob-hp-laptop>
References: <1464053774-15914-1-git-send-email-zhengxing@rock-chips.com>
 <20160525173246.GA5125@rob-hp-laptop>
Message-ID: <5746BC27.1030008@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 2016?05?26? 01:32, Rob Herring wrote:
> On Tue, May 24, 2016 at 09:36:14AM +0800, Xing Zheng wrote:
>> There are multi codec devices on the RK3399 platform, we can use
>> this patch support and control these codecs.
>>
>> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
>> ---
>>
>> Changes in v2:
>> - use the FS 256 to set mclks of the max98357a and rt5514 danamically
>> - add more sample rate for da7219
>>
>>   .../sound/rockchip-max98357a-rt5514-da7219.txt     |   15 +
>>   sound/soc/rockchip/Kconfig                         |   11 +
>>   sound/soc/rockchip/Makefile                        |    2 +
>>   .../rockchip/rockchip_max98357a_rt5514_da7219.c    |  333 ++++++++++++++++++++
>>   4 files changed, 361 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sound/rockchip-max98357a-rt5514-da7219.txt
>>   create mode 100644 sound/soc/rockchip/rockchip_max98357a_rt5514_da7219.c
>>
>> diff --git a/Documentation/devicetree/bindings/sound/rockchip-max98357a-rt5514-da7219.txt b/Documentation/devicetree/bindings/sound/rockchip-max98357a-rt5514-da7219.txt
>> new file mode 100644
>> index 0000000..5928384
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/rockchip-max98357a-rt5514-da7219.txt
>> @@ -0,0 +1,15 @@
>> +ROCKCHIP with MAX98357A/RT5514/DA7219 codecs
>> +
>> +Required properties:
>> +- compatible: "rockchip,rockchip-sound"
> This is generic, but the binding seems to be very specific to only 3
> specific codecs. Listing all 3 codecs seems a bit strange. Perhaps a
> name related to the board name would be better.
Yes, I think that I should rename to rk3399_max98357a_rt5514_da7219.c, 
it is related to the rk3399 boards.
>> +- rockchip,cpu: The phandle of the Rockchip I2S controller that's
>> +  connected to the codecs
> What's the size? always 3?
Not always 3, the size is limited by machine driver, The similar 
approach with mt8173-rt5650-rt5676.txt.
>> +- rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
> Please make the size and ordering clear.
Ditto.

Thanks.

-- 
- Xing Zheng
