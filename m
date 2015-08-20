From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Aug 2015 08:39:00 +0200
Subject: un4i-ss-cipher.c warning
In-Reply-To: <20150820052903.GA26031@gondor.apana.org.au>
References: <CAOMqctShdb9xEkBmuaQKfB1cwGupbfH5TS5ZB_P85Hwpn+4zAA@mail.gmail.com>
 <20150820052903.GA26031@gondor.apana.org.au>
Message-ID: <20150820063900.GJ30520@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 01:29:03PM +0800, Herbert Xu wrote:
> On Wed, Aug 19, 2015 at 04:35:36PM +0200, Michal Suchanek wrote:
> > Hello,
> > 
> > when building a kernel with sunxi crypto driver as merged into the
> > sinxi-wip branch I get a compiler warning.
> > 
> > I am not sure this is the latest version of the driver. It does not
> > seem to be in mainline yet.
> 
> The warning appears to be spurious as the code always ends up
> initialising todo before using it.

Not in the dev_dbg call line 258. If ileft was negative or null, todo
isn't assigned to anything.

I'm not sure whether initializing todo to 0 is the right thing to do
though. Corentin?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150820/7e407bbd/attachment.sig>
