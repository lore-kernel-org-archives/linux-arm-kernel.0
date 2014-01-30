From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 30 Jan 2014 09:31:04 -0500
Subject: [PATCH] ARM: keystone: dts: disable "msmcsram" clock
In-Reply-To: <52EA5A8F.7070107@ti.com>
References: <1391082343-13371-1-git-send-email-ivan.khoronzhuk@ti.com>
 <448912EABC71F84BBCADFD3C67C4BE52A0B4B6@DBDE04.ent.ti.com>
 <52EA5A8F.7070107@ti.com>
Message-ID: <52EA6228.8030008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 January 2014 08:58 AM, Ivan Khoronzhuk wrote:
> Ok. I will delete node for this clock from DT and send v1
> 
Sorry for the html reply first of all. That node should never have
been actually added since the clock is not suppose to be touched even
in low power states. Change log should say something like this ...

"MSMC is the coherency interconnect and all the coherent masters are
connected to it including devices which are not under Linux OS control.
MSMC clock should not be toched even in low power states."

So drop the clock node o.w without 'clk_ignore_unused' will disable
the clock leading to system stall.

I wil try get these in rc's since its a bug fix

Regards,
Santosh
