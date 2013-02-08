From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 8 Feb 2013 11:15:25 +0000
Subject: [PATCH] regulator: anatop: improve precision of delay time
In-Reply-To: <1359944492-23130-1-git-send-email-shawn.guo@linaro.org>
References: <1359944492-23130-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130208111525.GH8879@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 10:21:32AM +0800, Shawn Guo wrote:
> For cpufreq example, it takes 13 steps (25 mV for one step) to increase
> vddcore from 0.95 V to 1.275 V, and the time of 64 clock cycles at
> 24 MHz for one step is ~2.67 uS, so the total delay time would be
> ~34.71 uS.  But the current calculation in the driver gives 39 uS.
> Change the formula to have the addition of 1 be the last step, so that
> we can get a more precise delay time.  For example above, the new
> formula will give 35 uS.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130208/71daea00/attachment.sig>
