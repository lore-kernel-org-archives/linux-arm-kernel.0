From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 28 Mar 2010 22:52:19 +0100
Subject: [PATCH] ARM: Use the correct NOP size in memmove for Thumb-2
	kernel builds
In-Reply-To: <20100326111122.1066.8244.stgit@e102109-lin.cambridge.arm.com>
References: <20100326111122.1066.8244.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100328215219.GB8614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 11:11:22AM +0000, Catalin Marinas wrote:
> When compiling the kernel to Thumb-2, using a 16-bit NOP in the
> memmove() implementation causes the preceding ADD PC instruction to
> branch incorrectly in the middle of a 32-bit LDR or STR instruction. The
> memmove() code is no similar to the memcpy() template.

Ok.
