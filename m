From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 6 Sep 2018 13:51:15 +0200
Subject: [PATCH v3 27/30] ARM: dts: sun8i: h3: use calibration for ths
In-Reply-To: <55579dd6-625d-e71b-1482-4592dccac665@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-28-embed3d@gmail.com>
 <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
 <55579dd6-625d-e71b-1482-4592dccac665@gmail.com>
Message-ID: <20180906115114.inc6dhqhy47obo25@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2018 at 01:47:47PM +0200, Philipp Rossak wrote:
> On 04.09.2018 18:46, Emmanuel Vadot wrote:
> > > +			/* Data cells */
> > > +			thermal_calibration: calib at 234 {
> > > +				reg = <0x234 0x8>;
> > > +			};
> >   You are declaring 8 bytes of calibration data but to my knowledge it's
> > only 2 bytes per sensor, so 2 bytes for H3.
> >   Am I missing something ?
> > 
> >   Thanks,
> 
> Emmanuel you are right, it is 2 bytes per Sensor and should be 2 bytes for
> H3, but the thermal calibration data field is on all chips 64 bit wide - so
> 8 bytes. So I'm reading here the complete calibration data field.

Having one cell per channel would make more sense I guess.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180906/3ce6d114/attachment.sig>
