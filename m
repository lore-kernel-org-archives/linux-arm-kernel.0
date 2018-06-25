From: msalter1887@gmail.com (Mark Salter)
Date: Mon, 25 Jun 2018 11:34:40 -0400
Subject: [PATCH] arm64/acpi: Add fixup for HPE m400 quirks
In-Reply-To: <0be5ce017286a4ec494e0f0969bb10126b8501ce.camel@redhat.com>
References: <51d3d738-cdf5-2992-bba5-c3e1f34096c2@infradead.org>
 <098e6d53-8dc7-439f-7165-adbe0e7c4941@arm.com>
 <8a3034b9-6cf3-5182-717f-dd1dc8a087aa@infradead.org>
 <5b03f754-3a98-c01d-3e2a-615a8b1ea537@arm.com>
 <0cbc68d5-9a8f-1734-4eea-d1f037927137@infradead.org>
 <cb5aa4ee12422ecc5f6530f3a74bcfa553b42c80.camel@redhat.com>
 <a59fa0f8-4123-bcd9-670a-8885d34f37ed@arm.com>
 <0be5ce017286a4ec494e0f0969bb10126b8501ce.camel@redhat.com>
Message-ID: <bd5fc825573c3394b80365ad2dc47bde7b22044a.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-06-22 at 11:19 -0400, Mark Salter wrote:
> I'm going to hack something to get to the ghes info earlier in boot and
> check the things you mention above wrt Error Status Block and GHES.0.

So I had to end up instrumenting the EFI stub to see where the error came
from. At the start of the stub, there is no GHES.2 error. The error first
shows up after the stub's call to ExitBootServices returns. So it looks
like the firmware itself is causing the error. There's still a chance that
the stub is doing something wrong with the memory map passed to the
firmware, so I'll try to eliminate that as well.
