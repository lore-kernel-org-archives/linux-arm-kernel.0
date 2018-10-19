From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 19 Oct 2018 12:38:21 +0100
Subject: [RFC 12/17] arm64: move ptrauth keys to thread_info
In-Reply-To: <20181005084754.20950-13-kristina.martsenko@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-13-kristina.martsenko@arm.com>
Message-ID: <20181019113820.jly74g2kk3cxf3yp@mbp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2018 at 09:47:49AM +0100, Kristina Martsenko wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> To use pointer authentication in the kernel, we'll need to switch keys
> in the entry assembly. This patch moves the pointer auth keys into
> thread_info to make this possible.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>

Can we actually fold this into patch 7? It also leaves the door open to
allowing per-thread keys.

-- 
Catalin
