From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 Jan 2013 15:36:47 +0000
Subject: [PATCHv5 11/16] arm64: arm_generic: prevent reading stale time
In-Reply-To: <1359634539-9580-12-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
 <1359634539-9580-12-git-send-email-mark.rutland@arm.com>
Message-ID: <20130131153647.GK12877@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 12:15:34PM +0000, Mark Rutland wrote:
> Currently arch_counter_get_cnt{p,v}ct can be speculated, allowing for
> stale time values to be read. This could be problematic for the delay
> loop and other sensitive functions, as the time delta could jump around
> unexpectedly.
> 
> This patch adds isbs to arch_counter_get_cnt{p,v}ct, preventing this
> possibility.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
