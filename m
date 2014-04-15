From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Apr 2014 21:42:01 +0100
Subject: [PATCH 3/4] mmc: sdhci: defer probing on
 regulator_get_optional() failures
In-Reply-To: <CAL1qeaEGpz-9rOtp4fAHFz8KG2fCscFsqu1tbi2d9mxTM8yHQQ@mail.gmail.com>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
 <1397526163-20126-4-git-send-email-abrestic@chromium.org>
 <534D7A5D.9090707@wwwdotorg.org>
 <CAL1qeaEGpz-9rOtp4fAHFz8KG2fCscFsqu1tbi2d9mxTM8yHQQ@mail.gmail.com>
Message-ID: <20140415204201.GW24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 12:59:37PM -0700, Andrew Bresticker wrote:
> I believe the crash Alex is seeing is due to a race between tearing
> down the sdhci driver on probe deferral and the card-detect IRQ.
> Looking at it now.

You probably want to check out my massive sdhci patch set posted a
while back.

http://www.spinics.net/lists/linux-mmc/msg25031.html

I'll re-post it again soon (probably next week as I'm rather busy),
updated to v3.15-rc1.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
