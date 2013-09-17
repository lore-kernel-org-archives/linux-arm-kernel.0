From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Sep 2013 11:48:52 +0100
Subject: [PATCH v2 1/9] i2c: prepare runtime PM support for I2C client
 devices
In-Reply-To: <1820315.QOOAzSjac3@vostro.rjw.lan>
References: <1378913560-2752-1-git-send-email-mika.westerberg@linux.intel.com>
 <1861747.RtS0ZLgUUN@vostro.rjw.lan>
 <20130916233111.GB21013@sirena.org.uk>
 <1820315.QOOAzSjac3@vostro.rjw.lan>
Message-ID: <20130917104852.GN21013@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 03:25:25AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, September 17, 2013 12:31:11 AM Mark Brown wrote:

> > It shouldn't even need to do that, it should just be able to rely on the
> > controller to power itself up when asked to do work.   This is how the
> > existing implementations are done - the controller power management is
> > totally transparent to the slave.

> If both the I2C client and I2C controller have corresponding objects in the
> ACPI namespace and the client's object is a child of the controller's object,
> then in order to power up the client we need to power up the controller even
> if no transactions are going to be carried out.  That's what the spec simply
> requires us to do in that case.

Like I said I think this should be handled by the power domains (or
otherwise in the ACPI specific code) - we shouldn't be needing to modify
individual drivers to work around thoughtlessness in the ACPI spec.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130917/f27ee281/attachment-0001.sig>
