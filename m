From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 8 Jan 2015 19:54:08 +0800
Subject: [RFC] how to implement suspend to ram for arm64?
Message-ID: <20150108195408.01a8dfdb@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi list,

we need the suspend to ram feature on arm64. And I think the fundamental code
is ready, for example  __cpu_suspend() etc.

However, there are several issues need to be resolved...

1. where to put platform_suspend_ops implementation? drivers/power?

2. If the "put ddr to self refresh" code must be in EL3 or secure EL1, how
linux tell the firmware to trigger it? extend PSCI or use the context_id
of PSCI CPU_SUSPEND function?

3. where to put the cod of invoke suspend_to_ram psci call?

Thanks in advance,
Jisheng
