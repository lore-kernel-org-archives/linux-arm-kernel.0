From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 29 Mar 2012 12:29:49 +0100
Subject: [PATCH] ASoC: fsl: enable ssi clock in probe function
In-Reply-To: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120329112949.GM3668@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2012 at 10:53:41AM +0800, Shawn Guo wrote:
> For power saving, most IMX platform initilization code turns off
> modules' clock, and expects driver turn on clock as needed.

Applied, thanks (though checking return codes would be nice).  

Ideally you'd be able to enable the clocks only when needed at runtime
though the power savings would doubtless be very small, pm_runtime
callbacks might be helpful.  Having the clocks present on PowerPC (even
if just dummy) so we don't have the conditional code would also be nice.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120329/5c1f2aaf/attachment.sig>
