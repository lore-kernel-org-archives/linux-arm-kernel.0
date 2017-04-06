From: juri.lelli@arm.com (Juri Lelli)
Date: Thu, 6 Apr 2017 15:14:02 +0100
Subject: [PATCH v3 0/9] Fix issues and factorize arm/arm64 capacity
 information code
In-Reply-To: <20170327131825.32134-1-juri.lelli@arm.com>
References: <20170327131825.32134-1-juri.lelli@arm.com>
Message-ID: <20170406141402.GJ9429@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27/03/17 14:18, Juri Lelli wrote:
> Hi,
> 
> arm and arm64 topology.c share a lot of code related to parsing of capacity
> information. This is v3 of a solution [1] (based on Will's, Catalin's and
> Mark's off-line suggestions) to move such common code in a single place:
> drivers/base/arch_topology.c (by creating such file and conditionally compiling
> it for arm and arm64 only).
> 
> First 4 patches are actually fixes for the current code.
> 
> Patch 5 is the actual refactoring.
> 
> Patch 6 is a minor change suggested by Greg and can be squashed as needed.
> 
> Patch 7 removes one of the extern symbols by changing a bit the now common
> code.
> 
> Patch 8 removes the remaining externs (as required by Russell during v1 review)
> by creating a new header file include/linux/arch_topology.h and including that
> from arm, arm64 and drivers.
> 
> Last patch addresses Dietmar's comments to v1 and adds a 'atd_' prefix to
> interfaces exported by drivers code and used by arch (and potentially others in
> the future).
> 
> Changes from v2:
> 
>  - rebase on top of 4.11-rc4
>  - fix various problems pointed out by Greg, thanks for the review!
>    (see patch 5 for details)
> 

Thanks Vincent for your comments.

Everybody else, ping?

Thanks,

- Juri
