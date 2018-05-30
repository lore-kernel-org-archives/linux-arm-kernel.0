From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 May 2018 17:07:44 +0100
Subject: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=X2u=hMyWinSDtim-PmFwAy5mXcwg3HeYojAHcsUFhV3g@mail.gmail.com>
References: <20180523154057.GL4828@sirena.org.uk>
 <CAD=FV=XWVOdJ8rWJnBTwoNqnYqYRYjknkZtUvT86+skbrTdwig@mail.gmail.com>
 <20180523155617.GN4828@sirena.org.uk>
 <CAD=FV=W4aDxWbcaJ9GZ1KkvyiTPAPR-oUoTFzJfS+LftU5ZP=Q@mail.gmail.com>
 <20180530093701.GD6920@sirena.org.uk>
 <CAD=FV=W-MLU9c-SvfLgKAKGP1eHN5xO-013f2M09XUa+QeHzrA@mail.gmail.com>
 <20180530150241.GO6920@sirena.org.uk>
 <CAD=FV=XJd-udEE6az0xP7i6x0oGsnd=BSCyZ0Og_+RjNCMXnCQ@mail.gmail.com>
 <20180530154849.GQ6920@sirena.org.uk>
 <CAD=FV=X2u=hMyWinSDtim-PmFwAy5mXcwg3HeYojAHcsUFhV3g@mail.gmail.com>
Message-ID: <20180530160744.GS6920@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 09:06:16AM -0700, Doug Anderson wrote:
> On Wed, May 30, 2018 at 8:48 AM, Mark Brown <broonie@kernel.org> wrote:

> > Without the core doing something the regulator isn't going to get told
> > that anything updated voltages anyway...

> I was just suggesting that when the core tells the regulator driver to
> disable itself that the regulator driver tell RPMh to not only disable
> itself but also (temporarily) vote for a lower voltage.  When the core
> tells the regulator to re-enable itself then the regulator driver
> restores the original voltage vote (or applies any vote that might
> have been attempted while the regulator was disabled).  That wouldn't
> require any regulator core changes.

It needs something to tell it what the new voltage to set is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/383a4352/attachment-0001.sig>
