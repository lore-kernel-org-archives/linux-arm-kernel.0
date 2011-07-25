From: scwilliams@nvidia.com (Scott Williams)
Date: Mon, 25 Jul 2011 11:49:43 -0700
Subject: cpu_suspend does not flush the L2 cache
Message-ID: <74C67D49A66F0848B6F4548360B2EDB58DED35BC42@HQMAIL04.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In 2.6.39, CPU suspend/resumes crashes if an outer cache controller (like a PL310) is configured and enabled. cpu_suspend only flushes the L1 cache. If an outer cache controller is enabled, the context and saved stack pointer are left sitting in the L2 memory. An attempt to resume a secondary CPU without shutting down the entire CPU complex and flushing the entire L2 cache will cause the secondary CPU to crash because the stack pointer in sleep_save_sp is invalid in L3 memory.

Scott Williams
Sr. Software Engineer
NVIDIA Corporation

--
nvpublic
