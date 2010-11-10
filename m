From: mkl0301@gmail.com (Lin Mac)
Date: Wed, 10 Nov 2010 12:00:36 +0800
Subject: Booting CNS3420 EVB v 1.3 failed with 2.6.36 (and 2.6.35)
In-Reply-To: <20101109101433.GA17423@oksana.dev.rtsoft.ru>
References: <AANLkTik-4p=rBVO9GVoa8L2pEVQtaPkyYmWebuZwAshG@mail.gmail.com>
	<20101105074418.GA5864@oksana.dev.rtsoft.ru>
	<AANLkTimH0JVcB31usN5srPNYCR8sR75J23FtTPQK1Chf@mail.gmail.com>
	<20101109101433.GA17423@oksana.dev.rtsoft.ru>
Message-ID: <AANLkTikF+QMcm0cnn0QUOMJaLb=BTbQZA2oCVas4-71q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/9 Anton Vorontsov <cbouatmailru@gmail.com>:
>> BTW, the default boot command includes root=/dev/mmcblk0p1, but
>> CONFIG_MMC_SDHCI_CNS3XXX is not enabled.
>> Even if it is enabled, I got a crash once mounted. It works fine
>> without L1 cache enabled (CONFIG_CPU_ICACHE_DISABLE,
>> CONFIG_CPU_DCACHE_DISABLE). So it seems there are some cache coherency
>> issue on the SDHC device.
> I recalling I observed something like this, and it was somehow
> related to the memory setup. The old (Jan 20 2010) U-Boot that
> I used was configuring RAM incorrectly, and caches were just
> unveiling the problem.

I was using vanilla kernel. And I just found that Catalin's patches
for cache maintenance changes is not in vanilla kernel. Using
Catalin's kernel fixed this issue. It is due to the SDHCI driver is in
PIO mode, and hit the cache coherency issue with PIO mode.

Best Regards,
Mac Lin.
