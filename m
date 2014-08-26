From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Aug 2014 10:12:26 +0100
Subject: [PATCH v9 1/2] regulator: Add driver for max77802 PMIC PMIC
 regulators
In-Reply-To: <53FC4E77.2090205@collabora.co.uk>
References: <20140822144531.GV24407@sirena.org.uk>
 <53F7838F.8060906@collabora.co.uk>
 <20140822183054.GY24407@sirena.org.uk>
 <53F7BDD8.7060500@collabora.co.uk>
 <CAD=FV=WC0h7fYm2QFqu3Zka7CsU4BtG-oyPpJav+ygC+gmCR+A@mail.gmail.com>
 <CA+NduCCT-KQ=gh7QWkBE4qkA2YOJ8KCVqbkC6Tkmb1aPvCsGFQ@mail.gmail.com>
 <53FAFCBC.2050407@collabora.co.uk>
 <CAD=FV=V4TSKsbjj3dXCdSzVrh3sxH-FkpFEbEo+JA1bN9R-XWA@mail.gmail.com>
 <20140826071721.GV17528@sirena.org.uk>
 <53FC4E77.2090205@collabora.co.uk>
Message-ID: <20140826091226.GD17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 11:08:07AM +0200, Javier Martinez Canillas wrote:
> On 08/26/2014 09:17 AM, Mark Brown wrote:

> > No, this doesn't make any obvious sense to me at all.  Picking normal as
> > a default if the hardware reads back off due to overlapping
> > impelementation or something *might* make sense but not overwriting the
> > hardware state without explicit permission from the machine integration
> > is a key goal for the regulator API.

> Just to be sure I understood you correctly, what might makes sense to you
> then is to set the opmode to normal as default on probe only if off is
> read back from the hardware register but leaving the enable function as it
> is now using the opmode set on probe?

Yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/076569dc/attachment.sig>
