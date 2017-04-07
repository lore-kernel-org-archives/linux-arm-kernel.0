From: broonie@kernel.org (Mark Brown)
Date: Fri, 7 Apr 2017 12:22:12 +0100
Subject: [RFC 4/8] regulator: core: Check enabling bypass respects
 constraints
In-Reply-To: <1491562312.9365.41.camel@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <1edff9bc610969b0c53fa1080d5db021c8e00b2d.1490199005.git.leonard.crestez@nxp.com>
 <20170324125212.vikgekqxsnu7htzl@sirena.org.uk>
 <1490704781.3546.57.camel@nxp.com>
 <20170328164754.z2c2ttovs3sxbcos@sirena.org.uk>
 <1490730595.15830.1.camel@nxp.com>
 <20170406185202.uixxcv3dgucrddgc@sirena.org.uk>
 <1491562312.9365.41.camel@nxp.com>
Message-ID: <20170407112212.gzv3p7ldkh62657m@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 07, 2017 at 01:51:52PM +0300, Leonard Crestez wrote:

> It currently seems to work how I expect but from your statement it's
> not clear if it's entirely intentional.

The current behaviour of bypassed regulators is intentional.

> > > Or should a bypassed regulator ignore all other requests? One of the
> > > behaviors that this patch series relies on is that calling set_voltage
> > > on a bypassed regulator propagates this request to the supply and picks
> > > the minimum voltage there. An alternative implementation would be to

> > Yes, the expectation is that if anything is being changed it won't have
> > any effect until regulation is reenabled but we're not particularly
> > expecting much activity on bypassed regulators.

> OK, so it is up to consumers to ensure the supply voltage is acceptable
> before allowing bypass. If they want to do something clever they should
> register as a consumer to the supply as well.

No, that's not expected either - one or the other is fine but both isn't
expected.  What you're looking for here is something logically different
to bypass even if the hardware implementation ends up the same.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170407/b4473be6/attachment.sig>
