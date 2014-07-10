From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 10 Jul 2014 15:43:30 +0200
Subject: [PATCH 15/16] i2c: i2c-tegra: Drop class based scanning to
 improve bootup time
In-Reply-To: <1404992799-3705-16-git-send-email-wsa@the-dreams.de>
References: <1404992799-3705-1-git-send-email-wsa@the-dreams.de>
 <1404992799-3705-16-git-send-email-wsa@the-dreams.de>
Message-ID: <20140710134329.GB14961@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 01:46:35PM +0200, Wolfram Sang wrote:
> This driver has been flagged to drop class based instantiation. The removal
> improves boot-up time and is unneeded for embedded controllers. Users have been
> warned to switch for some time now, so we can actually do the removal. Keep the
> DEPRECATED flag, so the core can inform users that the behaviour finally
> changed now. After another transition period, this flag can go, too.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/i2c/busses/i2c-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

It looks as though this currently doesn't do anything on !X86 anyway and
I'll trust Mikko's testing, so:

Acked-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140710/3f42c59f/attachment-0001.sig>
