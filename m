From: mingo@kernel.org (Ingo Molnar)
Date: Fri, 3 Oct 2014 05:31:56 +0200
Subject: [GIT PULL 0/8] perf/core improvements and fixes
In-Reply-To: <1412193043-15493-1-git-send-email-acme@kernel.org>
References: <1412193043-15493-1-git-send-email-acme@kernel.org>
Message-ID: <20141003033156.GA17567@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Best Regards,
> 
> - Arnaldo
> 
> The following changes since commit 07394b5f13a04f86b27e0ddd96a36c7d9bfe1a4f:
> 
>   Merge tag 'perf-core-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2014-09-27 09:15:48 +0200)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo
> 
> for you to fetch changes up to 281f92f233a59ef52bb45287242bd815a67f5647:
> 
>   perf record: Fix error message for --filter option not coming after tracepoint (2014-10-01 15:05:32 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> User visible:
> 
> . Fix mmap return address truncation to 32-bit in 'perf trace'. (Chang Hyun Park)
> 
> o Support operations for shared futexes. (Davidlohr Bueso)
> 
> . Fix error message for --filter option not coming after tracepoint. (Arnaldo Carvalho de Melo)
> 
> Infrastructure:
> 
> . Refactor unit and scale function parameters for pmu parsing routines. (Matt Fleming)
> 
> . Improve DSO long names lookup with rbtree, resulting in great speedup for
>   workloads with lots of DSOs. (Waiman Long)
> 
> . Fix build breakage on arm64 targets. (Will Deacon)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       perf record: Fix error message for --filter option not coming after tracepoint
> 
> Chang Hyun Park (1):
>       perf trace: Fix mmap return address truncation to 32-bit
> 
> Davidlohr Bueso (2):
>       perf bench futex: Support operations for shared futexes
>       perf bench futex: Sanitize -q option in requeue
> 
> Matt Fleming (1):
>       perf tools: Refactor unit and scale function parameters
> 
> Waiman Long (2):
>       perf symbols: Encapsulate dsos list head into struct dsos
>       perf symbols: Improve DSO long names lookup speed with rbtree
> 
> Will Deacon (1):
>       perf tools: Fix build breakage on arm64 targets
> 
>  tools/perf/arch/arm64/util/unwind-libunwind.c |  1 +
>  tools/perf/bench/futex-hash.c                 |  7 ++-
>  tools/perf/bench/futex-requeue.c              | 28 +++++----
>  tools/perf/bench/futex-wake.c                 | 15 +++--
>  tools/perf/builtin-trace.c                    |  6 +-
>  tools/perf/util/dso.c                         | 85 +++++++++++++++++++++++----
>  tools/perf/util/dso.h                         | 16 ++++-
>  tools/perf/util/header.c                      | 32 +++++-----
>  tools/perf/util/machine.c                     | 25 ++++----
>  tools/perf/util/machine.h                     |  5 +-
>  tools/perf/util/parse-events.c                | 11 ++--
>  tools/perf/util/pmu.c                         | 38 +++++++-----
>  tools/perf/util/pmu.h                         |  7 ++-
>  tools/perf/util/probe-event.c                 |  3 +-
>  tools/perf/util/symbol-elf.c                  |  7 ++-
>  15 files changed, 200 insertions(+), 86 deletions(-)

Pulled into tip:perf/core, thanks a lot Arnaldo!

	Ingo
