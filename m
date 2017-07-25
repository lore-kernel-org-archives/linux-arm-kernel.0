From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Jul 2017 13:04:23 +0100
Subject: [PATCH] arm64: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-2-robh@kernel.org>
References: <20170718214339.7774-2-robh@kernel.org>
Message-ID: <20170725120422.GD27768@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Luc]

Hi Rob,

On Tue, Jul 18, 2017 at 04:42:42PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm64/kernel/cpu_ops.c  |  4 ++--
>  arch/arm64/kernel/smp.c      | 12 ++++++------
>  arch/arm64/kernel/topology.c | 22 +++++++++++-----------
>  3 files changed, 19 insertions(+), 19 deletions(-)

I've queued this and the perf patch too, but it would be good if somebody
could update sparse to recognise this format specifier. Currently it
just complains about it.

Will
