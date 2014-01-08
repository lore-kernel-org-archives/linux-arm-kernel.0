From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 8 Jan 2014 12:28:26 -0800
Subject: [PATCH RFC 1/3] drivers: base: support cpu cache information
 interface to userspace via sysfs
In-Reply-To: <1389209168-17189-2-git-send-email-sudeep.holla@arm.com>
References: <1389209168-17189-1-git-send-email-sudeep.holla@arm.com>
 <1389209168-17189-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <20140108202826.GF8417@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 07:26:06PM +0000, Sudeep Holla wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> +#define define_one_ro(_name) \
> +static struct cache_attr _name = \
> +	__ATTR(_name, 0444, show_##_name, NULL)

In the future, we do have __ATTR_RO(), which should be used instead.
You should never use __ATTR() on it's own, if at all possible.  I'm
sweeping the tree for all usages and fixing them slowly up over time.

thanks,

greg k-h
