From: dcb314@hotmail.com (David Binderman)
Date: Mon, 25 Apr 2016 20:31:54 +0000
Subject: linux-4.6-rc5/arch/arm/mach-vexpress/spc.c:332: possible typo ?
Message-ID: <DUB128-W495B590F6B8E0BF405721B9C620@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,

linux-4.6-rc5/arch/arm/mach-vexpress/spc.c:332]: (style) Variable 'perf_stat_reg' is assigned a value that is never used.

?? if (cluster_is_a15(cluster)) {
??????? req_type = CA15_DVFS;
??????? perf_cfg_reg = PERF_LVL_A15;
??????? perf_stat_reg = PERF_REQ_A15;
??? } else {
??????? req_type = CA7_DVFS;
??????? perf_cfg_reg = PERF_LVL_A7;
??????? perf_stat_reg = PERF_REQ_A7;
??? }

But local variable perf_stat_reg doesn't get used anywhere.

Suggest either delete or use.


Regards

David Binderman

 		 	   		  
