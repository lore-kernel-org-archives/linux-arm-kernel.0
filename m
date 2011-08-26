From: santosh.shilimkar@ti.com (Santosh)
Date: Fri, 26 Aug 2011 21:39:29 +0530
Subject: [PATCH v14 REPOST 09/12] OMAP: dmtimer: use mutex instead of
	spinlock
In-Reply-To: <4E57BCF4.8030709@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
	<1310731501-13078-10-git-send-email-tarun.kanti@ti.com>
	<4E57BCF4.8030709@ti.com>
Message-ID: <4E57C539.6020201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 August 2011 09:04 PM, Santosh wrote:
> On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
>> Since the spinlock is not used in any interrupt context we can
>> replace it with mutex instead.
>>
>> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
>> ---
> Patch looks good but change log doesn't reflect it.
> Do you want to say that below API's are not used from
> interrupt context, so mutex should be good enough ?
>
This assumption is really not true. Time APIs can get called
from IRQ context from client drivers. You can just drop
this patch.

Regards
Santosh
