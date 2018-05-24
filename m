From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 May 2018 11:40:55 +0100
Subject: [PATCH v4 1/2] arm64/sve: Thin out initialisation sanity-checks
 for sve_max_vl
In-Reply-To: <1527097616-25214-2-git-send-email-Dave.Martin@arm.com>
References: <1527097616-25214-1-git-send-email-Dave.Martin@arm.com>
 <1527097616-25214-2-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180524104053.GB28425@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 06:46:55PM +0100, Dave Martin wrote:
> Now that the kernel SVE support is reasonably mature, it is
> excessive to default sve_max_vl to the invalid value -1 and then
> sprinkle WARN_ON()s around the place to make sure it has been
> initialised before use.  The cpufeatures code already runs pretty
> early, and will ensure sve_max_vl gets initialised.
> 
> This patch initialises sve_max_vl to something sane that will be
> supported by every SVE implementation, and removes most of the
> sanity checks.
> 
> The checks in find_supported_vector_length() are retained for now.
> If anything goes horribly wrong, we are likely to trip a check here
> sooner or later.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/kernel/fpsimd.c | 17 ++++-------------
>  arch/arm64/kernel/ptrace.c |  3 ---
>  2 files changed, 4 insertions(+), 16 deletions(-)

Thanks, this makes the code a bit more readable imo:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
