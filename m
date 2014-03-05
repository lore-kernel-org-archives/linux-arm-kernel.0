From: broonie@kernel.org (Mark Brown)
Date: Wed, 5 Mar 2014 09:15:30 +0800
Subject: I2C dummy adapter driver ?
In-Reply-To: <5315BB34.8080803@samsung.com>
References: <5305382E.9050902@gmail.com>
 <CAJe_ZhcMMVRTErH3ctbnZyn30_cp9XXjEfUZXdWaVWUHqs4CRw@mail.gmail.com>
 <53073C51.5010401@samsung.com>
 <20140228060728.GB29849@sirena.org.uk>
 <5315BB34.8080803@samsung.com>
Message-ID: <20140305011530.GN13126@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 12:38:28PM +0100, Sylwester Nawrocki wrote:
> On 28/02/14 07:07, Mark Brown wrote:
> > On Fri, Feb 21, 2014 at 12:45:21PM +0100, Sylwester Nawrocki wrote:

> >> The I2C bus driver with empty i2c_algorithm.master_xfer() helps WRT to
> >> using standard DT binding and v4l2_subdev interface.

> > Wouldn't a platform device do just as well here if there's no actual
> > control?

> Then the I2C client devices would have to be instantiated manually, 
> I think it's more trouble.

I2C is not that much more enumerable than platform bus, I don't see the
difference here?  To the extent I2C is enumerable a dummy adaptor isn't
going to support that.

> I could as well create custom I2C client drivers per ISP, but then the 
> I2C devices would have to be represented somehow in DT, to pass stuff 
> like voltage regulators and GPIOs. Anyway, it's not something could be 
> done in mainline.

Why not?

> Even if there is no actual I2C communication on the host CPU side, the 
> power up/down sequence is handled there. The intention is to keep this 
> common per an I2C client, regardless of whether I2C communication is 
> done by firmware or the host the CPU.

The way you're talking it sounds like your code is very hard coded to
use I2C here.  What happens if someone uses SPI or some other bus to
control an ISP?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/38a5366d/attachment.sig>
