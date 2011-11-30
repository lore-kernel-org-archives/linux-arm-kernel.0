From: jszhang3@gmail.com (JiSheng Zhang)
Date: Wed, 30 Nov 2011 17:30:34 +0800
Subject: help for BogoMIPS issue on linux kernel 3.0
Message-ID: <CADyp2PdNKspTWJmPrOecY=JtzbG74k-3RcV-3GWXLuBTuSOzNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi List,

I need your help. Currently, I'm porting Linux kernel to one arm SoC.
I came across one strange problem: the BogoMIPS isn't correct under
SMP, but it's correct under UP.

I tried give maxcpus=1, or disable L1/2 cache, both didn't help. Since
the any secondary cpu isn't booted up when bootcpu calls
calibrate_delay(), all the code should be the same, why the
calibrate_delay gives wrong BogoMIPS under SMP?

Thanks in advance,
Jisheng
