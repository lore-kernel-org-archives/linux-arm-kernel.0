From: nyushchenko@dev.rtsoft.ru (Nikita Yushchenko)
Date: Tue, 24 Nov 2015 18:05:37 +0300
Subject: [RFC/PATCH] arm: do not skip SMP init calls on SMP_ON_UP case
In-Reply-To: <5654799E.5080903@dev.rtsoft.ru>
References: <1448279946-19975-1-git-send-email-nyushchenko@dev.rtsoft.ru>
 <20151123120317.GN8644@n2100.arm.linux.org.uk>
 <5653015C.4020405@dev.rtsoft.ru> <56530769.4030403@arm.com>
 <5653099A.7020604@dev.rtsoft.ru> <56530AE6.2060407@dev.rtsoft.ru>
 <20151123130424.GQ8644@n2100.arm.linux.org.uk>
 <5654799E.5080903@dev.rtsoft.ru>
Message-ID: <56547CC1.6000009@dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm still trying to understand what is going on, and my printk()s show
> that this is not entirely true.
> 
> When smp_init() is entered on mainline om imx6s, cpu_possible_mask and
> cpu_present_mask both contain two cpus. These get initialized in
> arm_dt_init_cpu_maps() and stay unmodified since then.
> 
> But cpu_online() returns 1 for cpu0 and 0 from cpu1 - thus it is
> cpu_online() check, not possible_mask or present_mask, that prevents
> cpu1 initialization attempt.

Sorry was too quick to type.

cpu_online(0) is true and cpu_online(1) is false.
It is natural, since cpu0 is already running.
Thus cpu_up(1) is entered!
