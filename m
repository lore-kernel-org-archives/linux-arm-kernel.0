From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Nov 2011 16:54:08 +0000
Subject: [PATCH] ARM: restart: davinci: use new restart hook
In-Reply-To: <1321296775-5110-1-git-send-email-nsekhar@ti.com>
References: <1321296775-5110-1-git-send-email-nsekhar@ti.com>
Message-ID: <20111115165408.GA9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2011 at 12:22:55AM +0530, Sekhar Nori wrote:
> Rather than using davinci specifci davinci_soc_info based
> restart hook, use the existing arm_pm_restart pointer
> instead.

Thanks for looking at this.

Although you're using arm_pm_restart directly, I'd much prefer to use
the .restart method in the machine description of at all possible.

One of the problems if initializing arm_pm_restart in various functions
is that unless you're familiar with the order in which these functions
are called, you don't know what's being used.  With the machine
description holding it, it's obvious which platform should be using
what method.

Any chance this patch could be reworked along those lines?

Thanks.
