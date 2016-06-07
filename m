From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jun 2016 11:47:11 +0100
Subject: [PATCH v3] ASoC: rockchip: Add machine driver for
 MAX98357A/RT5514/DA7219
In-Reply-To: <5756363F.40208@rock-chips.com>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com>
 <20160601144542.GA3835@rob-hp-laptop>
 <5751912C.6080904@rock-chips.com>
 <20160606235026.GP7510@sirena.org.uk>
 <5756363F.40208@rock-chips.com>
Message-ID: <20160607104711.GR7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 10:49:35AM +0800, Xing Zheng wrote:
> On 2016?06?07? 07:50, Mark Brown wrote:

> > It should probably be three compatibles, one per CODEC, if the driver
> > needs to handle each separately.

> Do you mean like this:
> --------
> sound {
> compatible = "rockchip,rk3399-max98357a-rt5514-da7219";
> 
> dailink-0 {
> compatible = "rockchip,rk3399-max98357a";
> rockchip,cpu = <&i2s0>;
> rockchip,codec = <&max98357a>;
> };
> 
> dailink-1 {
> compatible = "rockchip,rk3399-rt5514";
> rockchip,cpu = <&i2s0>;
> rockchip,codec = <&headsetcodec>;
> };
> 
> dailink-2 {
> compatible = "rockchip,rk3399-da7219";
> rockchip,cpu = <&i2s0>;
> rockchip,codec = <&codec>;
> };
> };
> --------
> Above, the machine drvier will handle them. Please correct me if I
> misunderstand.

No, that'd be one card with all three CODECs on the same board which I'm
guessing isn't the intention?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/f8fe6473/attachment.sig>
