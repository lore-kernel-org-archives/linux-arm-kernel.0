From: 914059751@qq.com (=?gbk?B?uvrR7sr3?=)
Date: Tue, 19 Jan 2010 15:42:53 +0800
Subject: Query about loops_per_jiffy
Message-ID: <tencent_5CA6CD330328846756327199@qq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, oldhands:)
     
I have a question about how loops_per_jiffy converted to BogoMips, 

loops_per_jiffy * HZ  <-----------  that's number of instructions CPU executes in a second
BogoMips <-------------------------- Millions of instructions CPU executes in a second

so , do the math!
(loops_per_jiffy * HZ)/1000,000   will give a BogoMips value.

then why calibrate_delay do it like the following:
	printk(KERN_CONT "%lu.%02lu BogoMIPS (lpj=%lu)\n",
			loops_per_jiffy/(500000/HZ),
			(loops_per_jiffy/(5000/HZ)) % 100, loops_per_jiffy);


Am I missing something ?
Great thanks for any tips!
