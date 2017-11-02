From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Nov 2017 18:31:24 +0000
Subject: [PATCH] arm64: ensure __dump_instr() checks addr_limit
In-Reply-To: <20171102161203.4704-1-mark.rutland@arm.com>
References: <20171102161203.4704-1-mark.rutland@arm.com>
Message-ID: <20171102183124.l35jxdywnoq2b7vx@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 04:12:03PM +0000, Mark Rutland wrote:
> It's possible for a user to deliberately trigger __dump_instr with a
> chosen kernel address.
> 
> Let's avoid problems resulting from this by using get_user() rather than
> __get_user(), ensuring that we don't erroneously access kernel memory.
> 
> Where we use __dump_instr() on kernel text, we already switch to
> KERNEL_DS, so this shouldn't adversely affect those cases.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: 60ffc30d5652810d ("arm64: Exception handling")
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: stable at vger.kernel.org

Queued for 4.14. Thanks.

-- 
Catalin
