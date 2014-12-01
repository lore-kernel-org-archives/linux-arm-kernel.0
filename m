From: vigneshr@ti.com (Vignesh R)
Date: Mon, 1 Dec 2014 15:23:25 +0530
Subject: [PATCH v4 0/6] Touchscreen performance related fixes
In-Reply-To: <20141124115116.GA14997@linutronix.de>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <20141124115116.GA14997@linutronix.de>
Message-ID: <547C3A95.30605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Monday 24 November 2014 05:21 PM, Sebastian Andrzej Siewior wrote:
> * Vignesh R | 2014-11-14 10:37:25 [+0530]:
> 
>> This series of patches fix TSC defects related to lag in touchscreen
>> performance and cursor jump at touch release. The lag was result of
>> udelay in TSC interrupt handler. Cursor jump due to false pen-up event.
>> The patches implement Advisory 1.0.31 in silicon errata of am335x-evm
> am335x not -evm. The am335x-evm is a board (with its own advisory
> document) built around the SoC.
> 
> Just testing the v4. I can use now IIO and touchscren at the same time.
> back at v1 I reported that it does not work, this has been fixed now.
> I had it running for a few minutes, now I see one of WARN_ON() beeing
> triggered (I've cut a few numbers so don't wonder about PID 2 and so on):
> 

I fixed the issue that was triggering the WARN_ON(). I think it would be
better if you tested these patches, before I posted them on the
mainline. I don't want to clutter the list with too main versions. Here
is the link to the tree with latest changes:

git clone -b tsc-devel git://git.ti.com/kernel/tsc-adc.git
(tsc-devel branch)

Please test the above tree and let me know the results.
I will post new version(v5) if there are no issues wrt IIO and TSC
working at the same time.

The cursor jump at touch release has been fixed. But I do see random
cursor movement when dragging on the screen. This is not due to false
pen-up events. My patches do not aim at fixing them. (the aim is to
remove udelay in irq handler and fix false pen-ups).
With these changes, false pen-ups have been eliminated and there is a
significant improvement in the performance of TSC. I feel these patches
can go in, if there are no other serious issues.

I will work on random cursor jump in a separate patch series.

Regards
Vignesh
