From: jeffrey.t.kirsher@intel.com (Jeff Kirsher)
Date: Wed, 21 Mar 2018 14:48:08 -0700
Subject: [PATCH REPOST v4 5/7] ixgbevf: keep writel() closer to wmb()
In-Reply-To: <1521658572-26354-6-git-send-email-okaya@codeaurora.org>
References: <1521658572-26354-1-git-send-email-okaya@codeaurora.org>
 <1521658572-26354-6-git-send-email-okaya@codeaurora.org>
Message-ID: <1521668888.12746.32.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-03-21 at 14:56 -0400, Sinan Kaya wrote:
> Remove ixgbevf_write_tail() in favor of moving writel() close to
> wmb().
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 5 -----
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++--
>  2 files changed, 2 insertions(+), 7 deletions(-)

This patch fails to compile because there is a call to
ixgbevf_write_tail() which you missed cleaning up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180321/05e83e9d/attachment.sig>
