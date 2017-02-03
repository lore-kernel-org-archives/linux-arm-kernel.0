From: hekuang@huawei.com (He Kuang)
Date: Fri, 3 Feb 2017 11:06:07 +0000
Subject: [PATCH v2 3/3] perf tools: Add missing newline in debug messages
In-Reply-To: <20170203110607.97529-1-hekuang@huawei.com>
References: <20170203110607.97529-1-hekuang@huawei.com>
Message-ID: <20170203110607.97529-3-hekuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two debug messages are missing the trailing newline.

Signed-off-by: He Kuang <hekuang@huawei.com>
---
 tools/perf/util/bpf-loader.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 36c8611..bc6bc70 100644
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
1.8.5.2
