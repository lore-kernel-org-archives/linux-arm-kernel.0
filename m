From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Aug 2016 17:29:41 +0100
Subject: [PATCH 3/9] regulator: core: Try full range when adjusting
 regulators to constraints
In-Reply-To: <20160821021125.1521-4-wens@csie.org>
References: <20160821021125.1521-1-wens@csie.org>
 <20160821021125.1521-4-wens@csie.org>
Message-ID: <20160822162941.GP22076@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2016 at 10:11:19AM +0800, Chen-Yu Tsai wrote:
> Currently when we try to bring regulator in bounds of its constraints,
> we pick either the minimum or maximum voltage as the target. This fails
> if the regulator range is not continuous, and the target voltage is not
> an exact value the regulator can achieve, i.e. the target is not aligned
> to the step of the regulator.

Oh, and this is nothing to do with implementing support for this MFD so
should be a separate patch for ease of review.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/594a9494/attachment.sig>
