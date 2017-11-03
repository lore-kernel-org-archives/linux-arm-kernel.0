From: julien.thierry@arm.com (Julien Thierry)
Date: Fri,  3 Nov 2017 11:44:15 +0000
Subject: [PATCH v2 0/3] Ftrace fixes
Message-ID: <1509709458-44541-1-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>From what Steve Rostedt said, we shouldn't rely on ftrace_trace_function
not being ftrace_stub when using the function graph tracer. As x86 does,
always check whether function graph tracing is requested in static tracing.

While testing that I didn't break things, I discovered that the perf ftrace
builtin doesn't handle kernels built without function graph tracer
(regardless of whether tracing is dynamic or not).

First and second patches fixe the ftrace issue for arm64 and arm
respectively.
Third patch fixes the perf front-end.

Changes since v1:
* Added fix for arm suggested by Akashi Takahiro
* Reset graph depth file when it exists

Cheers,

Julien Thierry (3):
  arm64: Fix static use of function graph
  arm: ftrace: function_graph with DYNAMIC_FTRACE
  perf: Fix ftrace builtin when kernel doesn't have function_graph

 arch/arm/kernel/entry-ftrace.S   | 14 +++++++-------
 arch/arm64/kernel/entry-ftrace.S | 12 +++---------
 tools/perf/builtin-ftrace.c      | 14 +++++++++++++-
 3 files changed, 23 insertions(+), 17 deletions(-)

--
1.9.1
