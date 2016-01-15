From: broonie@kernel.org (Mark Brown)
Date: Fri, 15 Jan 2016 17:46:23 +0000
Subject: [PATCH v3 3/9] ASoC: rockchip: i2s: add support for grabbing
 output clock to codec
In-Reply-To: <1452865796-23527-4-git-send-email-wxt@rock-chips.com>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
 <1452865796-23527-4-git-send-email-wxt@rock-chips.com>
Message-ID: <20160115174623.GZ6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 09:49:50PM +0800, Caesar Wang wrote:

> We need to claim the clock which is driving the codec so that when we
> enable clock gating, we continue to clock the codec when needed.
> I make this an optional clock since there might be some applications
> where we don't need it but can still use the I2S block.

> - As the perious discuss on https://patchwork.kernel.org/patch/5427131/,
>   I think Mark likes do it in codec driver, I have to say I agree this
>   patch in here since that's the i2s block output. I don't know if the
>   Mark has changed his mind.

If the I2S block is providing a clock to the CODEC then that's what the
software should do so that the CODEC can gate and ungate the clock as
required.  This patch has the I2S block using a clock, not providing
one.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160115/6c8b1525/attachment.sig>
