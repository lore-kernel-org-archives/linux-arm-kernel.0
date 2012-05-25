From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 26 May 2012 00:45:38 +0100
Subject: [PATCH 01/20] arm: Do not call do_signal() with irqs disabled
In-Reply-To: <1337983476-22081-1-git-send-email-richard@nod.at>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
Message-ID: <20120525234538.GB32000@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 26, 2012 at 12:04:17AM +0200, Richard Weinberger wrote:
> get_signal_to_deliver() calls try_to_freeze() which might sleep.

True enough, and this problem has been around for some time, and it's
not as simple to fix as "lets just ignore everything else and enable
interrupts to shutup the warning".

There's bigger issues here with syscall restarting that should be
resolved first, and there's work in progress to do that.  Again,
like I said in my previous email, Al's done a great deal of work
in this area and I get the impression that you're redoing some of
that.
