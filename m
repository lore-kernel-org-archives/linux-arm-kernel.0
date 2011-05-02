From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 May 2011 00:40:12 +0100
Subject: Resend [PATCH 00/10] ARM: SMP initialization consolidation
In-Reply-To: <4DBBA509.6080203@codeaurora.org>
References: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
	<4DBBA509.6080203@codeaurora.org>
Message-ID: <20110502234012.GJ28001@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 10:58:33PM -0700, Stephen Boyd wrote:
> Have you seen Russell's response to similar attempts posted a few months
> back?
> 
> https://lkml.org/lkml/2010/11/30/243
> 
> and
> 
> http://lists.linaro.org/pipermail/linaro-dev/2010-November/001663.html
> 
> Just something to look over and consider.

I know of one SoC which has three cores on it, where two are optimized
for performance and one for low power.  They're all connected to the
SCU, and so are visible as three symetric CPUs.

Such a SoC may wish to do things differently from the current approach
(which is basically bring up all cores at boot) particularly as the
performance gained from each CPU is far from identical.  So I've been
nervous about moving the CPU map initialization into core code.

Note that the low power CPU may not be the last in the set, so merely
limiting the system to two CPUs is not the answer.
