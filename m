From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 May 2018 10:37:01 +0100
Subject: [PATCH v3 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=W4aDxWbcaJ9GZ1KkvyiTPAPR-oUoTFzJfS+LftU5ZP=Q@mail.gmail.com>
References: <fb390ccb-927a-8449-05c3-8dcac964bfae@codeaurora.org>
 <CAD=FV=XARtQNo5Cyg78XuT26JUFgn=7BjWRnXPjP566=a-sF1w@mail.gmail.com>
 <a106c337-0713-e5d6-cb40-13e05f4d361d@codeaurora.org>
 <CAD=FV=W=BquL5ojORz4HNP889s=-uNJ-QEzUfAxwXj2Oa3cGew@mail.gmail.com>
 <20180523082908.GB4828@sirena.org.uk>
 <CAD=FV=XfPkpGD32MfTfcw02wQ+QetpUhY=P299uhpX6pY_iEvg@mail.gmail.com>
 <20180523154057.GL4828@sirena.org.uk>
 <CAD=FV=XWVOdJ8rWJnBTwoNqnYqYRYjknkZtUvT86+skbrTdwig@mail.gmail.com>
 <20180523155617.GN4828@sirena.org.uk>
 <CAD=FV=W4aDxWbcaJ9GZ1KkvyiTPAPR-oUoTFzJfS+LftU5ZP=Q@mail.gmail.com>
Message-ID: <20180530093701.GD6920@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 10:30:33PM -0700, Doug Anderson wrote:
> On Wed, May 23, 2018 at 8:56 AM, Mark Brown <broonie@kernel.org> wrote:

> > Yes, that's definitely not what's expected but it's unfortunately what
> > the firmware chose to implement so we may well be stuck with it
> > unfortunately.

> We're not really stuck with it if we do what I was suggesting.  I was
> suggesting that every time we disable the regulator in Linux we have
> Linux vote for the lowest voltage it's comfortable with.  Linux keeps
> track of the true voltage that the driver wants and will always change
> its vote back to that before enabling.  Thus (assuming Linux is OK
> with 1.2 V - 1.4 V for a rail):

That's pretty much what it should do anyway with normally designed
hardware.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/9b330fe7/attachment.sig>
