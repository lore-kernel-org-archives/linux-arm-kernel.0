From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 10 Apr 2017 09:31:05 +0100
Subject: [PATCH v3 7/9] arm,arm64,drivers: reduce scope of
 cap_parsing_failed
In-Reply-To: <20170327131825.32134-8-juri.lelli@arm.com>
References: <20170327131825.32134-1-juri.lelli@arm.com>
 <20170327131825.32134-8-juri.lelli@arm.com>
Message-ID: <20170410083104.GC27538@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 02:18:23PM +0100, Juri Lelli wrote:
> Reduce the scope of cap_parsing_failed (making it static in
> drivers/base/arch_topology.c) by slightly changing {arm,arm64} DT
> parsing code.
> 
> For arm checking for !cap_parsing_failed before calling normalize_
> cpu_capacity() is superfluous, as returning an error from parse_
> cpu_capacity() (above) means cap_from _dt is set to false.
> 
> For arm64 we can simply check if raw_capacity points to something,
> which is not if capacity parsing has failed.
> 
> Suggested-by: Morten Rasmussen <morten.rasmussen@arm.com>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  arch/arm/kernel/topology.c   | 3 +--
>  arch/arm64/kernel/topology.c | 5 +----
>  drivers/base/arch_topology.c | 4 ++--
>  3 files changed, 4 insertions(+), 8 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
