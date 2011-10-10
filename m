From: khilman@ti.com (Kevin Hilman)
Date: Mon, 10 Oct 2011 16:58:46 -0700
Subject: [PATCH v6 08/16] OMAP2+: UART: Store certain reg values to port
	structure
In-Reply-To: <1317380495-584-8-git-send-email-govindraj.raja@ti.com>
	(Govindraj R.'s message of "Fri, 30 Sep 2011 16:31:34 +0530")
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-8-git-send-email-govindraj.raja@ti.com>
Message-ID: <8739f0bdqh.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> In preparation to runtime conversion add missing uart regs to
> port structure which can be used in context restore.
> Also ensuring all uart reg info's are part of port structure.
>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

IMO, this should come later in the series to avoid adding bunch of code
that gets moved in a subsequent patch.

First, convert to runtime PM (current patch 9/16)
Then, add a patch to move context save/restore into driver.
Then, add this patch.

Kevin
