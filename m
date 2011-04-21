From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 21 Apr 2011 20:11:56 +0300
Subject: [PATCH] Enhanced ethtool API of CPSW driver in order to be able
	to address even more than one PHY.
In-Reply-To: <1303402638-29884-1-git-send-email-sven.fischer@snom.com>
References: <1303402638-29884-1-git-send-email-sven.fischer@snom.com>
Message-ID: <20110421165014.GA2035@nataf.siach.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sven,

On Thu, Apr 21, 2011 at 06:17:18PM +0200, Sven Fischer wrote:
> Linked ethtool ioctls ETHTOOL_GSET and ETHTOOL_SSET to the CPSW switch driver and added a new ioctl ETHTOOL_GPHYLINK.
> 
> The new ETHTOOL_GPHYLINK, which gets the PHY link status of a specific PHY, makes ETHTOOL_GLINK obsolete, because it was not working PHY specific.
> 
> ETHTOOL_GSET and ETHTOOL_SSET ioctls are now able to access a specific PHY as well.

A few comments:

1. Please wrap the patch description lines at 80 characters

2. You should Cc the networking devices mailing list at netdev at vger.kernel.org 
   on this patch

3. Please separate changes to generic code (like ethtool, phy) from changes to 
   a specific driver (like cpsw).

By the way, this cpsw driver does not appear to exist in the current mainline 
kernel. When sending a patch against a development tree, please specify which 
one.

baruch

> ---
>  drivers/net/cpsw.c      |   53 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/phy/phy.c   |    9 ++++++++
>  include/linux/ethtool.h |   12 +++++++++-
>  include/linux/phy.h     |    1 +
>  net/core/ethtool.c      |   28 ++++++++++++++++++++++++-
>  5 files changed, 101 insertions(+), 2 deletions(-)

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
