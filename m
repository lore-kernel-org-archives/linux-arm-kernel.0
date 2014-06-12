From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Jun 2014 17:39:01 +0100
Subject: [PATCH 02/24] drivercore: Bind/unbind power domain on probe/remove
In-Reply-To: <2753039.YD6R0RpJkS@vostro.rjw.lan>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
 <20140610212731.GA11191@kroah.com> <53977BC1.5000301@gmail.com>
 <2753039.YD6R0RpJkS@vostro.rjw.lan>
Message-ID: <20140612163901.GZ5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 11, 2014 at 02:18:44AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, June 10, 2014 11:42:25 PM Tomasz Figa wrote:

> > OK, so proposed solution is to put this in:

> > - platform_drv_probe(),
> > - spi_drv_probe(),
> > - i2c_device_probe(),
> > - amba_probe(),

> Yes.  Specifically, those are bus types that don't do their own power
> management.

This sounds tedious.  Can we not instead introduce some generic helpers
which all such buses call/use and then implement the hooks in there
(along with anything else that they should all do)?  There must be other
things that all these buses are having to cut'n'paste.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140612/60325df9/attachment-0001.sig>
