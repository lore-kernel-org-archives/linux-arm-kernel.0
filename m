From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Sep 2014 23:55:31 +0100
Subject: [PATCH 3/3] arm: vfp: Bounce undefined instructions in
 vectored mode
In-Reply-To: <1411076592-6157-4-git-send-email-sboyd@codeaurora.org>
References: <1411076592-6157-1-git-send-email-sboyd@codeaurora.org>
 <1411076592-6157-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140918225531.GG5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 02:43:12PM -0700, Stephen Boyd wrote:
> From: Stepan Moskovchenko <stepanm@codeaurora.org>
> 
> Certain ARM CPU implementations (e.g. Cortex-A15) may not raise a
> floating- point exception whenever deprecated short-vector VFP
> instructions are executed. Instead these instructions are treated
> as UNALLOCATED. Change the VFP exception handling code to emulate
> short-vector instructions even if FPEXC exception bits are not
> set.

Purely out of interest, how much use do these instructions have in
real programs?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
