From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Jan 2010 20:35:44 +0000
Subject: [PATCH] ARM: fix "BUG: using smp_processor_id() in preemptible
	code"
In-Reply-To: <1262193440-17794-1-git-send-email-rabin@rab.in>
References: <1262193440-17794-1-git-send-email-rabin@rab.in>
Message-ID: <20100101203544.GG16220@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2009 at 10:47:20PM +0530, Rabin Vincent wrote:
> Fix the following warning, which appears when the register dump for a
> faulting process is printed in a kernel with SMP, DEBUG_PREEMPT, and
> DEBUG_USER (with user_debug=31) enabled:

Well, the CPU number displayed here in preemptible contexts is rather
meaningless - it doesn't necessarily reflect the CPU where the problem
originally occurred.

Maybe we should use raw_smp_processor_id() here - which is fine because
this is just debugging, and it being wrong doesn't cause unsafe
conditions.
