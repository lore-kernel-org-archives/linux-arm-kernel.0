From: broonie@kernel.org (Mark Brown)
Date: Mon, 23 Mar 2015 11:39:12 -0700
Subject: [PATCH 4/7] regulator: add mxs regulator driver
In-Reply-To: <1459171144.549216.1427132741792.JavaMail.open-xchange@oxbaltgw02.schlund.de>
References: <1426984203-9133-1-git-send-email-stefan.wahren@i2se.com>
 <1426984203-9133-5-git-send-email-stefan.wahren@i2se.com>
 <20150322161425.GC6643@sirena.org.uk>
 <1459171144.549216.1427132741792.JavaMail.open-xchange@oxbaltgw02.schlund.de>
Message-ID: <20150323183912.GJ14954@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 06:45:41PM +0100, Stefan Wahren wrote:

> > So, this isn't actually quite a busy wait because we do a schedule()
> > rather than a cpu_relax() but still it could devolve into that - 20ms
> > seems a long time to burn doing that. If we're expecting this to finish
> > very quickly can we do an initial busy wait then fall back to something
> > with an actual sleep or soemthing?

> We will need to keep the initial usleep_range(). So do you think of the
> following:

> 1. usleep_range
> 2. busy_wait for BM_POWER_STS_DC_OK
> 3. msleep (for the timeout case)

That's what I'm suggesting - do the initial busy wait for a reasonably
short time period and then fall back to something that sleeps.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150323/d00b8429/attachment.sig>
