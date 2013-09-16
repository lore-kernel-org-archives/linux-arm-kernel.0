From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Sep 2013 00:31:11 +0100
Subject: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
In-Reply-To: <1861747.RtS0ZLgUUN@vostro.rjw.lan>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <5235BA9C.1090509@gmail.com> <20130916084708.GN7393@intel.com>
 <1861747.RtS0ZLgUUN@vostro.rjw.lan>
Message-ID: <20130916233111.GB21013@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 16, 2013 at 09:07:07PM +0200, Rafael J. Wysocki wrote:

> That may be left to the client driver altogether.  I mean, if the client wants
> the controller to be powered up, it should just call
> pm_runtime_get_sync(controller device) at a suitable place (and then do the
> corresponding _put when the controller is not necessary anu more) from its
> ->probe() callback.

It shouldn't even need to do that, it should just be able to rely on the
controller to power itself up when asked to do work.   This is how the
existing implementations are done - the controller power management is
totally transparent to the slave.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130917/74953111/attachment-0001.sig>
