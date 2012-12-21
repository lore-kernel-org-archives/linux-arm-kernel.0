From: torbenh@linutronix.de (Torben Hohn)
Date: Fri, 21 Dec 2012 15:06:14 +0100
Subject: Improve timer Resolution on imx28
Message-ID: <1356098776-10498-1-git-send-email-torbenh@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this Series increases the timer frequency and decreases min_delta_ns.
I saw pretty high max latencies with cyclictest: ~600us.

The cause was the min_delta_ns value of 0xf 32kHz clockcycles.
But with the 32kHz Clock, the period is still around 30us.
So we just increase the clock freqeuncy driving the timers
here.
