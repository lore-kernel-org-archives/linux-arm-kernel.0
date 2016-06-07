From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 07 Jun 2016 20:47:01 +0800
Subject: [PATCH v3] ASoC: rockchip: Add machine driver for
 MAX98357A/RT5514/DA7219
In-Reply-To: <20160607120647.GV7510@sirena.org.uk>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com>
 <20160601144542.GA3835@rob-hp-laptop> <5751912C.6080904@rock-chips.com>
 <20160606235026.GP7510@sirena.org.uk> <5756363F.40208@rock-chips.com>
 <20160607104711.GR7510@sirena.org.uk> <5756B22F.9000105@rock-chips.com>
 <20160607120647.GV7510@sirena.org.uk>
Message-ID: <5756C245.7010001@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 2016?06?07? 20:06, Mark Brown wrote:
> OK, then the original name probably makes some sense though really
> that's such an unusual design that just naming it after the specific
> board might be better, it's not likely to see any reuse I'd guess.
There are not only one type of board with this audio connection, so I 
think we don't need to add specific board name.

Therefore, I intend to recover original name 
(rk3399_max98357a_rt5514_da7219.c), and description like this:
sound {
     compatible = "rockchip,rk3399-max98357a-rt5514-da7219";
     rockchip,cpu = <&i2s0 &i2s0 &i2s0>;               // note (will not 
be sent to upstream): In future, we may use the i2s1 or i2s2...
     rockchip,codec = <&max98357a &headsetcodec &codec>;
};

Could you please agree to do this?

Thanks.

-- 
- Xing Zheng
