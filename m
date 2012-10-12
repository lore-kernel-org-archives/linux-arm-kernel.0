From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Oct 2012 10:08:07 +0100
Subject: [PATCH 2/2] ARM: unwind: enable dumping stacks for SMP &&
 ARM_UNWIND
In-Reply-To: <1346021216-21979-3-git-send-email-ccross@android.com>
References: <1346021216-21979-1-git-send-email-ccross@android.com>
 <1346021216-21979-3-git-send-email-ccross@android.com>
Message-ID: <20121012090807.GB21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 26, 2012 at 03:46:56PM -0700, Colin Cross wrote:
> Unwinding with CONFIG_ARM_UNWIND is much more complicated than
> unwinding with CONFIG_FRAME_POINTER, but there are only a few points
> that require validation in order to avoid faults or infinite loops.
> Avoiding faults is easy by adding checks to verify that all accesses
> relative to the frame's stack pointer remain inside the stack.
> 
> When CONFIG_FRAME_POINTER is not set it is possible for two frames to
> have the same SP, so there is no way to avoid repeated calls to
> unwind_frame continuing forever.

So here you admit that this patch can cause the unwinder to loop forever,
which would provide no way out of that.  Why do you think this patch is
suitable for mainline with such a problem?
