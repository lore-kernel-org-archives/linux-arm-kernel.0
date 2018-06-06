From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 6 Jun 2018 10:57:41 +0100
Subject: [PATCH v4 14/14] coresight: allow the coresight core driver to be
 built as a module
In-Reply-To: <20180605210710.22227-15-kim.phillips@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
 <20180605210710.22227-15-kim.phillips@arm.com>
Message-ID: <46a026b2-0140-c1c0-2205-f5750233b152@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2018 10:07 PM, Kim Phillips wrote:
> Allow to build coresight as a module.  This enhances
> coresight developer efficiency by allowing the development to
> take place exclusively on the target, and without needing to
> reboot in between changes.
> 
> - Kconfig becomes a tristate, to allow =m
> - append -core to source file name to allow module to
>    be called coresight by the Makefile
> - modules can have only one init/exit, so we add the core bus
>    register/unregister function calls to the etm_perf init/exit
>    functions, since coresight.c does not have etm_pmu defined.

It feels a bit weird to move the coresight core specific steps to
etm_perf_init. Why not call etm_perf_init from coresight init routine
and keep everything core specific in the coresight-core.c ?


Suzuki
