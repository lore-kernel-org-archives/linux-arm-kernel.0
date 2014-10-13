From: nalajala.murali@gmail.com (Murali N)
Date: Mon, 13 Oct 2014 11:17:16 -0700
Subject: hrtimer timer firing behavior on multicore ARM processor
Message-ID: <CAF0TxbqM9qzKLUcy7Q8m7cahMmumUDpshr-tGRZFDD=o4QJ0SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,
I have a requirement where i need to setup a hrtimer that should
always fire on a particular cpu{0,1, 2 or 3} always. To achieve this
currently i am doing like below.

1) smp_call_function_single(cpu, create_hrtimer, NULL, 1);
2) create_hrtimer() executes on "cpu" specified and i am setting up a timer.

When i ran my test case i figure out that sometimes hrtimer interrupt
is firing on a different cpu.

I am under an assumption that hrtimers are per core based and which
always fires on cpu on which timer has been created. But from the test
case it is not that way.

Is my above assumption correct?
Is there anyway i can achieve my goal?

If it is not the right forum please direct to the right forum where i
can discuss.
