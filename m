From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 07 Jun 2016 10:49:35 +0800
Subject: [PATCH v3] ASoC: rockchip: Add machine driver for
 MAX98357A/RT5514/DA7219
In-Reply-To: <20160606235026.GP7510@sirena.org.uk>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com>
 <20160601144542.GA3835@rob-hp-laptop> <5751912C.6080904@rock-chips.com>
 <20160606235026.GP7510@sirena.org.uk>
Message-ID: <5756363F.40208@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2016?06?07? 07:50, Mark Brown wrote:
> On Fri, Jun 03, 2016 at 10:16:12PM +0800, Xing Zheng wrote:
>
>> I refered to MTK's mt8173-rt5650-rt5514.txt on upstream, that compatible
>> name is "mediatek,mt8173-rt5650-rt5514".
>> Because our platform need to support 3 codecs (max98357a / da7219 / rt5514).
>> Perhaps, you maybe feel that name is too long? And, could you please tell me
>> what names would be better?
>> For example: "rk3399-composite-codecs" ?
> It should probably be three compatibles, one per CODEC, if the driver
> needs to handle each separately.
Do you mean like this:
--------
sound {
compatible = "rockchip,rk3399-max98357a-rt5514-da7219";

dailink-0 {
compatible = "rockchip,rk3399-max98357a";
rockchip,cpu = <&i2s0>;
rockchip,codec = <&max98357a>;
};

dailink-1 {
compatible = "rockchip,rk3399-rt5514";
rockchip,cpu = <&i2s0>;
rockchip,codec = <&headsetcodec>;
};

dailink-2 {
compatible = "rockchip,rk3399-da7219";
rockchip,cpu = <&i2s0>;
rockchip,codec = <&codec>;
};
};
--------
Above, the machine drvier will handle them. Please correct me if I 
misunderstand.

Thanks.

-- 
- Xing Zheng
