From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 21 Dec 2016 19:37:03 +0800
Subject: How to remove warn msg "cache: parent cpui should not be sleeping"
 i=1, 2, 3...
Message-ID: <20161221193703.6eac880c@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm not sure this is a bug, when wake up from s2ram, I could get something
like:

[  313.271464] Enabling non-boot CPUs ...
[  313.271551] CPU1: Booted secondary processor
[  313.271556] Detected VIPT I-cache on CPU1
[  313.301378]  cache: parent cpu1 should not be sleeping
[  313.301504] CPU1 is up
[  313.301582] CPU2: Booted secondary processor
[  313.301585] Detected VIPT I-cache on CPU2
[  313.331485]  cache: parent cpu2 should not be sleeping
[  313.331605] CPU2 is up
[  313.331683] CPU3: Booted secondary processor
[  313.331686] Detected VIPT I-cache on CPU3
[  313.361599]  cache: parent cpu3 should not be sleeping
[  313.361719] CPU3 is up

This is because we call cpu_device_create() when secondary cpu is brought
online, the cpu_cache device's parent device: cpu device isn't already
resumed, all device resume will resume after secondary cores are brought
up.

What's the elegant solution to remove this warning msg?

Thanks in advance,
Jisheng
