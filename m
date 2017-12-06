From: eric@anholt.net (Eric Anholt)
Date: Wed, 06 Dec 2017 13:53:42 -0800
Subject: [PATCH V2] ARM: dts: bcm283x: Fix probing of bcm2835-i2s
In-Reply-To: <1511717111-6055-1-git-send-email-stefan.wahren@i2se.com>
References: <1511717111-6055-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <87po7rr09l.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Since 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
> the bcm2835-i2s requires a clock as DT property. Unfortunately
> the necessary DT change has never been applied. While we are at it
> also fix the first PCM register range to cover the PCM_GRAY register.
>
> This patch also fixes the dt-bindings accordlingly.
>
> Fixes: 517e7a1537a ("ASoC: bcm2835: move to use the clock framework")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> Tested-by: Matthias Reichl <hias@horus.com>

DT folks, are you happy with the binding change here?  It fixes having
the i2s node also map a very separate hardware block (clocks) which has
its own DT node.

The I2S node is disabled in the upstream DT files.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171206/e6d75109/attachment.sig>
