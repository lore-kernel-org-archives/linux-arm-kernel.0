From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 12 Sep 2014 00:05:00 +0200
Subject: [PATCH] mtd: nand: atmel_nand: retrieve NFC clock
In-Reply-To: <20140911173854.73b201e7@bbrezillon>
References: <1410446617-29572-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20140911152029.GA16666@arch> <20140911173854.73b201e7@bbrezillon>
Message-ID: <20140912000500.5a1d5f75@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Boris BREZILLON,

On Thu, 11 Sep 2014 17:38:54 +0200, Boris BREZILLON wrote:

> > Anyway, with or without the docs I think this patch breaks DT backward
> > compatibility.
> > 
> > Or am I missing something?
> 
> Indeed, this block of code should be placed at the end of the probe
> function. I'll fix that.
> 
> Note that if the clk is missing it just print a warning message and
> return 0, so after moving the code, it should not break DT backward
> compat ;-).

You may want to use:

	dev_warn(FW_WARN "NFC clock missing, update your Device	Tree\n");

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
