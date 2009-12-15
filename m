From: andy@warmcat.com (Andy Green)
Date: Tue, 15 Dec 2009 17:31:52 +0000
Subject: Using SD cards on Samsung S3C2410/S3C2440 based systems
In-Reply-To: <200912151443.59761.jbe@pengutronix.de>
References: <200912151443.59761.jbe@pengutronix.de>
Message-ID: <4B27C808.7080800@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/09 13:43, Somebody in the thread at some point said:

Hi Juergen -

> s3c2440-sdi s3c2440-sdi: running at 0kHz (requested: 0kHz).
> s3c2440-sdi s3c2440-sdi: running at 399kHz (requested: 400kHz).

> mmc0: new SD card at address 8d7e
> mmcblk0: mmc0:8d7e SD02G 1.83 GiB
>   mmcblk0: p1 p2
>
> Any idea why most of the cards do not work?

-110 is timeout... it might be worth setting CONFIG_PRINTK_TIME and 
looking to see what the real time looks like in both cases.

I guess you have the pullups on your PCB OK for the MMC bus (everything 
except CLK), and you looked with your scope that power is OK there from 
early boot and the signals look well-formed.  (And the clock is 400kHz).

I noticed that at 115kbps console set on the kernel commandline on an 
iMX31, I can cause SD Card boot we use to fail like you describe at the 
moment just by setting loglevel=8 on the commandline.  So try one of the 
"bad" cards at loglevel=4 and see if that changes anything.

-Andy
