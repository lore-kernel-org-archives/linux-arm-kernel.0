From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Jul 2015 16:01:22 +0100
Subject: [RFC PATCH 3/4] iommu/arm-smmu: Add support for specifying clocks
In-Reply-To: <1437152005-25092-4-git-send-email-sricharan@codeaurora.org>
References: <1437152005-25092-1-git-send-email-sricharan@codeaurora.org>
 <1437152005-25092-4-git-send-email-sricharan@codeaurora.org>
Message-ID: <20150721150122.GH31095@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 05:53:24PM +0100, Sricharan R wrote:
> From: Mitchel Humpherys <mitchelh@codeaurora.org>
> 
> On some platforms with tight power constraints it is polite to only
> leave your clocks on for as long as you absolutely need them. Currently
> we assume that all clocks necessary for SMMU register access are always
> on.

You've borrowed this commit message from Mitch's previous version of
this patch, but now you leave the clocks enabled most of the time so it
doesn't make much sense anymore.

Anyway, I'm OK with this kind of clock management in the driver, but I
think that anything more fine-grained needs to be designed into the IOMMU
core.

Will
