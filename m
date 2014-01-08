From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 8 Jan 2014 12:26:13 -0800
Subject: [PATCH RFC 1/3] drivers: base: support cpu cache information
 interface to userspace via sysfs
In-Reply-To: <1389209168-17189-2-git-send-email-sudeep.holla@arm.com>
References: <1389209168-17189-1-git-send-email-sudeep.holla@arm.com>
 <1389209168-17189-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <20140108202613.GD8417@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 07:26:06PM +0000, Sudeep Holla wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> This patch adds initial support for providing processor cache information
> to userspace through sysfs interface. This is based on x86 implementation
> and hence the interface is intended to be fully compatible.
> 
> A per-cpu array of cache information maintained is used mainly for
> sysfs-related book keeping.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/base/Makefile     |   2 +-
>  drivers/base/cacheinfo.c  | 296 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/cacheinfo.h |  43 +++++++
>  3 files changed, 340 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/base/cacheinfo.c
>  create mode 100644 include/linux/cacheinfo.h

You are creating sysfs files, yet you didn't add Documentation/ABI/
information, which is required.  Please fix that.

greg k-h
