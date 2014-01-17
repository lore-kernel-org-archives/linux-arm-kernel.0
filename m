From: ananaza@iki.fi (Antti Miettinen)
Date: Fri, 17 Jan 2014 11:07:36 +0200
Subject: [PATCH] arch_timer: Move delay timer to drivers clocksource
In-Reply-To: <20140116121649.GG30257@mudshark.cambridge.arm.com> (Will
 Deacon's message of "Thu, 16 Jan 2014 12:16:49 +0000")
References: <1389791227-24097-1-git-send-email-pgaikwad@nvidia.com>
 <20140115154526.GC3571@mudshark.cambridge.arm.com>
 <52D76BC8.6080405@nvidia.com>
 <20140116121649.GG30257@mudshark.cambridge.arm.com>
Message-ID: <878uufyo13.fsf@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:
> Why can't you use the C3STOP feature so that the arch-timer isn't used when
> you go idle?

That would mean falling back to broadcast timer, right? That's not
necessarily on the local CPU so wakeups would often wake two CPUs. Does
anyone have patches for using a CPU local timer as a fallback for
C3STOP timers?

	--Antti
