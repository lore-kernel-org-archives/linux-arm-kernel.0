From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 Oct 2014 12:26:36 +0200
Subject: [PATCH 1/2] spi/rockchip: fix bug that case spi can't go as fast
 as slave request
In-Reply-To: <543F96DB.40403@rock-chips.com>
References: <1413372311-4203-1-git-send-email-addy.ke@rock-chips.com>
 <1413372349-4254-1-git-send-email-addy.ke@rock-chips.com>
 <20141015130452.GD27755@sirena.org.uk>
 <543F8CD2.1010302@rock-chips.com>
 <20141016093410.GB2200@sirena.org.uk>
 <543F96DB.40403@rock-chips.com>
Message-ID: <20141016102636.GE2200@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 05:58:51PM +0800, addy ke wrote:

Please fix your mailer to word wrap within paragraphs.

> On 2014/10/16 17:34, Mark Brown wrote:

> >> If we set the rate unconditionally here, clk_set_rate() will be executed in each spi transfer.

> > Is that really such a high cost?

> Not high cost, but  I think if the default spi_clk is enough, we do not need to set spi_clk again.

> Maybe we can only set spi_clk as (2 * MAX_SCLK_OUT) in probe().

It's not too bad to do it where it is, it just seems better to be
simpler.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141016/61e6574c/attachment-0001.sig>
