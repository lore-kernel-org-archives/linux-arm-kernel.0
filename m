From: stano@meduna.org (Stanislav Meduna)
Date: Tue, 30 Apr 2013 14:13:07 +0200
Subject: Need help to measure and tune the latency in Linux RT
In-Reply-To: <20130430111021.GC31290@titan.lakedaemon.net>
References: <CALJd4cbfqRFiGHshv8A+0A8kFo_qW=rvREsdgj3jQ=-0Rix0-g@mail.gmail.com>
 <20130430111021.GC31290@titan.lakedaemon.net>
Message-ID: <517FB553.3000001@meduna.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> This critical thread is at RR priority 50.

Try to put it higher than the irq thread handling your HD hardware.
I've even encountered hardware where I had to put the ATA thread
in the SHED_OTHER domain - see [1] for the thread.

>> I used a HR timer thread with RR pri 55 to wakeup the critical thread
>> every 1 milli sec to do the job.

Which prio is the ksoftirqd running at? The HRTIMER interrupts are
routed through it so it also has to be high enough.

I got burned with this myself [2]

Regards
                                     Stano

[1] http://www.spinics.net/lists/linux-rt-users/msg08711.html
[2] http://www.spinics.net/lists/linux-rt-users/msg08745.html
