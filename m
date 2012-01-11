From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Jan 2012 16:57:58 +0000
Subject: [PATCH 0/7] at91 : pm.h cleanups
In-Reply-To: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20120111165758.GE1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 03:55:33PM +0100, Daniel Lezcano wrote:
> This patchset is the first series to cleanup some code around pm.h, pm.c and
> cpuidle. The next series will bring more cleanups and finally the third series
> will change the different functions into ops where we can export the structure
> definition in order to encapsulate the code and move the at91's cpuidle driver
> to the drivers/cpuidle directory.

Really this isn't an improvement.  Either the current code is complete
bollocks with respect to draining the write buffer, or this patch set
introduces bugs.

Please sort this out using the second solution I referred to - which
also fixes this part of the code wrt allowing several AT91 SoCs to
co-exist in the same kernel binary.
