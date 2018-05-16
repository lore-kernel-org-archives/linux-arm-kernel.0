From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 May 2018 12:22:09 +0100
Subject: [PATCH] arm64: cmpwait: Clear event register before arming
 exclusive monitor
In-Reply-To: <1525092992-16819-1-git-send-email-will.deacon@arm.com>
References: <1525092992-16819-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180516112208.izapa5qdd5m4t6fy@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2018 at 01:56:32PM +0100, Will Deacon wrote:
> When waiting for a cacheline to change state in cmpwait, we may immediately
> wake-up the first time around the outer loop if the event register was
> already set (for example, because of the event stream).
> 
> Avoid these spurious wakeups by explicitly clearing the event register
> before loading the cacheline and setting the exclusive monitor.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Queued for 4.18. Thanks.

-- 
Catalin
