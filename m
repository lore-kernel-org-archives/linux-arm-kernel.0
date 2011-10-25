From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Oct 2011 12:37:31 +0100
Subject: [PATCH 01/12] ARM: clean up idle handlers
In-Reply-To: <1319449801-12367-2-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
	<1319449801-12367-2-git-send-email-nico@fluxnic.net>
Message-ID: <20111025113731.GA14840@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 05:49:50AM -0400, Nicolas Pitre wrote:
> Let's factor out the need_resched() check instead of having it duplicated
> in every pm_idle implementations to avoid inconsistencies (omap2_pm_idle
> was missing it already).

If we do this, we should talk to the other architecture maintainers as
well to keep all architectures pm_idle hooks the same.
