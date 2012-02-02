From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Feb 2012 14:19:04 +0000
Subject: [RFC 7/7] MFD: TWL6040: Add regulator support for VIO, V2V1
 supplies
In-Reply-To: <4F2A96B8.2030004@ti.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
 <1328185019-29575-8-git-send-email-peter.ujfalusi@ti.com>
 <20120202125250.GJ7428@opensource.wolfsonmicro.com>
 <4F2A8D11.9010705@ti.com>
 <20120202133207.GN7428@opensource.wolfsonmicro.com>
 <4F2A96B8.2030004@ti.com>
Message-ID: <20120202141904.GC22048@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 03:59:20PM +0200, Peter Ujfalusi wrote:
> On 02/02/2012 03:32 PM, Mark Brown wrote:
> > That's not a problem for using the bulk get - the array is part of the
> > API so you can use regulator_bulk_get() and still look at individual
> > supplies within the array later on when enabling and disabling them.

> For some reason I have associated the use of regulator_bulk_get with the
> use of regulator_bulk_enable/disable. It did not even crossed my mind
> that I can still use regulator_enable on the individual regulators.

They do normally end up going together since a very large proportion of
devices need all their supplies on when active but don't care about
sequencing so you end up with a common pattern.  It's not required,
though.

> Will convert the regulator_get/put to bulk operations. It will make the
> code a bit cleaner.

Good stuff.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120202/73519ed4/attachment-0001.sig>
