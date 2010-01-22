From: 914059751@qq.com (rocky)
Date: Fri, 22 Jan 2010 09:11:29 +0800
Subject: =?gb2312?B?tPC4tDogUXVlcnkgYWJvdXQgbG9vcHNfcGVyX2ppZmZ5?=
In-Reply-To: <tencent_2543180B1828B0D317DCD9FC@qq.com>
References: <tencent_2543180B1828B0D317DCD9FC@qq.com>
Message-ID: <6134FC3AD99C4CA8A47F7E3D5E71C470@dufan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Green hand apology for the unintended CC, I should make this query personal.

 

  _____  

???: linux-arm-kernel-bounces at lists.infradead.org
[mailto:linux-arm-kernel-bounces at lists.infradead.org] ?? ???
????: 2010?1?19? 21:38
???: Alessandro Rubini
??: linux-arm-kernel
??: Re: Query about loops_per_jiffy

 

Are you  Alessandro Rubini of LINUX DEVICE DRIVER?

------------------ Original ------------------

From:  "Alessandro Rubini"<rubini-list@gnudd.com>;

Date:  Tue, Jan 19, 2010 04:21 PM

To:  "914059751"<914059751@qq.com>; 

Cc:  "linux-arm-kernel"<linux-arm-kernel@lists.infradead.org>; 

Subject:  Re: Query about loops_per_jiffy

 

> (loops_per_jiffy * HZ)/1000,000   will give a BogoMips value.

No, it will give a BogoLips (loops per second). A loop is two instructions,
in ./arch/arm/lib/delay.S (function __delay) called by init/calibrate.c ..
To have bogomips you need to multiply by two.

> then why calibrate_delay do it like the following:
>     printk(KERN_CONT "%lu.%02lu BogoMIPS (lpj=%lu)\n",
>             loops_per_jiffy/(500000/HZ),
>             (loops_per_jiffy/(5000/HZ)) % 100, loops_per_jiffy);

It's correct, using normal integer aritmetics care.

/alessandro

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100122/fc3ec93b/attachment.htm>
