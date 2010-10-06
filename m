From: robert.richter@amd.com (Robert Richter)
Date: Wed, 6 Oct 2010 20:35:49 +0200
Subject: [PATCH 6/7] sh: oprofile: Use perf-events oprofile backend
In-Reply-To: <db62cbe463d5bce89196d6456ad386129ce0022a.1286222593.git.matt@console-pimps.org>
References: <cover.1286222593.git.matt@console-pimps.org>
	<db62cbe463d5bce89196d6456ad386129ce0022a.1286222593.git.matt@console-pimps.org>
Message-ID: <20101006183549.GW13563@erda.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.10.10 16:44:24, Matt Fleming wrote:
> Now that we've got a generic perf-events based oprofile backend we might
> as well make use of it seeing as SH doesn't do anything special with its
> oprofile backend. Also introduce a new CONFIG_HW_PERF_EVENTS symbol so
> that we can fallback to using the timer interrupt for oprofile if the
> CPU doesn't support perf events.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> ---
>  arch/sh/Kconfig            |   13 +++++
>  arch/sh/oprofile/Makefile  |    4 ++
>  arch/sh/oprofile/common.c  |  109 ++++---------------------------------------
>  arch/sh/oprofile/op_impl.h |   33 -------------
>  4 files changed, 28 insertions(+), 131 deletions(-)
>  delete mode 100644 arch/sh/oprofile/op_impl.h

This patch looks good.

We might merge it with patch 7/7.

-Robert

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
