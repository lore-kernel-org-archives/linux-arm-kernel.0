From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 26 Jan 2017 18:06:09 +0100
Subject: [PATCH 1/5] iommu/arm-smmu: Restrict domain attributes to
 UNMANAGED domains
In-Reply-To: <89d795b9-a6d7-7f41-705c-b918ee66ebf0@arm.com>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
 <1484849955-1871-2-git-send-email-will.deacon@arm.com>
 <89d795b9-a6d7-7f41-705c-b918ee66ebf0@arm.com>
Message-ID: <20170126170609.GC27598@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 06:41:34PM +0000, Robin Murphy wrote:
> For the sake of discussion, would it make sense to enforce this in
> domain_set_attr() itself? The intersection of drivers providing these
> callbacks and drivers supporting anything other than unmanaged domains
> is currently these two below, so it clearly wouldn't break anything to
> put this check in core code today. Looking forward, is there likely to
> be any plausible situation where users of a managed domain would be
> legitimate in mucking about with its attrs, on any platform?

No, this belongs in driver code. I am pretty certain there will be a use
for attributes in unmanaged domains at some point. Crazy things happen
all the time :)


	Joerg
