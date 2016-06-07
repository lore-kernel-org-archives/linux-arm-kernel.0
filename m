From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jun 2016 13:06:47 +0100
Subject: [PATCH v3] ASoC: rockchip: Add machine driver for
 MAX98357A/RT5514/DA7219
In-Reply-To: <5756B22F.9000105@rock-chips.com>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com>
 <20160601144542.GA3835@rob-hp-laptop>
 <5751912C.6080904@rock-chips.com>
 <20160606235026.GP7510@sirena.org.uk>
 <5756363F.40208@rock-chips.com>
 <20160607104711.GR7510@sirena.org.uk>
 <5756B22F.9000105@rock-chips.com>
Message-ID: <20160607120647.GV7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 07:38:23PM +0800, Xing Zheng wrote:
> On 2016?06?07? 18:47, Mark Brown wrote:

> > No, that'd be one card with all three CODECs on the same board which I'm
> > guessing isn't the intention?

> Yes, because on our board, the audio connection by hardware really is such:
>                   |-- max98357a
> i2s0 <==> |-- rt5514
>                   | -- da7219

> We do need to support max98357a / rt5514 / da7219 via i2s0 on the same board
> for RK3399.

> I remember that it will be failed if we register card with i2s0 more times.
> Therefore, I chose this mothod that create 3 dai-links on one machine
> driver.

OK, then the original name probably makes some sense though really
that's such an unusual design that just naming it after the specific
board might be better, it's not likely to see any reuse I'd guess.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/f7cd4985/attachment.sig>
