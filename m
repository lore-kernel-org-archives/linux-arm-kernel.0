From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu,  9 Feb 2017 22:39:10 -0300
Subject: [PATCH 02/32] perf bpf: Add missing newline in debug messages
In-Reply-To: <20170210013940.9998-1-acme@kernel.org>
References: <20170210013940.9998-1-acme@kernel.org>
Message-ID: <20170210013940.9998-3-acme@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: He Kuang <hekuang@huawei.com>

These two debug messages are missing the trailing newline.

Signed-off-by: He Kuang <hekuang@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Bintian Wang <bintian.wang@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Link: http://lkml.kernel.org/r/20170207073412.26983-2-hekuang at huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 36c861103291..bc6bc7062eb4 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -670,13 +670,13 @@ int bpf__probe(struct bpf_object *obj)
 
 		err = convert_perf_probe_events(pev, 1);
 		if (err < 0) {
-			pr_debug("bpf_probe: failed to convert perf probe events");
+			pr_debug("bpf_probe: failed to convert perf probe events\n");
 			goto out;
 		}
 
 		err = apply_perf_probe_events(pev, 1);
 		if (err < 0) {
-			pr_debug("bpf_probe: failed to apply perf probe events");
+			pr_debug("bpf_probe: failed to apply perf probe events\n");
 			goto out;
 		}
 
-- 
2.9.3
