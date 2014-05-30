From: trini@ti.com (Tom Rini)
Date: Fri, 30 May 2014 09:22:08 -0400
Subject: [PATCHv2 4/4] arm64: Enable TEXT_OFFSET fuzzing
In-Reply-To: <1401196710-6290-5-git-send-email-mark.rutland@arm.com>
References: <1401196710-6290-1-git-send-email-mark.rutland@arm.com>
 <1401196710-6290-5-git-send-email-mark.rutland@arm.com>
Message-ID: <20140530132208.GA5836@bill-the-cat>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 02:18:30PM +0100, Mark Rutland wrote:

> The arm64 Image header contains a text_offset field which bootloaders
> are supposed to read to determine the offset (from a 2MB aligned "start
> of memory" per booting.txt) at which to load the kernel. The offset is
> not well respected by bootloaders at present, and due to the lack of
> variation there is little incentive to support it. This is unfortunate
> for the sake of future kernels where we may wish to vary the text offset
> (even zeroing it).
> 
> This patch adds options to arm64 to enable fuzz-testing of text_offset.
> CONFIG_ARM64_RANDOMIZE_TEXT_OFFSET forces the text offset to a random
> 16-byte aligned value value in the range [0..2MB) upon a build of the
> kernel. It is recommended that distribution kernels enable randomization
> to test bootloaders such that any compliance issues can be fixed early.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Tom Rini <trini@ti.com>

-- 
Tom
