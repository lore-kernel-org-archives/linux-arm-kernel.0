From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 13 Oct 2015 04:10:01 +0900
Subject: [PATCH v2] arm: dts: Fix audio card detection on peach boards
In-Reply-To: <561BAFE0.5070205@samsung.com>
References: <1444653438-6532-1-git-send-email-alim.akhtar@samsung.com>
 <561BAFE0.5070205@samsung.com>
Message-ID: <561C0589.7010103@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12/15 22:04, Krzysztof Kozlowski wrote:
> W dniu 12.10.2015 o 21:37, Alim Akhtar pisze:
>> Since commit 2fad972d45c4 ("ARM: dts: Add mclk entry for Peach boards"),
>> sound card detection is broken on peach boards and gives below errors:
>>
>> [    3.630457] max98090 7-0010: MAX98091 REVID=0x51
>> [    3.634233] max98090 7-0010: use default 2.8v micbias
>> [    3.640985] snow-audio sound: HiFi <-> 3830000.i2s mapping ok
>> [    3.645307] max98090 7-0010: Invalid master clock frequency
>> [    3.650824] snow-audio sound: ASoC: Peach-Pi-I2S-MAX98091 late_probe() failed: -22
>> [    3.658914] snow-audio sound: snd_soc_register_card failed (-22)
>> [    3.664366] snow-audio: probe of sound failed with error -22
>>
>> This patch adds missing assigned-clocks and assigned-clock-parents for
>> pmu_system_controller node which is used as "mclk" for audio codec.
>>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> Fixes: 2fad972d45c4 ("ARM: dts: Add mclk entry for Peach boards")
>> Cc: <stable@vger.kernel.org>
>> ---
>> Changes since v1:
>> Addressed Krzysztof's review comments.
> 
> Looks good, thanks!
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
Applied, thanks.

- Kukjin
