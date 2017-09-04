From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Sep 2017 17:48:09 +0100
Subject: Applied "regulator: pbias: Select voltage table based on
 max-voltage" to the regulator tree
In-Reply-To: <f50319d6-9b18-0538-4eb1-6ff4226cac02@ti.com>
References: <E1dnO3z-0000tI-7K@debutante>
 <64d9c623-456c-9142-9c5b-a94593628643@ti.com>
 <20170831135050.adiek6iqqzhndgci@sirena.org.uk>
 <CAPDyKFo=UdnVhFU7k+K1=N0e-1sniC+WZjZ4dZKSF8mXhM43Uw@mail.gmail.com>
 <20170901162322.xrjnim4khn3wfslj@sirena.org.uk>
 <f50319d6-9b18-0538-4eb1-6ff4226cac02@ti.com>
Message-ID: <20170904164809.5coe6vhgyc7iwy6q@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 04, 2017 at 11:16:54AM +0530, Kishon Vijay Abraham I wrote:
> On Friday 01 September 2017 09:53 PM, Mark Brown wrote:

> > Hang on, how can this break anything?  If it breaks things shouldn't
> > there be bugfixes for incorrect constraints somewhere?

> omap_hsmmc sets the pbias voltage to 3V. But here we program the volt table to
> support either 1.8V or 3.3V (Initially the volt table was programmed to support
> 3V because of a bug in TRM). So set_voltage of pbias voltage in omap_hsmmc will
> fail.

Oh, that's appauling.  I guess this is some voltage that doesn't get
presented to cards because otherwise I'm surprised nobody noticed.
Anyway I've dropped the commit from my pull request for now, it'll not
go for v4.14, but the pull request is still there.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170904/c97db2b6/attachment.sig>
