From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Dec 2014 19:20:24 +0000
Subject: [PATCH v2 2/2] ASoC: rockchip: i2s: add support for grabbing
 output clock to codec
In-Reply-To: <1417591118-18695-3-git-send-email-jay.xu@rock-chips.com>
References: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>
 <1417591118-18695-1-git-send-email-jay.xu@rock-chips.com>
 <1417591118-18695-3-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20141203192024.GL7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 03:18:38PM +0800, Jianqun Xu wrote:
> From: Sonny Rao <sonnyrao@chromium.org>
> 
> We need to claim the clock which is driving the codec so that when we enable
> clock gating, we continue to clock the codec when needed.  I make this an
> optional clock since there might be some applications where we don't need it
> but can still use the I2S block.

I would expect that the clock for the CODEC should be managed by the
CODEC if at all possible - that seems more logical than having the CPU
I2S controller request and manage it if it's a separate clock.  Why add
this to the CPU side driver?

We've not always done this for older systems due to the lack of a usable
clock API but that's starting to be addressed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141203/a1669c61/attachment.sig>
