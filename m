From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 09 Oct 2013 11:24:10 +0200
Subject: [PATCH 8/8] ARM: add initial support for Marvell Berlin SoCs
In-Reply-To: <20131009112058.683739d0@xhacker>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1381235073-17134-9-git-send-email-sebastian.hesselbarth@gmail.com>
 <20131009112058.683739d0@xhacker>
Message-ID: <525520BA.3010304@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Jisheng,

[...]

>> +config MACH_MV88DE3100
> Can you please use MACH_BERLIN2? This is what we used internally in latest BSP
>> +	bool "Marvell 88DE3100 (Armada 1500)"
>> +	select ARM_GIC
>> +	select CACHE_L2X0
> The tauros3 and PL310 are different although the programming interface are
> compatible. In PJ4B and Tauros3, the CP15 cache maintenance commands include
> both L1 and L2, memory mapped PA-based maintenance operations in L2 are not needed.
> How to handle this in cache-l2x0.c?

In this case you can do the same things we have done for Aurora when we use
the "aurora-system-cache" compatible string.

[...]

Regards,
Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
