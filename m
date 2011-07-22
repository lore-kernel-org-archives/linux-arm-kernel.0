From: arun_bharadwaj@sfu.ca (Arun Bharadwaj)
Date: Thu, 21 Jul 2011 17:40:48 -0700 (PDT)
Subject: Booting kernel on Android phone with perf-events enabled.
In-Reply-To: <1983457730.1920025.1311294933939.JavaMail.root@jaguar8.sfu.ca>
Message-ID: <1744593259.1920344.1311295248064.JavaMail.root@jaguar8.sfu.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am a graduate student at Simon Fraser University. As a part of my research I want to instrument application performance and power consumption in a fine grain manner on my HTC Desire Android phone, which has an ARMv7 snapdragon processor. I have compiled my own kernel and running on it. When I try to enable the Performance Counters and Events option in config and then try, my phone fails to boot; it is just stuck at the HTC logo. Is there anything you could suggest me regarding this?

Also, I tried writing a simple proc interface to just read the Cycle Counter value. All I am doing is: asm volatile("mrc p15, 0, %0, c9, c13, 0" : "=r" (value)); But I see ambiguous values. I see that the counter value is not really incrementing, I just get a few random numbers. Could you tell me if I am doing anything wrong? I tried a test by trying to disable the CCNTR register by writing 1 to the D-bit in the PMCR register. This does not seem to be disabling the counter and it still continues with the above mentioned behaviour. Is there anything that I am missing out?

thanks
-- 
Arun R Bharadwaj
Graduate Student
School of Computing Science
Simon Fraser University.
