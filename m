From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Aug 2014 08:17:21 +0100
Subject: [PATCH v9 1/2] regulator: Add driver for max77802 PMIC PMIC
 regulators
In-Reply-To: <CAD=FV=V4TSKsbjj3dXCdSzVrh3sxH-FkpFEbEo+JA1bN9R-XWA@mail.gmail.com>
References: <CA+NduCDL65=Y=PyU3FfXsTz0FfbmYzicGrY4U7ji3_V+nXhtCQ@mail.gmail.com>
 <53F73472.8010609@collabora.co.uk>
 <20140822144531.GV24407@sirena.org.uk>
 <53F7838F.8060906@collabora.co.uk>
 <20140822183054.GY24407@sirena.org.uk>
 <53F7BDD8.7060500@collabora.co.uk>
 <CAD=FV=WC0h7fYm2QFqu3Zka7CsU4BtG-oyPpJav+ygC+gmCR+A@mail.gmail.com>
 <CA+NduCCT-KQ=gh7QWkBE4qkA2YOJ8KCVqbkC6Tkmb1aPvCsGFQ@mail.gmail.com>
 <53FAFCBC.2050407@collabora.co.uk>
 <CAD=FV=V4TSKsbjj3dXCdSzVrh3sxH-FkpFEbEo+JA1bN9R-XWA@mail.gmail.com>
Message-ID: <20140826071721.GV17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 08:40:40AM -0700, Doug Anderson wrote:
> On Mon, Aug 25, 2014 at 2:07 AM, Javier Martinez Canillas

> > I see, so probably until we have a way to define the operating mode for
> > each regulator using DT we should set the opmode to normal when enabling a
> > regulator independently of the value the hardware register reported on probe.

> > Can you please test the following change [0] so I can post as a proper
> > patch? Doug, Mark do you think that forcing the regulator to opmode normal
> > when enabling is the right solution here?

> IMHO that makes sense.

No, this doesn't make any obvious sense to me at all.  Picking normal as
a default if the hardware reads back off due to overlapping
impelementation or something *might* make sense but not overwriting the
hardware state without explicit permission from the machine integration
is a key goal for the regulator API.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/c34310de/attachment-0001.sig>
