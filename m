From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Jun 2018 10:16:11 +0100
Subject: [PATCH] arm64: alternative:flush cache with unpatched code
In-Reply-To: <1527788750049.85185@nvidia.com>
References: <1527617488-5693-1-git-send-email-rokhanna@nvidia.com>
 <20180530090044.GA2452@arm.com> <1527788750049.85185@nvidia.com>
Message-ID: <20180604091609.GD9482@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2018 at 05:45:11PM +0000, Rohit Khanna wrote:
> Will, thanks for the comments.
> I will push a new patch set.
> We want to avoid using __flush_icache_all as much as possible and hence
> trying to flush cache by range.

Why? We're going to do it once at boot and once on each module load, so I
can't see it being a performance concern.

Will
