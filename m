From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 Oct 2015 12:29:26 +0100
Subject: [PATCH 3/6] regulator: core: create unlocked version of
 regulator_list_voltage
In-Reply-To: <20150930223603.GF15635@sirena.org.uk>
References: <1443621946-8712-1-git-send-email-s.hauer@pengutronix.de>
 <1443621946-8712-4-git-send-email-s.hauer@pengutronix.de>
 <20150930223603.GF15635@sirena.org.uk>
Message-ID: <20151001112926.GG12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 11:36:03PM +0100, Mark Brown wrote:
> On Wed, Sep 30, 2015 at 04:05:43PM +0200, Sascha Hauer wrote:
> > The unlocked version will be needed when we start propagating voltage
> > changes to the supply regulators.
> 
> I'm now wondering why we have a locked _list_voltage() in the first
> place...  it *should* be a pure function that doesn't need any locking.
> I'll check tomorrow if there are any users who care but if there aren't
> the change here is probably to remove the locking entirely.

Hrm, looks like there's one that *might* need it - let's go with this
for now, we can always fix up later.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151001/68ace23e/attachment.sig>
