From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 07 Jun 2016 19:38:23 +0800
Subject: [PATCH v3] ASoC: rockchip: Add machine driver for
 MAX98357A/RT5514/DA7219
In-Reply-To: <20160607104711.GR7510@sirena.org.uk>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com>
 <20160601144542.GA3835@rob-hp-laptop> <5751912C.6080904@rock-chips.com>
 <20160606235026.GP7510@sirena.org.uk> <5756363F.40208@rock-chips.com>
 <20160607104711.GR7510@sirena.org.uk>
Message-ID: <5756B22F.9000105@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2016?06?07? 18:47, Mark Brown wrote:
> On Tue, Jun 07, 2016 at 10:49:35AM +0800, Xing Zheng wrote:
>> On 2016?06?07? 07:50, Mark Brown wrote:
>>> It should probably be three compatibles, one per CODEC, if the driver
>>> needs to handle each separately.
>> Do you mean like this:
>> --------
>> sound {
>> compatible = "rockchip,rk3399-max98357a-rt5514-da7219";
>>
>> dailink-0 {
>> compatible = "rockchip,rk3399-max98357a";
>> rockchip,cpu =<&i2s0>;
>> rockchip,codec =<&max98357a>;
>> };
>>
>> dailink-1 {
>> compatible = "rockchip,rk3399-rt5514";
>> rockchip,cpu =<&i2s0>;
>> rockchip,codec =<&headsetcodec>;
>> };
>>
>> dailink-2 {
>> compatible = "rockchip,rk3399-da7219";
>> rockchip,cpu =<&i2s0>;
>> rockchip,codec =<&codec>;
>> };
>> };
>> --------
>> Above, the machine drvier will handle them. Please correct me if I
>> misunderstand.
> No, that'd be one card with all three CODECs on the same board which I'm
> guessing isn't the intention?
Yes, because on our board, the audio connection by hardware really is such:
                   |-- max98357a
i2s0 <==> |-- rt5514
                   | -- da7219

We do need to support max98357a / rt5514 / da7219 via i2s0 on the same 
board for RK3399.

I remember that it will be failed if we register card with i2s0 more 
times. Therefore, I chose this mothod that create 3 dai-links on one 
machine driver.

Thanks.

-- 
- Xing Zheng
