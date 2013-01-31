From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 Jan 2013 15:35:45 +0000
Subject: [PATCHv5 07/16] arm: arch_timer: add isbs to register accessors
In-Reply-To: <1359634539-9580-8-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
 <1359634539-9580-8-git-send-email-mark.rutland@arm.com>
Message-ID: <20130131153545.GI12877@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 12:15:30PM +0000, Mark Rutland wrote:
> Without the isbs in arch_timer_get_cnt{p,v}ct the cpu may speculate
> reads and return stale values. This could be bad for code sensitive to
> changes in expected deltas between calls (e.g. the delay loop).
> 
> Without isbs in arch_timer_reg_write the processor may reorder
> instructions around enabling/disabling of the timer or writing the
> compare value, which we probably don't want.
> 
> This patch adds isbs to prevent those issues.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
