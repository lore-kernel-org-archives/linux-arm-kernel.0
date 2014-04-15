From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Apr 2014 11:12:49 +0100
Subject: [PATCH 5/5] spi: sirf: fix spi full-duplex DMA transferring issue
In-Reply-To: <CAGsJ_4yWkBr2x=hLNaCsVwytDTua48kR+DEO86A6vH5x+jLEDg@mail.gmail.com>
References: <1397457001-5266-1-git-send-email-21cnbao@gmail.com>
 <1397457001-5266-6-git-send-email-21cnbao@gmail.com>
 <20140414200628.GX25182@sirena.org.uk>
 <CAGsJ_4yO-LGJEkpNy=dizQWjSE3pHEBOrrPndho3jt1_YMRvHg@mail.gmail.com>
 <20140415092609.GJ12304@sirena.org.uk>
 <CAGsJ_4yWkBr2x=hLNaCsVwytDTua48kR+DEO86A6vH5x+jLEDg@mail.gmail.com>
Message-ID: <20140415101249.GO12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 05:57:39PM +0800, Barry Song wrote:
> 2014-04-15 17:26 GMT+08:00 Mark Brown <broonie@kernel.org>:

> > OK, that needs fixing.  That code predates anyone doing DMA.

> if it is out of specification, it seems fixing spidev.c is not enough
> as spi transfer actually needs an precondition of tx!=rx now.

Well, it's enough to avoid bugs.  Adding the validation to make sure
nobody introduces the problem again is nice too but isn't as urgent.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140415/1439cfb3/attachment.sig>
