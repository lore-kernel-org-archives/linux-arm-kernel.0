From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 4 Apr 2017 16:02:13 +0200
Subject: [PATCH V3 6/6] soc/tegra: Add initial flowctrl support for
 Tegra132/210
In-Reply-To: <1490704978-22906-7-git-send-email-jonathanh@nvidia.com>
References: <1490704978-22906-1-git-send-email-jonathanh@nvidia.com>
 <1490704978-22906-7-git-send-email-jonathanh@nvidia.com>
Message-ID: <20170404140213.GI843@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 01:42:58PM +0100, Jon Hunter wrote:
> Tegra132 and Tegra210 support the flowctrl module and so add initial
> support for these devices.
> 
> Please note that Tegra186 does not support the flowctrl module, so
> update the initialisation function such that we do not fall back and
> attempt to map the 'hardcoded' address range for Tegra186. Furthermore
> 64-bit Tegra devices have always had the flowctrl node defined in their
> device-tree and so only use the 'hardcoded' addresses for 32-bit Tegra
> devices.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/soc/tegra/Kconfig    |  2 ++
>  drivers/soc/tegra/flowctrl.c | 31 +++++++++++++++++++++----------
>  2 files changed, 23 insertions(+), 10 deletions(-)

Applied to for-4.12/soc, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170404/114f3a9a/attachment.sig>
