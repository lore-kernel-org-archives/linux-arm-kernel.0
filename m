From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Apr 2010 19:33:36 +0100
Subject: [PATCH v2] ARM: Fix "BUG: scheduling while atomic:
	swapper/0/0x00000002
In-Reply-To: <1271492144-26995-1-git-send-email-santosh.shilimkar@ti.com>
References: <1271492144-26995-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20100417183336.GB24299@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 17, 2010 at 01:45:44PM +0530, Santosh Shilimkar wrote:
> +		/*
> +		 * Since idle thread getting re-used, call
> +		 * init_idle() to set up the idle thread for given
> +		 * CPU. Additionally it also resets the preempt count

"Since this idle thread is being re-used, call
init_idle() to reinitialize the thread structure."

I don't think we need to mention the preempt count explicitly because
that's a detail of reinitializing the thread structure.
