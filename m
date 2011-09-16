From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Fri, 16 Sep 2011 15:00:18 +0530
Subject: [PATCH v15 06/12] OMAP: dmtimer: switch-over to platform device
	driver
In-Reply-To: <CAC83ZvKGoucZ=xQSa7GEk7Gg8jcFBQE==1a6m4=+nzDRrsw+jw@mail.gmail.com>
References: <1315516098-29761-1-git-send-email-tarun.kanti@ti.com>
	<1315516098-29761-7-git-send-email-tarun.kanti@ti.com>
	<20110914214533.GA30941@atomide.com>
	<CAC83ZvJgPYb3JbWT4SKXpQvq-vdKK4b6hd6E-ik5uyRCqgwWsg@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59302575A050D@dbde02.ent.ti.com>
	<20110915165810.GA2284@atomide.com>
	<20110915170548.GB2284@atomide.com>
	<CAC83ZvKGoucZ=xQSa7GEk7Gg8jcFBQE==1a6m4=+nzDRrsw+jw@mail.gmail.com>
Message-ID: <CAC83ZvKXEb7MTujP4JqhrPeysYxQcLF+BV-J9tpYoRwWGVZ8_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
>>> 1. Modify the inline access functions to take the PEND and others
>>> ? ?if needed registers as a parameter
>>>
>>> 2. Modify mach-omap2/timer.c to initialize the PEND and others
>>> ? ?in the SoC specific timer_init function
Just to make my understanding complete, need some clarifications:
As we would end up modifying almost all inline functions, what naming
convention should we follow for the parameters? For instance, PEND
is related to TWPS register. So are you suggesting using parameter
names related to respective registers in each inline functions?
If that is the case we would end up declaring lot of local variables along
with PEND. Instead, we could very well have just two variables to
represent functional and interrupt offsets.

Also, in plat-omap/dmtimer.c, timer_regs{} stores the register values and
not the register offsets. Therefore, we would not be able to pass as
parameters, timer->context.<x> ... etc.

Please let me know if I am off-track in my understanding.
Thanks.
--
Tarun
[...]
