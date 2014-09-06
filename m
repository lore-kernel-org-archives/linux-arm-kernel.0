From: broonie@kernel.org (Mark Brown)
Date: Sat, 6 Sep 2014 14:57:35 +0100
Subject: [PATCH 2/8] spi: sirf: request and free cs gpio in setup and
 cleanup callbacks
In-Reply-To: <CA+qxAP06x5uHzObuWzmcAjFz4YKHRxxH5FE5cGZYzKQNUsJdyg@mail.gmail.com>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
 <1409648468-5436-3-git-send-email-Barry.Song@csr.com>
 <20140904191954.GO29327@sirena.org.uk>
 <CA+qxAP06x5uHzObuWzmcAjFz4YKHRxxH5FE5cGZYzKQNUsJdyg@mail.gmail.com>
Message-ID: <20140906135735.GE2601@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 11:34:57AM +0800, swingboard wrote:
> 2014-09-05 3:19 GMT+08:00 Mark Brown <broonie@kernel.org>:

> > I'm not quite sure I understand the rationale here - as far as I can
> > tell this is making the GPIO request happen later not earlier so it's
> > not clear to me what the problem this is fixing in the existing code.
> > If the goal is to move the request around in the probe function why not
> > just move the existing code earlier in probe()?

> As GPIO cs can be high or low validate and the used GPIO pin with
> default value may high or low,
> it is need do spi device's chipselect invalidation work in spi_setup,
> the patch purpose for it.
> master->cs_gpios only assigned after spi_bitbang_start and the
> function call spi_setup,
> if keep the existing code there will result gpio usage before gpio request.
> just move gpio request code in spi_sirfsoc_setup before gpio use.

I'm still having a hard time understanding why pulling the code earlier
in probe isn't a better fix here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140906/598313cb/attachment-0001.sig>
