From: rubini-list@gnudd.com (Alessandro Rubini)
Date: Tue, 19 Jan 2010 09:21:19 +0100
Subject: Query about loops_per_jiffy
In-Reply-To: <tencent_5CA6CD330328846756327199@qq.com>
References: <tencent_5CA6CD330328846756327199@qq.com> 
Message-ID: <20100119082119.GA20977@morgana.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> (loops_per_jiffy * HZ)/1000,000   will give a BogoMips value.

No, it will give a BogoLips (loops per second). A loop is two instructions,
in ./arch/arm/lib/delay.S (function __delay) called by init/calibrate.c .
To have bogomips you need to multiply by two.

> then why calibrate_delay do it like the following:
> 	printk(KERN_CONT "%lu.%02lu BogoMIPS (lpj=%lu)\n",
> 			loops_per_jiffy/(500000/HZ),
> 			(loops_per_jiffy/(5000/HZ)) % 100, loops_per_jiffy);

It's correct, using normal integer aritmetics care.

/alessandro
