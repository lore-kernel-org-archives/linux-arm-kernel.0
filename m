From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 Jan 2015 17:11:31 +0000
Subject: [PATCH v2 2/4] Documentation: bindings: Add the regulator
 property to the sub-nodes AHCI bindings
In-Reply-To: <CAGb2v674q4Cjp9qy9CbUXe2j5pT_ez98CKxXHC8u4Diap2TT1A@mail.gmail.com>
References: <1420799989-10645-1-git-send-email-gregory.clement@free-electrons.com>
 <1420799989-10645-3-git-send-email-gregory.clement@free-electrons.com>
 <54AFF7E3.4070506@redhat.com> <54AFFFDC.7020307@free-electrons.com>
 <CAGb2v674q4Cjp9qy9CbUXe2j5pT_ez98CKxXHC8u4Diap2TT1A@mail.gmail.com>
Message-ID: <20150109171131.GH2634@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 10, 2015 at 12:29:32AM +0800, Chen-Yu Tsai wrote:

> Since the AHCI library code already supports the generic phy subsystem,
> with one phy possible for each port node, you could possibly add a
> generic phy that just takes a regulator, and hook it up that way.

> I don't know if the extra layer of indirection is good or not.
> Just offering an alternative.

Or if the supply is for the device at the other end of the link (which
is what it sounded like) then use that.  This just sounds like the same
problem we have for all the enumerable buses in embedded systems where
we need to be able to understand that the device exists prior to it
being fully ready to appear in the system.  Having the link/slot be a
device in Linux does indeed seem to be a common way people think about
doing this, it sounds like for this one it might be the most direct.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150109/e840d768/attachment.sig>
