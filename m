From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Nov 2014 12:05:49 +0000
Subject: [RFC] ptrace: add generic SET_SYSCALL request
In-Reply-To: <6358312.yt5WU3kBm9@wuerfel>
References: <1415346443-28915-1-git-send-email-takahiro.akashi@linaro.org>
 <54633F53.8020507@linaro.org> <20141112111352.GC26437@arm.com>
 <6358312.yt5WU3kBm9@wuerfel>
Message-ID: <20141112120549.GA4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 12:19:26PM +0100, Arnd Bergmann wrote:
> On Wednesday 12 November 2014 11:13:52 Will Deacon wrote:
> > Just do arm64. We already have the dedicated request for arch/arm/.
> 
> I wonder if we should define NT_ARM64_SYSTEM_CALL to the same value
> as NT_S390_SYSTEM_CALL (0x307), or even define it as an architecture-
> independent NT_SYSTEM_CALL number with that value, so other architectures
> don't have to introduce new types when they also want to implement it.

That would be a sane thing to do, so that tools which want to get at
this information can do in an almost standardised way for architectures
implementing this method.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
