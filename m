From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jul 2015 20:08:19 +0100
Subject: [PATCH] arm: fault.c: fix unhandled page fault message
In-Reply-To: <1436974250-4999-1-git-send-email-lkurusa@redhat.com>
References: <1436974250-4999-1-git-send-email-lkurusa@redhat.com>
Message-ID: <20150715190819.GE7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 05:30:50PM +0200, Levente Kurusa wrote:
> Even if the signal was handled using signal(2) the message
> would be printed. Fix that by checking whether the signal
> is handled.

Why?

Even if the application handles the signal, the point of this debugging is
to have the kernel report the reason for the fault.

Just because the application has installed a SIGSEGV handler to print some
nice "oops" message, and to cleanly shut down (eg, like Xorg) doesn't mean
we should hide this debugging.  In fact, as such handlers generally get in
the way of getting a decent dump from the application, having the kernel
report this information is even more valuable in this situation.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
