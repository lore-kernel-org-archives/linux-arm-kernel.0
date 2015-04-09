From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 9 Apr 2015 14:19:14 +0200
Subject: [PATCHv7] media: i2c/adp1653: Devicetree support for adp1653
In-Reply-To: <20150409112943.GA31173@amd>
References: <20150403113216.GK20756@valkosipuli.retiisi.org.uk>
 <20150403202624.GA4308@amd>
 <20150403213655.GO20756@valkosipuli.retiisi.org.uk>
 <20150404074337.GA31064@amd>
 <20150404102435.GR20756@valkosipuli.retiisi.org.uk>
 <20150404171116.GA15025@Nokia-N900>
 <20150404200307.GS20756@valkosipuli.retiisi.org.uk>
 <20150409074238.GA22603@amd> <20150409091017.GA4526@earth>
 <20150409112943.GA31173@amd>
Message-ID: <20150409121913.GB18713@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 01:29:43PM +0200, Pavel Machek wrote:
> On Thu 2015-04-09 11:10:17, Sebastian Reichel wrote:
> > On Thu, Apr 09, 2015 at 09:42:38AM +0200, Pavel Machek wrote:
> > > [...]
> > > +#include <linux/of_gpio.h>
> > > +#include <linux/gpio.h>
> > > [...]
> > 
> > This should probably be
> > 
> > #include <linux/of.h>
> > #include <linux/gpio/consumer.h>
> 
> And I thought people would only bikesched paint on the
> Documentation. Sakari, feel free to change that, but

> a) I don't see why Sebastian's version is better

You neither use <linux/of_gpio.h> nor <linux/gpio.h>.

Well "include/linux/gpio.h" describes the old gpio API. The new
gpiod gpiod API is described in "include/linux/gpio/consumer.h" and
you use it, so the include should be included ;)

You don't use anything from "include/linux/of_gpio.h", but it
includes "include/linux/of.h", which you are using. So you should
include <linux/of.h> instead ;)

> b) am pretty sure there is about infinite number of
> possibilities there.

Yes, but most are wrong. You should include all headers,
that are used by you - nothing more and nothing less.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150409/8604f8c9/attachment.sig>
