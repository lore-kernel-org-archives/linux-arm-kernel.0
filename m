From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 17 Jul 2015 11:57:55 +0200
Subject: [PATCH V3 02/19] memory: tegra: Add MC flush support
In-Reply-To: <1436791197-32358-3-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-3-git-send-email-jonathanh@nvidia.com>
Message-ID: <20150717095754.GG3057@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 01:39:40PM +0100, Jon Hunter wrote:
> The Tegra memory controller implements a flush feature to flush pending
> accesses and prevent further accesses from occurring. This feature is
> used when powering down IP blocks to ensure the IP block is in a good
> state. The flushes are organised by software groups and IP blocks are
> assigned in hardware to the different software groups. Add helper
> functions for requesting a handle to an MC flush for a given
> software group and enabling/disabling the MC flush itself.
> 
> This is based upon a change by Vince Hsu <vinceh@nvidia.com>.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/memory/tegra/mc.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/memory/tegra/mc.h |   2 +
>  include/soc/tegra/mc.h    |  34 ++++++++++++++
>  3 files changed, 146 insertions(+)

Do we know if this is actually necessary? I remember having a discussion
with Arnd Bergmann a while ago, and the Linux driver model kind of
assumes that by the time a device is disabled all outstanding accesses
will have stopped.

Do we have a way to determine that this even makes a difference? Can we
trigger a case where not doing this would cause breakage and see that
adding this fixes that particular issue?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150717/ffe99bd6/attachment.sig>
