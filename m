From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 24 Jul 2010 09:23:35 +0100
Subject: [PATCH 2/3] arm: mm: do not set missing flags on ScorpionMP
In-Reply-To: <1279911483-7039-3-git-send-email-johlstei@codeaurora.org>
References: <1279911483-7039-1-git-send-email-johlstei@codeaurora.org>
	<1279911483-7039-3-git-send-email-johlstei@codeaurora.org>
Message-ID: <20100724082334.GB15571@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 23, 2010 at 11:58:02AM -0700, Jeff Ohlstein wrote:
> From: Steve Muckle <smuckle@codeaurora.org>
> 
> ScorpionMP does not have the SMP/nAMP mode and TLB ops
> broadcasting bits in the ACTLR.

Please provide a separate instance of __v7_proc_info for your processor
and direct it to jump into the __v7_setup code after this setup instead.
