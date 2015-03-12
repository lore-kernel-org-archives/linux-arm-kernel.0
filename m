From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 12 Mar 2015 13:45:02 +0100
Subject: [PATCH v2 17/17] soc/tegra: remove lagacy powergate APIs
In-Reply-To: <1426162518-7405-18-git-send-email-vinceh@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
 <1426162518-7405-18-git-send-email-vinceh@nvidia.com>
Message-ID: <20150312124501.GA632@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 08:15:18PM +0800, Vince Hsu wrote:
> We switch to generic power domain now. So remove the legacy functions.
> 
> Signed-off-by: Vince Hsu <vinceh@nvidia.com>
> ---
>  drivers/soc/tegra/pmc.c | 68 -------------------------------------------------
>  include/soc/tegra/pmc.h | 22 ----------------
>  2 files changed, 90 deletions(-)

I don't think we can do this. What if somebody updates their kernel but
not the DTB? In that case they'll end up with drivers that don't enable
power partitions but at the same time the powergate driver won't enable
them either because it is missing the corresponding nodes in the DTB.

What we'll have to do is probably keep the code that enables the power
partitions and make it conditional on the power domains somehow. Is
there a way to determine at runtime whether a device has been attached
to a power domain?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150312/c7f4acbc/attachment.sig>
