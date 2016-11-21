From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 21 Nov 2016 11:34:08 +0100
Subject: [RFT v2 2/5] ASoC: samsung: smdk_wm8580: Remove old platforms and
 drop mach-types usage
In-Reply-To: <8b81b058-0ba9-f1bc-a0ed-d30604853110@samsung.com>
References: <1479669895-19124-1-git-send-email-krzk@kernel.org>
 <CGME20161120192523epcas1p4f764b20d525d28059b85373276a4f725@epcas1p4.samsung.com>
 <1479669895-19124-3-git-send-email-krzk@kernel.org>
 <8b81b058-0ba9-f1bc-a0ed-d30604853110@samsung.com>
Message-ID: <713e7f53-16b2-a510-e99e-77e785f8a7c1@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2016 11:30 AM, Sylwester Nawrocki wrote:
> On 11/20/2016 08:24 PM, Krzysztof Kozlowski wrote:
>> MACH_SMDKC100, MACH_SMDKV210 and MACH_SMDKC110 are no longer supported
>> so we can drop the dead code.  After this the driver no longer
>> differentiates between machines (S3C24xx machines are not supported by
>> it) so there is no need to override I2S device id in cpu_dai_name and
>> SEC_PLAYBACK dai_link can be removed as well.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>
>> Not tested. The driver did not override .platform_name which looks
>> suspicious to me. However I did not want to add changes which could have
>> some visible impact on output code.
> 
> The patch looks good to me. However the existing smdk64xx sound support
> less so. I don't have smdk6410 set up for testing yet, possibly I get
> around that next week.
> Indeed it's strange .platform_name is not also "samsung-i2s.2".

I think that is a fallout from commit a08485d8fdf6f ("ASoC: Samsung: Do not
register samsung audio dma device as pdev"). Given nobody noticed this in
the last 4 years maybe its time to drop this machine driver as well.
