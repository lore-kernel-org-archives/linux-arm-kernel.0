From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Oct 2018 18:09:05 +0200
Subject: [PATCH] ASoC: sun4i-i2s: don't try to start up or shut down DAI
 if it's active
In-Reply-To: <20181012153254.10844-1-anarsoul@gmail.com>
References: <20181012153254.10844-1-anarsoul@gmail.com>
Message-ID: <20181012160905.GA2340@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 08:32:54AM -0700, Vasily Khoruzhick wrote:
> Otherwise we may end up with shutting down I2S if shutdown() was
> called for capture substream, but playback is still running.

Would it be cleaner and more robust to use runtime PM?  I'm wondering
what happens if some of the configuration stuff turns out to also need
some of the clocks for example.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181012/99d71b37/attachment-0001.sig>
