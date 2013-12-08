From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Dec 2013 10:14:35 +0000
Subject: [PATCH RFC] ARM: Provide default restart handler
In-Reply-To: <1386485609-4174-1-git-send-email-shc_work@mail.ru>
References: <1386485609-4174-1-git-send-email-shc_work@mail.ru>
Message-ID: <20131208101435.GT4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 08, 2013 at 10:53:29AM +0400, Alexander Shiyan wrote:
> This patch provides default restart handler if it is not explicitly specified.

So what happens on those platforms where it's already not specified?
There's 75 files with a machine descriptor without a .restart hook
specified or reference to arm_pm_restart.  You're potentially changing
the behaviour for those.
