From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Dec 2010 13:51:10 +0000
Subject: [PATCH] ARM: tegra: timer: Separate clocksource and sched_clock
In-Reply-To: <1290039615-23407-1-git-send-email-ccross@android.com>
References: <1290039615-23407-1-git-send-email-ccross@android.com>
Message-ID: <20101213135110.GL8665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 17, 2010 at 04:20:15PM -0800, Colin Cross wrote:
> tegra_clocksource_read should not use cnt32_to_63, wrapping is
> already handled in the clocksource code.  Move the cnt32_to_63
> into the sched_clock function, and replace the use of clocksource
> mult and shift with a multiplication by 1000 to convert us to ns.

Colin,

Mind if I pick this up into my tree - I'm doing other work with
clocksources and sched_clock() at the moment which will clash with
this patch.

Thanks.
