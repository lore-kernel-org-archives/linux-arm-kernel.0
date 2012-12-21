From: marex@denx.de (Marek Vasut)
Date: Fri, 21 Dec 2012 15:52:17 +0100
Subject: Improve timer Resolution on imx28
In-Reply-To: <1356098776-10498-1-git-send-email-torbenh@linutronix.de>
References: <1356098776-10498-1-git-send-email-torbenh@linutronix.de>
Message-ID: <201212211552.17744.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Torben Hohn,

> Hi,
> 
> this Series increases the timer frequency and decreases min_delta_ns.
> I saw pretty high max latencies with cyclictest: ~600us.
> 
> The cause was the min_delta_ns value of 0xf 32kHz clockcycles.
> But with the 32kHz Clock, the period is still around 30us.
> So we just increase the clock freqeuncy driving the timers
> here.

Thanks for the set. Just a really quick question -- won't this under no 
circumstance cause interrupt storm?

Best regards,
Marek Vasut
