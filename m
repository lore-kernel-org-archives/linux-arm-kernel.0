From: broonie@kernel.org (Mark Brown)
Date: Wed, 6 May 2015 19:47:58 +0100
Subject: [PATCH v2] spi: sirf: request and free cs gpio in setup and
 cleanup callbacks
In-Reply-To: <1430649012-1694-1-git-send-email-21cnbao@gmail.com>
References: <1430649012-1694-1-git-send-email-21cnbao@gmail.com>
Message-ID: <20150506184758.GG22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 03, 2015 at 10:30:12AM +0000, Barry Song wrote:
> From: Qipan Li <Qipan.Li@csr.com>
> 
> move spi controller's gpio request work out from probe() to spi device
> register stage, so after spi device register spi controller can deactive
> device's gpio chipselect. old code can't do it because gpio request has
> not be done until device register is finised in spi_bitbang_start.
> and add cleanup function to free CS gpio.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150506/409085fe/attachment.sig>
