From: julien.thierry@arm.com (Julien Thierry)
Date: Wed,  1 Nov 2017 14:33:42 +0000
Subject: [PATCH 0/2] Ftrace fixes
Message-ID: <1509546824-46165-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>From what Steve Rostedt said, we shouldn't rely on ftrace_trace_function
not being ftrace_stub when using the function graph tracer. As x86 does,
always check whether function graph tracing is requested in static tracing.

While testing that I didn't break things, I discovered that the perf ftrace
builtin doesn't handle kernels built without function graph tracer
(regardless of whether tracing is dynamic or not).

First patch fixes the ftrace issue.
Second patch fixes the perf front-end.

Cheers,

Julien Thierry (2):
  arm64: Fix static use of function graph
  perf: Fix ftrace builtin when kernel doesn't have function_graph

 arch/arm64/kernel/entry-ftrace.S | 12 +++---------
 tools/perf/builtin-ftrace.c      |  3 ++-
 2 files changed, 5 insertions(+), 10 deletions(-)

--
1.9.1
