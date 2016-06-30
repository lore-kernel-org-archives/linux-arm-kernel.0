From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 30 Jun 2016 11:22:31 +0200
Subject: [PATCH] arm64: tegra: Enable all cores on Jetson TX1
In-Reply-To: <20160630080119.27090-1-acourbot@nvidia.com>
References: <20160630080119.27090-1-acourbot@nvidia.com>
Message-ID: <20160630092231.GA1776@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2016 at 05:01:19PM +0900, Alexandre Courbot wrote:
> Enable PSCI firmware and all 4 cores of T210 on Jetson TX1.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> Not sure why this was not done - in any case this seems to work fine
> and performance is obviously improved (especially boot time).
> 
>  arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

The reason why this wasn't done initially is because the firmware was
supposed to copy this data into the device tree before passing it to the
kernel. The rationale for this decision was that we can't make any
assumptions about the firmware and any potential PSCI implementation.

I suppose the firmware interface could be argued to be part of the
hardware and therefore having it statically in DT would be okay. The one
remaining issue is that it is possible to boot a Tegra X1 without any
secure firmware that might provide PSCI, in which case the DT would now
be lying.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160630/a45956b2/attachment.sig>
