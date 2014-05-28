From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 May 2014 17:43:26 +0100
Subject: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
In-Reply-To: <5385CCE6.9070204@gmail.com>
References: <53824294.1090609@redhat.com>
 <20140526103807.GV22111@sirena.org.uk>
 <538321AB.4050006@redhat.com>
 <20140526142225.GF22111@sirena.org.uk>
 <538356DA.7090302@redhat.com>
 <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>
 <53838023.2080807@redhat.com>
 <CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com>
 <5385AF94.90004@redhat.com> <5385CCE6.9070204@gmail.com>
Message-ID: <20140528164326.GB5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 01:47:50PM +0200, Tomasz Figa wrote:

> Moreover, there are already WLAN chips available that can use HSIC as
> their host interface and I'm not talking here about some exotic
> products, but rather widely recognized products of Broadcom (BCM4335),
> Marvell (88W8797) or Qualcomm Atheros (AR6004).

> My conclusion is that I see the discussion here being too much focused
> on MMC, especially considering the fact that the whole problem doesn't
> have anything to do with MMC, which is just used as (one of possible)
> host interface.

Right, the other example I keep mentioning for this is Slimbus where
some sort of external power control is required to trigger enumeration
in normal operation for common use cases.

> IMHO, all we need here is a way to tell the MMC (or HSIC) core when to
> look for a new device and when not (e.g. power down the host controller
> completely). Anything else, including proper power sequencing is up to
> the platform driver of such non-discoverable device - it's only its host
> interface that is discoverable when enabled. I believe this simplistic
> approach would lead to much less new code added, better reusability of
> code (power sequencing independent of host interface) and no need to
> create overly generic code, which usually turns out to be not generic
> enough.

We then have the problem of working out where that platform driver comes
from, for many of these buses the device can be completely described as
just a device on the parent bus with some resources connected.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/ec9297a2/attachment.sig>
