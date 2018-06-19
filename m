From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Jun 2018 15:41:43 +0100
Subject: next/master boot: 138 boots: 8 failed, 112 passed with 18
 offline (next-20180619)
In-Reply-To: <69c0adb9-b784-4f73-fcc9-ff1a01ce27c5@arm.com>
References: <5b290c6d.1c69fb81.fc936.98ee@mx.google.com>
 <20180619141324.GD11230@sirena.org.uk>
 <69c0adb9-b784-4f73-fcc9-ff1a01ce27c5@arm.com>
Message-ID: <20180619144143.GE11230@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 03:22:47PM +0100, Sudeep Holla wrote:

> Based on the logs from successful boots, I see it's CPUFreq that gets
> probed after fan53555-reg. I also see that it warns about unlisted OPPs
> in the successful boots. I guess, the undefined instruction could occur
> if there's issue with CPU DVFS(under voltage or frequency that's not
> supported). I don't have much knowledge on the platform, I am just
> guessing on the possible cause here.

Yeah, that was my guess - either an out of spec voltage/frequency was
selected or the regulator isn't able to keep up with the voltage
transition or a load spike and the power browns out.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180619/cd40b399/attachment.sig>
