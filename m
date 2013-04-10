From: robherring2@gmail.com (Rob Herring)
Date: Tue,  9 Apr 2013 22:08:16 -0500
Subject: [RFC PATCH 2/3] pstore ram: remove the power of buffer size limitation
In-Reply-To: <1365563297-12480-1-git-send-email-robherring2@gmail.com>
References: <1365563297-12480-1-git-send-email-robherring2@gmail.com>
Message-ID: <1365563297-12480-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

There doesn't appear to be any reason for the overall pstore RAM buffer to
be a power of 2 size, so remove it. The individual console, ftrace and oops
buffers are still a power of 2 size.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Colin Cross <ccross@android.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel at vger.kernel.org
---
 fs/pstore/ram.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 288f068..f980077 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -391,8 +391,6 @@ static int ramoops_probe(struct platform_device *pdev)
 		goto fail_out;
 	}
 
-	if (!is_power_of_2(pdata->mem_size))
-		pdata->mem_size = rounddown_pow_of_two(pdata->mem_size);
 	if (!is_power_of_2(pdata->record_size))
 		pdata->record_size = rounddown_pow_of_two(pdata->record_size);
 	if (!is_power_of_2(pdata->console_size))
-- 
1.7.10.4
