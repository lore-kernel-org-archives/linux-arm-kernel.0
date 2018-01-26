From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 26 Jan 2018 14:08:00 +0000
Subject: [PATCH 12/16] arm64: Add helpers for checking CPU MIDR against a
 range
In-Reply-To: <20180123122809.16269-13-suzuki.poulose@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-13-suzuki.poulose@arm.com>
Message-ID: <20180126140759.GT5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 12:28:05PM +0000, Suzuki K Poulose wrote:
> Add helpers for checking if the given CPU midr falls in a range
> of variants/revisions for a given model.

This doesn't describe what the patch does: instead, helpers are being
added for checking whether an MIDR falls in one of multiple affected
model(s) and or revision(s) here.

Doing this makes logical sense, but is it really worth it?

We might save 100-200 bytes in the kernel image for now, but a common
workaround for errata on multiple unrelated cpus is surely a rare case.

Only if there are many such lists, or if the lists become large does
this start to seem a clear win.

[...]

Cheers
---Dave
