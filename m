From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 27 Apr 2016 15:33:08 -0700
Subject: [GIT PULL] SoCFPGA fixes for v4.6-rc5
In-Reply-To: <1461684244-6112-1-git-send-email-dinguyen@kernel.org> (Dinh
 Nguyen's message of "Tue, 26 Apr 2016 10:24:04 -0500")
References: <1461684244-6112-1-git-send-email-dinguyen@kernel.org>
Message-ID: <7h8tzyiswr.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dinh Nguyen <dinguyen@kernel.org> writes:

> Please pull in these fixes for v4.6-rc5. The first patch "ARM: SoCFPGA: Fix
> secondary CPU startup in thumb2 kernel" is a true fix for enabling CPU1 in
> thumb2 mode, but the second patch "ARM: SoCFPGA: simplify secondary trampoline"
> may not be a true fix, but it is dependent on the first patch. I didn't want
> to cause any conflicts.

IIUC, the 2nd one (simplify) seems to be dependent on the first (fix),
but doesn't seem to be appropriate for this late stage of the -rc cycle,
so I've applied the first one only.  Please include the 2nd one with
your v4.7 updates.

I also verified on my socfpga board that the 2nd CPU does indeed come up
with this patch when building with THUMB2_KERNEL=y.

Thanks,

Kevin
