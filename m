From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jun 2014 10:41:57 +0100
Subject: [PATCH] Fixes gemmi_idle in file idle.c
In-Reply-To: <1404096760-5239-1-git-send-email-xerofoify@gmail.com>
References: <1404096760-5239-1-git-send-email-xerofoify@gmail.com>
Message-ID: <20140630094157.GT32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 29, 2014 at 10:52:40PM -0400, Nicholas Krause wrote:
> disables the IRQ line in gemmi_idle before calling cpu_do_idle.
> In addition, according to the Fixme message in this file fixes
> races that may occur due to not disabling the IRQ before calling
> cpu_do_idle.

1) the idle method is called with interrupts already disabled.
2) I wonder if you read the comment above the comment you removed, and
   if so, why it wasn't removed.
3) can you indicate how the hardware problem has been fixed, or give some
   justification why this change should be accepted.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
