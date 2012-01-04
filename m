From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jan 2012 22:10:36 +0000
Subject: [PATCH 1/2][RFC] at91 : move pm.h header to include/mach
In-Reply-To: <4F048CD9.1050601@gmail.com>
References: <1325696147-14058-1-git-send-email-daniel.lezcano@linaro.org>
 <4F048CD9.1050601@gmail.com>
Message-ID: <20120104221036.GK11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 11:31:05AM -0600, Rob Herring wrote:
> This header should probably be named something more specific like
> at91_pm.h or at91_sdram.h. This will be needed to avoid name collisions
> with mach headers on a single kernel binary.

I think actually the idea that mach/*.h headers can be included by stuff
outside of arch/arm is something that we should deprecate, because it's
not going to be sane to make them all unique in this way.

Not only that but it prevents the .c files being built on other
architectures, and provides another reason why the .c file is tied to
a pariticular SoC - even if the same IP is used in a different SoC, it
can be used as a reason why not to reuse the .c file.

Let's not give people excuses not to share code!
