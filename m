From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 May 2015 20:22:15 +0100
Subject: [PATCH 1/4] ASoC: rockchip: add rockchip machine driver
In-Reply-To: <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
Message-ID: <20150512192215.GZ3066@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 05:26:34PM +0800, Xing Zheng wrote:
> From: zhengxing <zhengxing@rock-chips.com>
> 
> In most cases, we maybe use simple-card as generic machine driver
> on next kernel, but there are some issue that jack detection and
> widgets extandable on simple-card.
> 
> Own machine drvier can select one valid codec from supported codecs,
> and add needful function from dts on rockchip platform.

Is it not possible to extend simple card to handle your use cases?
Given the very generic naming and the fact that things like jack
detection and so on should depend on the CODEC and board usually rather
than on the SoC it doesn't sound like this is Rockchip specific.

This also looks like you're reimplementing some device model enumeration
stuff which probably shouldn't be happening but let's understand the
problem you're trying to solve here before going too far into the code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/2899f902/attachment.sig>
