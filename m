From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Dec 2010 23:37:32 +0000
Subject: [PATCH] ARM: Stop irqsoff trace on return to user
In-Reply-To: <1291434107-17713-1-git-send-email-toddpoynor@google.com>
References: <1291434107-17713-1-git-send-email-toddpoynor@google.com>
Message-ID: <20101222233732.GC29368@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 03, 2010 at 07:41:47PM -0800, Todd Poynor wrote:
> If the irqsoff tracer is in use, stop tracing the interrupt disable
> interval when returning to userspace.  Tracing userspace execution
> time as interrupts disabled time is not useful for kernel
> performance analysis purposes, and crowds out more helpful results
> with long userspace execution times.  Some other architectures do
> something similar.
> 
> Only do so if the irqsoff tracer is enabled, to avoid overhead for
> lockdep, which doesn't care about userspace execution time with
> interrupts disabled.

Ok, can you send this to the patch system please?
