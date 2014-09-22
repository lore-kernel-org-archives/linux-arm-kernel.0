From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 22 Sep 2014 11:36:15 +0200
Subject: [RFC PATCH v3 6/7] arm: call iommu_init before
 of_platform_populate
In-Reply-To: <1410539695-29128-7-git-send-email-will.deacon@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
 <1410539695-29128-7-git-send-email-will.deacon@arm.com>
Message-ID: <20140922093614.GK1470@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 05:34:54PM +0100, Will Deacon wrote:
> We need to ensure that the IOMMUs in the system have a chance to perform
> some basic initialisation before we start adding masters to them.
> 
> This patch adds a call to of_iommu_init before of_platform_populate.

Why can't you call it from of_platform_populate() directly? That way it
would be usable for all architectures rather than just ARM. Eventually
we're going to need the same thing for 64-bit ARM (and possibly others
as well).

I also don't like how this uses what is essentially initcall ordering
when solutions have been proposed in the past to properly integrate this
with deferred probe and allow IOMMU drivers to be proper drivers. We
keep adding these special cases for devices that need to be probed early
and I think it's turning into a mess.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140922/04d79e24/attachment-0001.sig>
